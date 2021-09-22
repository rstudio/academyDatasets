pkgload::load_all()
library(archive)
library(dplyr)
library(purrr)
library(tsibble)

url <- "https://zenodo.org/record/4656058/files/saugeenday_dataset.zip"

riverflow <- archive::archive_read(url) %>%
  read_tsf(key = "series_name") %>%
  pluck(1) %>%
  as_tibble() %>%
  select(date = start_timestamp, flow_rate = series_value)

riverflow_dictionary <- describe_dataset(
  riverflow,
  .title    = "Daily flow rate of the Saugeen River",
  date      = "Date of observation",
  flow_rate = "Volumetric flow rate, in cubic meters per second"
)

usethis::use_data(
  riverflow,
  riverflow_dictionary,
  overwrite = TRUE
)
