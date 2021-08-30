# Retrieve rideshare dataset
library(dplyr)   # install.packages("dplyr")
library(purrr)   # install.packages("purrr")
library(tibble)  # install.packages("tibble")
library(tidyr)   # install.packages("tidyr")
library(tsibble) # install.packages("tsibble")


# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/5122114/files/rideshare_dataset_with_missing_values.zip"
local_file <- here::here("data-raw", "rideshare", basename(url_zip))
#===============================================================================

download.file(url_zip, destfile = local_file)
unzip(zipfile = local_file, exdir = dirname(local_file))
file.remove(local_file)

rideshare <-
  read_tsf(paste0(dirname(local_file), "/", "rideshare_dataset_with_missing_values.tsf"),
           key = "series_name") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(-series_name) %>%
  rename(timestamp = start_timestamp) %>%
  pivot_wider(names_from = type, values_from = series_value)

# local_rds <- here::here("data-raw", "rideshare", "rideshare.rds")
# saveRDS(rideshare, file = local_rds)
#  readRDS(file = local_rds)

rideshare_dictionary <- describe_dataset(
  rideshare,
  .title = "Hourly Rideshare Service Data",
  timestamp = "Datetime of observation",
  demand = "Electricity demand (GW)" # https://otexts.com/fpp2/complexseasonality.html
)

usethis::use_data(
  rideshare,
  rideshare_dictionary,
  overwrite = TRUE
)
