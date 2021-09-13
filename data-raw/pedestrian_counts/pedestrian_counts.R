# Read in pedestrian counts data

library(tidyverse)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/4656626/files/pedestrian_counts_dataset.zip?download=1"

#===============================================================================

temp <- "data-raw/pedestrian_counts/temp.zip"
download.file(url_zip, destfile = temp)
unzip(zipfile = "data-raw/pedestrian_counts/temp.zip", exdir = fs::path_dir(temp))
file.remove(temp)

pedestrian_counts <-
  read_tsf("data-raw/pedestrian_counts/pedestrian_counts_dataset.tsf") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(
    date = start_timestamp,
    sensor_id = series_name,
    ped_count = series_value
  ) %>%
  mutate(ped_count = as.integer(ped_count))

lubridate::second(pedestrian_counts$date) <- 0

pedestrian_counts_dictionary <- describe_dataset(
  pedestrian_counts,
  .title = "Melbourne pedestrian count data",
  date = "Date-time of sensor reading",
  sensor_id = "Sensor ID",
  ped_count = "Hourly count of pedestrians"
)

usethis::use_data(
  pedestrian_counts,
  pedestrian_counts_dictionary,
  overwrite = TRUE
)
