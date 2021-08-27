# Retrieve Electricity Weekly dataset
library(dplyr)   # install.packages("dplyr")
library(purrr)   # install.packages("purrr")
library(stringr)   # install.packages("stringr")
library(tibble)  # install.packages("tibble")
library(tidyr)   # install.packages("tidyr")
library(tsibble) # install.packages("tsibble")


# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/4656141/files/electricity_weekly_dataset.zip"
local_file <- here::here("data-raw", "electricity_weekly", basename(url_zip))
#===============================================================================

download.file(url_zip, destfile = local_file)
unzip(zipfile = local_file, exdir = dirname(local_file))
file.remove(local_file)

electricity_weekly <-
  read_tsf(paste0(dirname(local_file), "/", "electricity_weekly_dataset.tsf"),
           key = "series_name") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(client = series_name, date = start_timestamp, power = series_value) %>%
  mutate(client = str_replace(client, "T", "EC"))


electricity_weekly_dictionary <- describe_dataset(
  electricity_weekly,
  .title = "Weekly Electricity Consumption",
  client = "ID of the electric company client",
  date = "Date",
  power = "Weekly electricity consumption, in kilowatts (kW)"
)

usethis::use_data(
  electricity_weekly,
  electricity_weekly_dictionary,
  overwrite = TRUE
)
