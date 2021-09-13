# Read in Aus. electricity data

library(tidyverse)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/4659727/files/australian_electricity_demand_dataset.zip?download=1"

#===============================================================================

temp <- "data-raw/aus_electricity/temp.zip"
download.file(url_zip, destfile = temp)
unzip(zipfile = "data-raw/aus_electricity/temp.zip", exdir = fs::path_dir(temp))
file.remove(temp)

aus_electricity <-
  read_tsf("data-raw/aus_electricity/australian_electricity_demand_dataset.tsf") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(
    date = start_timestamp,
    state,
    demand = series_value
  )

aus_electricity_dictionary <- describe_dataset(
  aus_electricity,
  .title = "Australian electricity demand data",
  date = "Starting date-time of demand reading",
  state = "State abbreviation: Victoria (VIC), New South Wales (NSW), Queensland (QUN), Tasmania (TAS), and South Australia (SA)",
  demand = "Half-hourly electricity demand in MW"
)

usethis::use_data(
  aus_electricity,
  aus_electricity_dictionary,
  overwrite = TRUE
)
