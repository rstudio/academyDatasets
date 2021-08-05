# Prepare the nhanes_sleep data set ----

# load {academyDatasets} for access to helper functions
pkgload::load_all()
library(dplyr)
library(fauxnaif)
library(haven)
library(hms)
library(incase)
library(readr)

# Import the data from a canonical source ----
here <- function(...) here::here("data-raw", "nhanes", ...)

nhanes_sleep_raw <- read_xpt(
  "https://wwwn.cdc.gov/Nchs/Nhanes/2017-2018/SLQ_J.XPT"
)

nhanes_sleep <- nhanes_sleep_raw %>%
  zap_label() %>%
  transmute(
    seq_no = SEQN,
    sleep_time_workday   = SLQ300,
    wake_time_workday    = SLQ310,
    sleep_length_workday = SLD012,
    sleep_time_weekend   = SLQ320,
    wake_time_weekend    = SLQ330,
    sleep_length_weekend = SLD013,
    across(contains("time"), ~ parse_hm(na_if_in(., "", "77777", "99999"))),
    snore          = SLQ030,
    stop_breathing = SLQ040,
    across(
      c(snore, stop_breathing),
      ~ switch_case_fct(
        .,
        0 ~ "Never",
        1 ~ "Rarely - 1-2 nights a week",
        2 ~ "Occasionally - 3-4 nights a week",
        3 ~ "Frequently - 5 or more nights a week",
        7 ~ "Refused",
        9 ~ "Don't know"
      )
    ),
    told_doctor   = switch_case(SLQ050, 1 ~ TRUE, 2 ~ FALSE),
    overly_sleepy = switch_case_fct(
      SLQ120,
      0 ~ "Never",
      1 ~ "Rarely - 1 time a month",
      2 ~ "Sometimes - 2-4 times a month",
      3 ~ "Often- 5-15 times a month",
      4 ~ "Almost always - 16-30 times a month",
      7 ~ "Refused",
      9 ~ "Don't know"
    )
  )

write_csv(nhanes_sleep, here("nhanes_sleep.csv"))

# Create machine-readable dataset description (uses academyDataset functions) ----
nhanes_sleep_dictionary <- describe_dataset(
  nhanes_dermatology,
  .title               = "National Health and Nutrition Examination Survey, Sleep Disorders, 2017-2018",
  seq_no               = "Respondent sequence number",
  sleep_time_workday   = "What time do you usually fall asleep on weekdays or workdays?",
  wake_time_workday    = "What time do you usually wake up on weekdays or workdays?",
  sleep_length_workday = "Number of hours usually sleep on weekdays or workdays.",
  sleep_time_weekend   = "What time do you usually fall asleep on weekends or non-workdays?",
  wake_time_weekend    = "What time do you usually wake up on weekends or non-workdays?",
  sleep_length_weekend = "Number of hours usually sleep on weekends or non-workdays.",
  snore                = "In the past 12 months, how often did you snore while you were sleeping?",
  stop_breathing       = "In the past 12 months, how often did you snort, gasp, or stop breathing while you were asleep?",
  told_doctor          = "Have you ever told a doctor or other health professional that you have trouble sleeping?",
  overly_sleepy        = "In the past month, how often did you feel excessively or overly sleepy during the day?"
)

# Add the data to the package ----
usethis::use_data(
  nhanes_sleep,
  nhanes_sleep_dictionary,
  overwrite = TRUE
)
# document the data set with: usethis::use_r("nhanes")
