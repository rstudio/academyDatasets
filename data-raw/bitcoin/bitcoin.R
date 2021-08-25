pkgload::load_all()
library(archive) # install.packages("archive")
library(dplyr)   # install.packages("dplyr")
library(purrr)   # install.packages("purrr")
library(tsibble) # install.packages("tsibble")
# library(tidyr)

url <- "https://zenodo.org/record/5121965/files/bitcoin_dataset_with_missing_values.zip"

bitcoin <- archive::archive_read(url) %>%
  read_tsf(key = "series_name") %>%
  pluck(1) %>%
  select(
    timestamp = start_timestamp, series = series_name, value = series_value
  ) %>%
  mutate(series = as.factor(series)) # %>% # For tidy data
  # pivot_wider(names_from = series, values_from = value) %>%
  # relocate(timestamp, price)

bitcoin_dictionary <- describe_dataset(
  bitcoin,
  .title = "Daily bitcoin prices with possible influencers",
  timestamp = "Day",
  series = "Series name",
  value = "Value of the series during the specified month"
)

usethis::use_data(bitcoin, bitcoin_dictionary, overwrite = TRUE)
