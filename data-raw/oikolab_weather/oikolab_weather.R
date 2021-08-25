# Retrieve oikolab weather datasets
library(tidyverse)

# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/5184708/files/oikolab_weather_dataset.zip"
local_file <- here::here("data-raw", "oikolab_weather", basename(url_zip))
#===============================================================================

download.file(url_zip, destfile = local_file)
unzip(zipfile = local_file, exdir = dirname(local_file))
file.remove(local_file)

oikolab_weather <-
  read_tsf(paste0(dirname(local_file), "/", "oikolab_weather_dataset.tsf")) %>%
  pluck(1) %>%
  as_tibble() %>%
  select(timestamp = start_timestamp, series_name, type, series_value)


oikolab_weather_dictionary <- describe_dataset(
  oikolab_weather,
  .title = "Monash University Weather Data",
  timestamp = "Datetime of observation",
  series_name = "Name of the climate observation",
  type = "Type of observation. One of: temperature (C), dewpoint temperature (C), wind speed (m/s), mean sea level pressure (Pa), relative humidity (0-1), surface solar radiation (W/m^2), surface thermal radiation (W/m^2) or total cloud cover (0-1)",
  series_value = "Value of the climate observation"
)

usethis::use_data(
  oikolab_weather,
  oikolab_weather_dictionary,
  overwrite = TRUE
)
