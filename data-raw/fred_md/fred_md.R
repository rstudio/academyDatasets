# Read in FRED-MD data

library(tidyverse)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_fred_md <- "https://files.stlouisfed.org/files/htdocs/fred-md/monthly/current.csv"
#===============================================================================

fred_md <-
  read_csv(url_fred_md) %>%
  slice(-1)

fred_md %>%
  mutate(sasdate = parse_date(sasdate, format = "%m/%d/%Y")) %>%
  select(
    date = sasdate,
    RPI,
    HWI,
    UNRATE,
    HOUST,

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
