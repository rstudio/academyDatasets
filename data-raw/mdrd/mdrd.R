# Prepare the MDRD data set ----

# load {academyDatasets} for access to helper functions
pkgload::load_all()

# Import the data from a canonical source ----
here <- function(...) here::here("data-raw", "mdrd", ...)

mdrd_source_url <- "https://rsacdn.link/ac/milestones/fda/pilot/milestone-3/data/data_3_baseline.xpt"
mdrd_supp_url <- "https://rsacdn.link/ac/milestones/fda/pilot/milestone-3/data/data_supplemental.xlsx"

for (remote_url in c(mdrd_source_url, mdrd_supp_url)) {
  local_path <- here(basename(remote_url))
  if (!file.exists(local_path)) {
    download.file(remote_url, local_path)
  }
}

# Read the data into this session ----
mdrd <- haven::read_xpt(here(basename(mdrd_source_url)))
mdrd_supplemental <- readxl::read_excel(here(basename(mdrd_supp_url)))

# Create machine-readable dataset description (uses academyDataset functions) ----
mdrd_dictionary <- describe_dataset(
  mdrd,
  .title   = "Modification of Diet in Renal Disease",
  ptid     = "Patient identifier",
  gfr      = "Glomerular filtration rate in milliliters per minute. A measure of how much blood the kidneys filter per minute. ",
  months   = "Number of months after the start of the study that the measurement was taken. ",
  dietl_n  = "Was the participant assigned to the low-protein, normal-blood pressure diet? (0 = No, 1 = Yes)",
  dietl_l  = "Was the participant assigned to the low-protein, low-blood prssure diet? (0 = No, 1 = Yes)",
  dietk_n  = "Was the participant assigned to the very low-protein, normal-blood pressure diet? (0 = No, 1 = Yes)",
  dietk_l  = "Was the participant assigned to the very low-protein, low-blood pressure diet? (0 = No, 1 = Yes)",
  log_prot = "Logarithm of the grams of protein consumed per day.",
  followup = "Number of months until patient follow-up.",
  dropout  = "Did the patient drop out of the study? (0 = No, 1 = Yes)"
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
