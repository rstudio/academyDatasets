# Prepare the MDRD data set ----

# load {academyDatasets} for access to helper functions
pkgload::load_all()
library(dplyr)
library(fauxnaif)
library(haven)
library(incase)
library(readr)

# Import the data from a canonical source ----
here <- function(...) here::here("data-raw", "nhanes", ...)

nhanes_dermatology <- read_xpt(
  "https://wwwn.cdc.gov/Nchs/Nhanes/2017-2018/DEQ_J.XPT"
) %>%
  zap_label() %>%
  transmute(
    seq_no = SEQN,
    sun_reaction = switch_case_fct(
      DED031,
      1  ~ "Get a severe sunburn with blisters",
      2  ~ "A severe sunburn for a few days with peeling",
      3  ~ "Mildly burned with some tanning",
      4  ~ "Turning darker without a sunburn",
      5  ~ "Nothing would happen in half an hour",
      6  ~ "Other",
      77 ~ "Refused",
      99 ~ "Don't know"
    ),
    shade = switch_case_fct(
      DEQ034A,
      1  ~ "Always",
      2  ~ "Most of the time",
      3  ~ "Sometimes",
      4  ~ "Rarely",
      5  ~ "Never",
      6  ~ "Don't go out in the sun",
      77 ~ "Refused",
      99 ~ "Don't know"
    ),
    long_sleeves = switch_case_fct(
      DEQ034C,
      1 ~ "Always",
      2 ~ "Most of the time",
      3 ~ "Sometimes",
      4 ~ "Rarely",
      5 ~ "Never",
      7 ~ "Refused",
      9 ~ "Don't know"
    ),
    sunscreen = switch_case_fct(
      DEQ034D,
      1 ~ "Always",
      2 ~ "Most of the time",
      3 ~ "Sometimes",
      4 ~ "Rarely",
      5 ~ "Never",
      7 ~ "Refused",
      9 ~ "Don't know"
    ),
    sunburns = switch_case(
      DEQ038G,
      1 ~ na_if_in(DEQ038Q, ~ . > 20),
      2 ~ 0
    ),
    time_outdoors_workday = na_if_in(DED120, ~ . > 480),
    time_outdoors_weekend = na_if_in(DED125, ~ . > 480)
  )

write_csv(nhanes_dermatology, here("nhanes_dermatology.csv"))

# Create machine-readable dataset description (uses academyDataset functions) ----
nhanes_dermatology_dictionary <- describe_dataset(
  nhanes_dermatology,
  .title                = "National Health and Nutrition Examination Survey, Dermatology, 2017-2018",
  seq_no                = "Respondent sequence number",
  sun_reaction          = "If after several months of not being in the sun, you then went out in the sun without sunscreen or protective clothing for a half hour, which one of these would happen to your skin?",
  shade                 = "When you go outside on a very sunny day, for more than one hour, how often do you stay in the shade?",
  long_sleeves          = "When you go outside on a very sunny day, for more than one hour, how often do you wear a long sleeved shirt?",
  sunscreen             = "When you go outside on a very sunny day, for more than one hour, how often do you use sunscreen?",
  sunburns              = "How many times in the past year have you had a sunburn?",
  time_outdoors_workday = "During the past 30 days, how much time did you usually spend outdoors between 9 in the morning and 5 in the afternoon on the days that you worked or went to school?",
  time_outdoors_weekend = "During the past 30 days, how much time did you usually spend outdoors between 9 in the morning and 5 in the afternoon on the days when you were not working or going to school?"
)

# Add the data to the package ----
usethis::use_data(
  nhanes_dermatology,
  nhanes_dermatology_dictionary,
  overwrite = TRUE
)
# document the data set with: usethis::use_r("nhanes_dermatology")
