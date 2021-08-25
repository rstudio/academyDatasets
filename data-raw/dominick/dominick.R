# Setup ----
pkgload::load_all()
library(archive)   # install.packages("archive")
library(dplyr)     # install.packages("dplyr")
library(incase)    # install.packages("incase")
library(lubridate) # install.packages("lubridate")
library(magrittr)  # install.packages("magrittr")
library(readr)     # install.packages("readr")
library(purrr)     # install.packages("purrr")
library(stringr)   # install.packages("stringr")
library(tsibble)   # install.packages("tsibble")

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
