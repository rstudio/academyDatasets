# Read in FRED-MD data

library(tidyverse)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_fred_md <- "https://zenodo.org/record/4654833/files/fred_md_dataset.zip?download=1"
#===============================================================================

fred_md <-
  archive::archive_read(url_fred_md) %>%
  read_tsf() %>%
  pluck(1) %>%
  as_tibble() %>%
  select(
    timestamp = start_timestamp,
    series_name,
    series_value
  )


fred_md_dictionary <- describe_dataset(
  fred_md,
  .title = "107 macro-economic indicators, from the FRED-MD database",
  timestamp = "Date",
  series_name = "Name of the macro-economic indicator",
  series_value = "Value of the indicator"
)

usethis::use_data(
  fred_md,
  fred_md_dictionary,
  overwrite = TRUE
)
