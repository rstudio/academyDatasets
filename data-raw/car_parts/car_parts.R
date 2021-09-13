# Retrieve Car Parts dataset
library(dplyr)   # install.packages("dplyr")
library(purrr)   # install.packages("purrr")
library(stringr) # install.packages("stringr")
library(tibble)  # install.packages("tibble")
library(tidyr)   # install.packages("tidyr")
library(tsibble) # install.packages("tsibble")


# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/4656022/files/car_parts_dataset_with_missing_values.zip"
local_file <- here::here("data-raw", "car_parts", basename(url_zip))
#===============================================================================

download.file(url_zip, destfile = local_file)
unzip(zipfile = local_file, exdir = dirname(local_file))
file.remove(local_file)

car_parts <-
  read_tsf(paste0(dirname(local_file), "/", "car_parts_dataset_with_missing_values.tsf"),
           key = "series_name") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(part_num = series_name, date = start_timestamp, qty = series_value) %>%
  mutate(
    part_num = str_replace(part_num, "T", "P"),
    qty = as.integer(qty)
  )


car_parts_dictionary <- describe_dataset(
  car_parts,
  .title = "Monthly Car Part Sales",
  part_num = "ID of the car part",
  date = "Start date of the month",
  qty = "Number of parts sold that month"
)

usethis::use_data(
  car_parts,
  car_parts_dictionary,
  overwrite = TRUE
)
