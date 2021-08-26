# Retrieve Elecdemand dataset
library(dplyr)   # install.packages("dplyr")
library(purrr)   # install.packages("purrr")
library(tibble)  # install.packages("tibble")
library(tidyr)   # install.packages("tidyr")
library(tsibble) # install.packages("tsibble")


# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/4656069/files/elecdemand_dataset.zip"
local_file <- here::here("data-raw", "elec_demand", basename(url_zip))
#===============================================================================

download.file(url_zip, destfile = local_file)
unzip(zipfile = local_file, exdir = dirname(local_file))
file.remove(local_file)

elec_demand <-
  read_tsf(paste0(dirname(local_file), "/", "elecdemand_dataset.tsf"),
           key = "series_name") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(timestamp = start_timestamp, demand = series_value)

elec_demand_dictionary <- describe_dataset(
  elec_demand,
  .title = "Victoria, Australia Electricity Demand Data",
  timestamp = "Datetime of observation",
  demand = "Electricity demand (GW)" # https://otexts.com/fpp2/complexseasonality.html
)

usethis::use_data(
  elec_demand,
  elec_demand_dictionary,
  overwrite = TRUE
)
