# Read in FRED-MD data

library(tidyverse)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_zip <- "https://zenodo.org/record/4654833/files/fred_md_dataset.zip?download=1"
file_script <- "data-raw/fred_md/convert_tsf_to_tsibble.R"
#===============================================================================

temp <- "data-raw/fred_md/temp.zip"
download.file(url_zip, destfile = temp)
unzip(zipfile = "data-raw/fred_md/temp.zip", exdir = fs::path_dir(temp))
file.remove(temp)

source(file_script)

fred_md <-
  convert_tsf_to_tsibble("data-raw/fred_md/fred_md_dataset.tsf") %>%
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
