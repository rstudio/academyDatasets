# Sunspot data from https://forecastingdata.org/

library(tidyverse)
pkgload::load_all()

url_sunspots <- "https://zenodo.org/record/4654773/files/sunspot_dataset_with_missing_values.zip?download=1"
#===============================================================================

sunspots <-
  archive::archive_read(url_zip) %>%
  read_tsf(key = "series_name") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(date = start_timestamp, sunspots = series_value) %>%
  mutate(sunspots = as.integer(sunspots))

sunspots_dictionary <- describe_dataset(
  sunspots,
  date = "Date of observation",
  sunspots = "Observed number of sunspots"
)

usethis::use_data(
  sunspots,
  sunspots_dictionary,
  overwrite = TRUE
)
