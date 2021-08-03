# Prepare the GSHS data set ----

# load {academyDatasets} for access to helper functions
pkgload::load_all()
library(dplyr)
library(forcats)
library(haven)
library(incase)
library(readr)

# Import the data from a canonical source ----
here <- function(...) here::here("data-raw", "gshs", ...)

gshs_raw <- read_dta(
  "https://extranet.who.int/ncdsmicrodata/index.php/catalog/866/download/6118"
)

gshs <- gshs_raw %>%
  transmute(
    record = record,
    age = as.integer(q1 + 10),
    sex = q2,
    weight = in_case_fct(
      qnunwtg == 1 ~ "Underweight",
      qnunwtg == 2 & qnowtg == 2 ~ "Average weight",
      qnowtg  == 1 ~ "Overweight",
    ),
    hungry = q6,
    fast_food = q10,
    fruit = q61,
    vegetable = q62,
    soft_drink = q63,
    cigarette = q29,
    alcohol = q35
  ) %>%
  mutate(
    across(where(is.labelled), as_factor)
  )

write_csv(gshs, here("gshs.csv"))

# Create machine-readable dataset description (uses academyDataset functions) ----
gshs_dictionary <- describe_dataset(
  gshs,
  .title     = "Global School-Based Student Health Survey, Buenos Aires, 2018",
  record     = "Record number",
  age        = "How old are you?",
  sex        = "What is your sex?",
  weight     = "Whether the respondent was determined to be underweight, average weight, or overweight",
  hungry     = "During the past 30 days, how often did you go hungry because there was not enough food in your home?",
  fast_food  = "During the past 7 days, on how many days did you eat food from a fast food restaurant?",
  fruit      = "During the past 7 days, how many times did you eat fruit?",
  vegetable  = "During the past 7 days, how many times did you eat vegetables?",
  soft_drink = "During the past 7 days, how many times did you drink a can, bottle, or glass of a carbonated soft drink?",
  cigarette  = "During the past 30 days, on how many days did you smoke cigarettes?",
  alcohol    = "During the past 30 days, on how many days did you have at least one drink containing alcohol?"
)

# Add the data to the package ----
usethis::use_data(
  gshs,
  gshs_dictionary,
  overwrite = TRUE
)
# document the data set with: usethis::use_r("gshs")
