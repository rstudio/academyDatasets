pkgload::load_all()
library(archive) # install.packages("archive")
library(dplyr)   # install.packages("dplyr")
library(purrr)   # install.packages("purrr")
library(tibble) # install.packages("tsibble")
library(tsibble)

url <- "https://zenodo.org/record/4656049/files/us_births_dataset.zip"

us_births <- archive::archive_read(url) %>%
  read_tsf(key = "series_name") %>%
  pluck(1) %>%
  select(
    timestamp = start_timestamp, births = series_value
  ) %>%
  as_tibble() %>%
  mutate(births = as.integer(births))

us_births_dictionary <- describe_dataset(
  us_births,
  .title = "Daily US births",
  timestamp = "Day",
  births = "Number of births in the US"
)

usethis::use_data(us_births, us_births_dictionary, overwrite = TRUE)
