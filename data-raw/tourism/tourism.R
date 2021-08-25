pkgload::load_all()
library(archive) # install.packages("archive")
library(dplyr)   # install.packages("dplyr")
library(incase)  # install.packages("incase")
library(purrr)   # install.packages("purrr")
library(readr)   # install.packages("readr")
library(stringr) # install.packages("stringr")
library(tidyr)   # install.packages("tidyr")
library(tsibble) # install.packages("tsibble")

cities_url <-
  "https://simplemaps.com/static/data/world-cities/basic/simplemaps_worldcities_basicv1.74.zip"

cities <- archive::archive_read(cities_url, 2) %>%
  read_csv() %>%
  arrange(desc(population)) %>%
  select(city = city_ascii, country) %>%
  group_by(country) %>%
  mutate(cum_country = row_number()) %>%
  filter(cum_country < 7) %>%
  ungroup() %>%
  select(-cum_country) %>%
  mutate(
    country = country %>%
      str_replace(", The", "") %>%
      str_replace(" And ", " and ") %>%
      str_replace(" The ", " the ") %>%
      str_replace(" Of ", " of ") %>%
      switch_case(
        "Korea, South"        ~ "South Korea",
        "Congo (Kinshasa)"    ~ "Democratic Republic of the Congo",
        "Côte D’Ivoire"       ~ "Cote d'Ivoire",
        "Korea, North"        ~ "North Korea",
        "Congo (Brazzaville)" ~ "Republic of the Congo",
        "Curaçao"             ~ "Curacao",
        "Swaziland"           ~ "Eswatini",
        preserve = TRUE
      ),
    id = row_number()
  )

tourism_url <-
  "https://zenodo.org/record/4656096/files/tourism_monthly_dataset.zip"

tourism_raw <- archive::archive_read(tourism_url) %>%
  read_tsf(key = "series_name") %>%
  pluck(1)

tourism <- tourism_raw %>%
  rename(
    month = start_timestamp, series = series_name, tourists = series_value
  ) %>%
  mutate(tourists = as.integer(tourists)) %>%
  as_tibble() %>%
  group_by(series) %>%
  mutate(max_tourists = max(tourists)) %>%
  group_by(max_tourists, .add = TRUE) %>%
  group_nest() %>%
  arrange(desc(max_tourists)) %>%
  mutate(id = row_number()) %>%
  select(-max_tourists) %>%
  unnest(data) %>%
  left_join(cities, by = "id") %>%
  arrange(series) %>%
  select(month, city, country, tourists)

tourism_dictionary <- describe_dataset(
  tourism,
  .title = "366 monthly time series used in the Kaggle Tourism forecasting competition",
  month = "Start date of the month",
  city = "Fabricated city",
  country = "Fabricated country",
  tourists = "Number of tourists who visited the location in the specified month"
)

usethis::use_data(tourism, tourism_dictionary, overwrite = TRUE)
