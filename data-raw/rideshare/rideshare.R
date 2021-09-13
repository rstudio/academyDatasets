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
  pivot_wider(names_from = type, values_from = series_value) %>%
  mutate(api_calls = as.integer(api_calls))

local_rds <- here::here("data-raw", "rideshare", "rideshare.rds")
saveRDS(rideshare, file = local_rds)
#  readRDS(file = local_rds)

rideshare_dictionary <- describe_dataset(
  rideshare,
  .title = "Hourly Summaries of Rideshare Service Data",
  source_location = "Starting point of the ride",
  provider_name = "Rideshare service provider",
  provider_service = "Provider-specific ride type identifier",
  timestamp = "Hour",
  price_min = "Minimum price estimate for rides in USD",
  price_mean = "Mean price estimate for rides in USD",
  price_max = "Maxmimum price estimate for rides in USD",
  distance_min = "Minimum Distance between source and destination",
  distance_mean = "Mean Distance between source and destination",
  distance_max = "Maximum Distance between source and destination",
  surge_min = "Minimum multiplier by which price was increased, default 1",
  surge_mean = "Mean multiplier by which price was increased, default 1",
  surge_max = "Maximum multiplier by which price was increased, default 1",
  api_calls = "Number of API calls in the hour",
  temp = "Temperature (F)",
  rain = "Rain in the last hour (inches)",
  humidity = "Humidity (%)",
  clouds = "Cloud cover (0-1)",
  wind = "Wind speed (mph)"
)

usethis::use_data(
  rideshare,
  rideshare_dictionary,
  overwrite = TRUE
)
