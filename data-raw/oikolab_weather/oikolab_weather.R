# Retrieve oikolab weather datasets
library(dplyr)
library(purrr)
library(tsibble)

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
  select(timestamp = start_timestamp, type, series_value) %>%
  pivot_wider(names_from = type, values_from = series_value)

oikolab_weather_dictionary <- describe_dataset(
  oikolab_weather,
  .title = "Monash University Weather Data",
  timestamp = "Datetime of observation",
  temperature = "temperature (C)",
  dewpoint_temperature = "dewpoint temperature (C)",
  wind_speed = "wind speed (m/s)",
  mean_sea_level_pressure = "mean sea level pressure (Pa)",
  relative_humidity = "relative humidity (0-1)",
  surface_solar_radiation = "surface solar radiation (W/m^2)",
  surface_thermal_radiation = "surface thermal radiation (W/m^2)",
  total_cloud_cover = "total cloud cover (0-1)"
)

usethis::use_data(
  oikolab_weather,
  oikolab_weather_dictionary,
  overwrite = TRUE
)
