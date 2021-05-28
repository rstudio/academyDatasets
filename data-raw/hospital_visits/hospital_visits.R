pkgload::load_all()

library(readr)
library(magrittr)
# remotes::install_github("sfirke/janitor")
library(janitor)


# Download 1000-patient synthetic hospital data, and unzip
remote_url <- "https://storage.googleapis.com/synthea-public/synthea_sample_data_csv_apr2020.zip"
local_path <- here::here("data-raw", "hospital_visits", basename(remote_url))

download.file(remote_url, local_path)


unzip(local_path,
      files = c("csv/encounters.csv", "csv/medications.csv"),
      exdir = here::here("data-raw", "hospital_visits"))


# Read and clean relevant datasets
encounters_path <- here::here("data-raw", "hospital_visits", "csv", "encounters.csv")
medications_path <- here::here("data-raw", "hospital_visits", "csv", "medications.csv")


encounters <-
  readr::read_csv(encounters_path) %>%
  janitor::clean_names()

medications <-
  readr::read_csv(medications_path) %>%
  janitor::clean_names()


# Dictionaries provided by synthea: https://github.com/synthetichealth/synthea/wiki/CSV-File-Data-Dictionary
encounters_dictionary <-
  describe_dataset(
    encounters,
    .title   = "Patient encounter data.",
    id = "Primary Key. Unique Identifier of the encounter.",
    start = "The date and time the encounter started.",
    stop = "The date and time the encounter concluded.",
    patient = "Foreign key to the Patient.",
    organization = "Foreign key to the Organization.",
    provider = "Foreign key to the Provider.",
    payer = "Foreign key to the Payer.",
    encounterclass = "The class of the encounter, such as ambulatory, emergency, inpatient, wellness, or urgentcare",
    code = "Encounter code from SNOMED-CT",
    description = "Description of the type of encounter.",
    base_encounter_cost = "The base cost of the encounter, not including any line item costs related to medications, immunizations, procedures, or other services.",
    total_claim_cost = "The total cost of the encounter, including all line items.",
    payer_coverage = "The amount of cost covered by the Payer.",
    reasoncode = "Diagnosis code from SNOMED-CT, only if this encounter targeted a specific condition.",
    reasondescription = "Description of the reason code."
  )

medications_dictionary <-
  describe_dataset(
    medications,
    .title   = "Patient medication data.",
    start = "The date and time the medication was prescribed.",
    stop = "The date and time the prescription ended, if applicable.",
    patient = "Foreign key to the Patient.",
    payer = "Foreign key to the Payer.",
    encounter = "Foreign key to the Encounter where the medication was prescribed.",
    code = "Medication code from RxNorm.",
    description = "Description of the medication.",
    base_cost = "The line item cost of the medication.",
    payer_coverage = "The amount covered or reimbursed by the Payer.",
    dispenses = "The number of times the prescription was filled.",
    totalcost = "The total cost of the prescription, including all dispenses.",
    reasoncode = "Diagnosis code from SNOMED-CT specifying why this medication was prescribed.",
    reasondescription = "Description of the reason code."
  )

# Add the data to the package ----
usethis::use_data(
  encounters,
  encounters_dictionary,
  medications,
  medications_dictionary,
  overwrite = TRUE
)

