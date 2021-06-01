# Prepare the vaccines dataset

library(tidyverse)
library(lubridate)
# load {academyDatasets} for access to helper functions
pkgload::load_all()

url_pfizer <- "https://data.cdc.gov/resource/saz5-9hgg.csv?$limit=15000"
url_moderna <- "https://data.cdc.gov/resource/b7pe-5nws.csv?$limit=15000"
url_janssen <- "https://data.cdc.gov/resource/w9zu-fywh.csv?$limit=15000"
# Variables to select/rename
variables <-
  vars(
    jurisdiction,
    vaccine,
    week = week_of_allocations,
    first_dose = `_1st_dose_allocations`,
    second_dose = `_2nd_dose_allocations`
  )
# ===============================================================================

vaccines <-
  url_pfizer %>%
  read_csv() %>%
  mutate(vaccine = "Pfizer", .after = jurisdiction) %>%
  bind_rows(
    "Pfizer" = .,
    "Moderna" = read_csv(url_moderna),
    "Janssen" = read_csv(url_janssen),
    .id = "vaccine"
  ) %>%
  select(!!!variables) %>%
  arrange(jurisdiction, vaccine, week) %>%
  mutate(week = as_date(week))

# Create machine-readable dataset description (uses academyDataset functions) ----
vaccines_dictionary <- describe_dataset(
  vaccines,
  .title          = "COVID-19 Vaccine Allocation",
  jurisdiction    = "State or territory",
  vaccine         = "Vaccine type",
  week            = "Week the vaccines were allocated",
  first_dose      = "Number of first doses allocated",
  second_dose     = "Number of second doses allocated"
)


usethis::use_data(
  vaccines,
  vaccines_dictionary,
  overwrite = TRUE
)
