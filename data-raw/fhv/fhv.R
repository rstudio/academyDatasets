pkgload::load_all()
library(archive)
library(dplyr)
library(purrr)
library(tsibble)
library(stringr)

url <- "https://zenodo.org/record/5122537/files/vehicle_trips_dataset_without_missing_values.zip"

fhv_raw <- archive::archive_read(url) %>%
  read_tsf(key = "series_name") %>%
  pluck(1) %>%
  as_tibble() %>%
  mutate(
    base_number = str_replace(base_number, "b", "B"),
    base_name = str_remove(base_name, "\\.$")
  )

trips <-
  fhv_raw %>%
  filter(type == "trips") %>%
  select(date = start_timestamp, base_number, base_name, trips = series_value)

vehicles <-
  fhv_raw %>%
  filter(type == "vehicles") %>%
  select(date = start_timestamp, base_number, base_name, vehicles = series_value)

fhv <- full_join(trips, vehicles)

fhv_dictionary <- describe_dataset(
  fhv,
  .title    = "For-hire Vehicle (FHV) Trips",
  date      = "Date",
  base_number = "Unique ID of the TLC base company",
  base_name = "Name of the TLC base company",
  trips = "Number of trips",
  vehicles = "Number of vehicles available"
)

usethis::use_data(
  fhv,
  fhv_dictionary,
  overwrite = TRUE
)
