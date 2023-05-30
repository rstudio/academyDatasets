# Read in Aus. electricity data

library(tidyverse)
library(archive)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/4659727/files/australian_electricity_demand_dataset.zip?download=1"

#===============================================================================

aus_electricity <- url_zip %>%
  archive_read("australian_electricity_demand_dataset.tsf") %>%
  read_tsf() %>%
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
