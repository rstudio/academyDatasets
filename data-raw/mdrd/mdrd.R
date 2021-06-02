# Prepare the MDRD data set ----

# load {academyDatasets} for access to helper functions
pkgload::load_all()
library(dplyr)

# Import the data from a canonical source ----
here <- function(...) here::here("data-raw", "mdrd", ...)

key_source <- "1QsBcnH2FqjNLsiR63LSxTfmCCbdscV6FKoGWQ02cYNY"
file_mdrd <- here("mdrd.csv")

mdrd <-
  googlesheets4::sheets_read(key_source) %>%
  rename_with(stringr::str_to_lower) %>%
  readr::write_csv(file_mdrd)

# Simulate supplemental data
set.seed(222)
mdrd_supplemental <-
  mdrd %>%
  filter(months == 0) %>%
  distinct(ptid, gfr) %>%
  rowwise() %>%
  mutate(sex = sample(c("M", "F"), size = 1)) %>%
  ungroup() %>%
  mutate(
    age = 60 -  0.8 * gfr + rnorm(n = 255, mean = 25, sd = 4),
    height =
      if_else(
        sex == "M",
        rnorm(n = 255, mean = 1.75, sd = 0.08),
        rnorm(n = 255, mean = 1.6, sd = 0.06)
      ),
    bmi =
      pmin(pmax(18, 50 - 0.9 * gfr - rnorm(n = 255, mean = 3, sd = 4)), 43),
    weight = bmi * height^2
  ) %>%
  select(-bmi, -gfr)


# Create machine-readable dataset description (uses academyDataset functions) ----
mdrd_dictionary <- describe_dataset(
  mdrd,
  .title         = "Modification of Diet in Renal Disease",
  ptid           = "Patient identifier",
  gfr            = "Glomerular filtration rate in milliliters per minute. A measure of how much blood the kidneys filter per minute. ",
  months         = "Number of months after the start of the study that the measurement was taken. ",
  dietl_normbp   = "Was the participant assigned to the low-protein, normal-blood pressure diet? (0 = No, 1 = Yes)",
  dietl_lowbp    = "Was the participant assigned to the low-protein, low-blood prssure diet? (0 = No, 1 = Yes)",
  dietk_normbp   = "Was the participant assigned to the very low-protein, normal-blood pressure diet? (0 = No, 1 = Yes)",
  dietk_lowbp    = "Was the participant assigned to the very low-protein, low-blood pressure diet? (0 = No, 1 = Yes)",
  log_protein    = "Logarithm of the grams of protein consumed per day.",
  followupmonths = "Number of months until patient follow-up.",
  dropout        = "Did the patient drop out of the study? (0 = No, 1 = Yes)"
)

mdrd_supplemental_dictionary <- describe_dataset(
  mdrd_supplemental,
  .title = "Modification of Diet In Renal Disease - Supplemental Data",
  ptid   = "Patient identifier",
  sex    = "Sex",
  age    = "Age (years)",
  height = "Height (meters)",
  weight = "Weight (kilograms)"
)

# Add the data to the package ----
usethis::use_data(
  mdrd,
  mdrd_dictionary,
  mdrd_supplemental,
  mdrd_supplemental_dictionary,
  overwrite = TRUE
)
# document the data set with: usethis::use_r("mdrd")
