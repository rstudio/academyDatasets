# Prepare the ny_air dataset

library(tidyverse)
  # load {academyDatasets} for access to helper functions
pkgload::load_all()

url_data <-
  "https://data.cdc.gov/resource/7vdq-ztk9.csv?year=2016&statefips=36&$limit=50000"
YEARS <- 2012:2016
variables <-
  vars(
    date,
    county = countyfips,
    pm25_max = pm25_max_pred,
    pm25_median = pm25_med_pred
  )
#===============================================================================

ny_air <-
  url_data %>%
  read_csv() %>%
  select(!!!variables) %>%
  mutate(date = lubridate::dmy(date))

ny_air_dictionary <- describe_dataset(
  ny_air,
  .title      = "Daily predicted New York air quality",
  date        = "Date",
  county      = "County",
  pm25_max    = "Maximum predicted value of PM2.5 concentration",
  pm25_median = "Median predicted value of PM2.5 concentration"
)

usethis::use_data(
  ny_air,
  ny_air_dictionary,
  overwrite = TRUE
)
