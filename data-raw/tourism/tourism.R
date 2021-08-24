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
    timestamp = start_timestamp, series = series_name, value = series_value
  ) %>%
  mutate(series = as.factor(series))

tourism_dictionary <- describe_dataset(
  tourism,
  .title = "366 monthly time series used in the Kaggle Tourism forecasting competition",
  timestamp = "Month",
  series = "Series number",
  value = "Value of the series during the specified month"
)

usethis::use_data(tourism, tourism_dictionary, overwrite = TRUE)
