pkgload::load_all()
library(archive)
library(dplyr)
library(purrr)
library(stringr)
library(tsibble)

url <- "https://zenodo.org/record/4656151/files/solar_weekly_dataset.zip"

solar <- archive::archive_read(url) %>%
  read_tsf(key = "series_name") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(plant = series_name, date = start_timestamp, power = series_value) %>%
  mutate(plant = str_replace(plant, "T", "PV"))

solar_dictionary <- describe_dataset(
  solar,
  .title = "Solar Power Production",
  plant  = "ID of the photovoltaic (PV) power plant",
  date   = "Date",
  power  = "Solar power capacity, in megawatts (MW)"
)

usethis::use_data(
  solar,
  solar_dictionary,
  overwrite = TRUE
)
