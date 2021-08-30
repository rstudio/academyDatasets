# Read in hospital dataset
# Use CSV file from https://robjhyndman.com/expsmooth/ because it contains more informative variable names for this dataset

library(readr)
library(magrittr)
# remotes::install_github("sfirke/janitor")
library(janitor)
library(dplyr)
library(lubridate)
library(stringr)
library(tidyr)


# load {academyDatasets} for access to helper functions
pkgload::load_all()


hospital <-
  read_csv("data-raw/hospital/hospital.csv") %>%
  janitor::clean_names() %>%
  pivot_longer(
    cols = 3:86,
    names_to = c("month", "year"),
    names_sep = "_",
    names_prefix = "month",
    values_to = "patient_counts"
  ) %>%
  rename(
    sku = m_price_hosp_los2000_sku_code,
    entity_code = m_price_hosp_los2000_root_entity_code
  ) %>%
  mutate(
    across(month:year, as.double)
  )

hospital_dictionary <-
  academyDatasets:::describe_dataset(
    hospital,
    .title = "Monthly counts of patients use of medical products",
    sku = "Hospital stock-keeping unit (SKU) code, representing a specific medical product",
    entity_code  = "Code related to medical product for use with medical billing and insurance purposes",
    month = "Month of interest",
    year = "Year of interest",
    patient_counts = "Number of patients who received the medical product"
    # ... more variable descriptions ...
    # <variable name> = "<variable description>"
  )

# Add data to package

usethis::use_data(
  hospital,
  hospital_dictionary,
  overwrite = TRUE
)

# Document with usethis::use_r("hospital.R")

# Update the documentation with devtools::document()
