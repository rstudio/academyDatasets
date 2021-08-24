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
    timestamp = start_timestamp,
    series_name,
    series_value
  )

pedestrian_counts_dictionary <- describe_dataset(
  pedestrian_counts,
  .title = "Melbourne Pedestrian Counts",
  timestamp = "Date-time of sensor reading",
  series_name = "Sensor ID",
  series_value = "Hourly count of pedestrians"
)

usethis::use_data(
  pedestrian_counts,
  pedestrian_counts_dictionary,
  overwrite = TRUE
)
