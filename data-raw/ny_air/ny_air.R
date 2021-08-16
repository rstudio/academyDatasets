# Prepare the ny_air dataset

library(tidyverse)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_data <-
  "https://data.cdc.gov/resource/7vdq-ztk9.csv?year=2016&statefips=36&$limit=50000"
census_query <-
  "https://api.census.gov/data/2019/pep/population?get=NAME,POP&for=county:*&in=state:36"
YEARS <- 2012:2016
variables <-
  vars(
    date,
    county = countyfips,
    pm25_max = pm25_max_pred,
    pm25_median = pm25_med_pred
  )
# ===============================================================================
result <-
  jsonlite::read_json(census_query)

county_names <-
  tibble(
    county_name = map_chr(result, ~.[[1]]) %>% str_remove(", New York"),
    county_fips = map_chr(result, ~.[[4]])
  ) %>%
  slice(-1)

ny_air <-
  url_data %>%
  read_csv(
    col_types =
      cols(
        year = col_double(),
        date = col_character(),
        statefips = col_character(),
        countyfips = col_character(),
        pm25_max_pred = col_double(),
        pm25_med_pred = col_double(),
        pm25_mean_pred = col_double(),
        pm25_pop_pred = col_double()
      )
  ) %>%
  select(!!!variables) %>%
  mutate(
    date = lubridate::dmy(date),
    county = str_pad(county, width = 3, side = "left", pad = "0")
  ) %>%
  left_join(county_names, by = c("county" = "county_fips")) %>%
  relocate(county_name, .after = county)



ny_air_dictionary <- describe_dataset(
  ny_air,
  .title      = "Daily predicted New York air quality",
  date        = "Date",
  county      = "County FIPS",
  county_name = "County name",
  pm25_max    = "Maximum predicted value of PM2.5 concentration",
  pm25_median = "Median predicted value of PM2.5 concentration"
)

usethis::use_data(
  ny_air,
  ny_air_dictionary,
  overwrite = TRUE
)
