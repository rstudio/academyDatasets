pkgload::load_all()
library(archive) # install.packages("archive")
library(dplyr)   # install.packages("dplyr")
library(purrr)   # install.packages("purrr")
library(tsibble) # install.packages("tsibble")

url <- "https://zenodo.org/record/4656096/files/tourism_monthly_dataset.zip"

tourism <- archive::archive_read(url) %>%
  read_tsf(key = "series_name") %>%
  pluck(1) %>%
  select(
    timestamp = start_timestamp, location = series_name, value = series_value
  ) %>%
  mutate(location = as.factor(location))

tourism_dictionary <- describe_dataset(
  tourism,
  .title = "366 monthly time series used in the Kaggle Tourism forecasting competition",
  timestamp = "Month",
  location = "Anonymized location indicator",
  value = "Observed value of the series during the specified month"
)

usethis::use_data(tourism, tourism_dictionary, overwrite = TRUE)
