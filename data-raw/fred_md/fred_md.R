# Read in FRED-MD data

library(tidyverse)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_fred_md <-
  "https://files.stlouisfed.org/files/htdocs/fred-md/monthly/current.csv"
#===============================================================================

fred_md <-
  read_csv(url_fred_md) %>%
  slice(-1) %>%
  mutate(sasdate = parse_date(sasdate, format = "%m/%d/%Y")) %>%
  select(
    date = sasdate,
    RPI,
    HWI,
    UNRATE,
    CE16OV,
    HOUST,
    CPIAUCSL
  ) %>%
  rename_with(str_to_lower) %>%
  filter(!is.na(date))

fred_md_dictionary <- describe_dataset(
  fred_md,
  .title = "U.S. macro-economic indicators from the FRED-MD database",
  timestamp = "Date",
  rpi = "Real personal income, in billions of dollars",
  hwi =
    "Help-wanted index: the number of help-wanted ads in major newspapers",
  unrate = "Civilian unemployment rate (percent)",
  ce16ov = "Millions of employed civilians",
  houst = "Total number of new privately owned houses",
  cpiaucsl = "Consumer price index (all items)"
)

usethis::use_data(
  fred_md,
  fred_md_dictionary,
  overwrite = TRUE
)
