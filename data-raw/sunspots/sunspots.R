# Sunspot data from https://forecastingdata.org/

library(tidyverse)
pkgload::load_all()

url_zip <- "https://zenodo.org/record/4654773/files/sunspot_dataset_with_missing_values.zip?download=1"
temp <- "data-raw/sunspot/temp.zip"
file_tsf <- "data-raw/sunspot/sunspot_dataset_with_missing_values.tsf"
#===============================================================================

download.file(url_zip, destfile = temp)
unzip(zipfile = temp, exdir = fs::path_dir(temp))
file.remove(temp)

sunspots <-
  read_tsf(file_tsf) %>%
  pluck(1) %>%
  as_tibble() %>%
  select(date = start_timestamp, sunspots = series_value)

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
