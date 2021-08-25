# Setup ----
pkgload::load_all()
library(archive) # install.packages("archive")
library(dplyr)
library(fauxnaif) # install.packages("fauxnaif")
library(haven)
library(incase) # install.packages("incase")
library(lubridate)
library(magrittr)
library(readr)
library(purrr)
library(stringr)
library(tsibble) # install.packages("tsibble")

# Department sales ----

dominick_url <-
  "https://www.chicagobooth.edu/boothsitecore/docs/dff/store-demos-customer-count/ccount_stata.zip"

dominick_raw <- archive::archive_read(dominick_url) %>%
  read_dta()

dominick <- dominick_raw %>%
  filter(
    str_detect(date, "\\d{6}"),
    store %in% c(
      2, 4:5, 8:9, 12, 14, 18:19, 21, 25, 28, 32:33, 39:40, 44:56, 59:60, 62,
      64:65, 67:78, 80:81, 83:84, 86, 88:95, 97:98, 100:119, 121:124, 126,
      128:134, 137, 139
    )
  ) %>%
  select(
    date, store, custcoun, grocery, gm,
    everything(), -mvpclub, -week, -promo, -bottle, -bulk, -convfood,
    -ends_with("coup"), -ends_with("cp"),  -starts_with("ftg"),
    -matches("deli."), -matches("meat."), -matches("video.")
  ) %>%
  mutate(
    store    = switch_case(store, 69 ~ 137, preserve = TRUE),
    date     = paste0("19", date) %>% as.Date("%Y%m%d"),
    custcoun = as.integer(custcoun),
    across(where(is.numeric), na_if_in, ~ . < 0)
  )

dominick_dictionary <- describe_dataset(
  dominick,
  .title = "Dominick's Finer Foods department sales data",
  date = "Date",
  store = "Store number",
  custcoun = "Number of customers",
  grocery = "Non-specialty grocery sales in dollars",
  gm = "General merchandising sales in dollars",
  dairy = "Dairy sales in dollars",
  frozen = "Frozen food sales in dollars",
  meat = "Meat sales in dollars",
  fish = "Fish sales in dollars",
  produce = "Produce sales in dollars",
  saladbar = "Salad bar sales in dollars",
  floral = "Floral sales in dollars",
  deli = "Deli sales in dollars",
  cheese = "Cheese case sales in dollars",
  bakery = "Bakery sales in dollars",
  pharmacy = "Pharmacy sales in dollars",
  jewelry = "Jewelry sales in dollars",
  cosmetics = "Cosmetics sales in dollars",
  haba = "Health and beauty aids sales in dollars",
  camera = "Camera sales in dollars",
  photofin = "Photo development sales in dollars",
  video = "Video sales in dollars",
  beer = "Beer sales in dollars",
  wine = "Wine sales in dollars",
  spirits = "Alcoholic spirits sales in dollars"
)

usethis::use_data(
  dominick, dominick_dictionary, overwrite = TRUE
)

# Product sales ----

read_dominick <- function(upc_url, movement_url) {
  upc <- read_csv(upc_url) %>%
    rename_with(tolower) %>%
    select(upc, product = descrip, size) %>%
    mutate(product = gsub("[^A-Z ]", "", product))

  archive::archive_read(movement_url) %>%
    read_csv() %>%
    rename_with(tolower) %>%
    filter(as.logical(ok), price != 0) %>%
    mutate(
      price = round(price / qty, 2),
      profit = profit / 100,
      move = as.integer(move),
      store = as.integer(store),
      week = ymd("1989-07-09") + weeks(week)
    ) %>%
    left_join(upc, by = "upc") %>%
    select(week, store, product, size, move, price, profit) %>%
    group_by(week, store, product, size, price) %>%
    summarize(
      profit = round(weighted.mean(profit, move), 2),
      move   = sum(move)
    ) %>%
    ungroup()
}

## Oatmeal ----
dominick_oatmeal <- read_dominick(
  "https://www.chicagobooth.edu/-/media/enterprise/centers/kilts/datasets/dominicks-dataset/upc_csv-files/upcoat.csv",
  "https://www.chicagobooth.edu/-/media/enterprise/centers/kilts/datasets/dominicks-dataset/movement_csv-files/woat.zip"
)

dominick_oatmeal_dictionary <- describe_dataset(
  dominick_oatmeal,
  .title = "Dominick's Finer Foods oatmeal sales data",
  week = "Start date of the week",
  store = "Store number",
  product = "Abbreviated product name",
  size = "Product size",
  price = "Price per unit in dollars",
  profit = "Profit per unit in dollars",
  move = "Number of units sold during the week"
)

usethis::use_data(
  dominick_oatmeal, dominick_oatmeal_dictionary, overwrite = TRUE
)

## Bath soap ----
dominick_soap <- read_dominick(
  "https://www.chicagobooth.edu/-/media/enterprise/centers/kilts/datasets/dominicks-dataset/upc_csv-files/upcbat.csv",
  "https://www.chicagobooth.edu/-/media/enterprise/centers/kilts/datasets/dominicks-dataset/movement_csv-files/wbat.zip"
)

dominick_soap_dictionary <- describe_dataset(
  dominick_soap,
  .title = "Dominick's Finer Foods bath soap sales data",
  week = "Start date of the week",
  store = "Store number",
  product = "Abbreviated product name",
  size = "Product size",
  price = "Price per unit in dollars",
  profit = "Profit per unit in dollars",
  move = "Number of units sold during the week"
)

usethis::use_data(
  dominick_soap, dominick_soap_dictionary, overwrite = TRUE
)
