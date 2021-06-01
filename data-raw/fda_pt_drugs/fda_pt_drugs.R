# remotes::install_github("ropenhealth/openfda")
library(openfda)
library(tidyverse)
library(lubridate)

# load {academyDatasets} for access to helper functions
pkgload::load_all()

# function to create a date range to filter on
date_range <- function(min_date, max_date) {
  sprintf("[%d+TO+%d]", min_date, max_date)
}

# function to create a vector of data for a given field from openFDA adverse events data
create_var <- function(
  field,
  subfield = NULL,
  limit = 1000,
  skip = 0,
  min_date = 20190101, # by default, narrow search to January 2019
  max_date = 20190131
) {

  x <- fda_query("/drug/event.json") %>%
    fda_filter("receivedate", date_range(min_date, max_date)) %>%
    fda_skip(skip) %>%
    fda_search(field) %>%
    fda_limit(limit) %>%
    fda_exec()

  # if query result is NULL, return all NA's
  if (is.null(x)) {
    return(rep(NA_character_, limit))
  }

  if (is.atomic(x)) {
    return(x)
  }

  # if query result is a list, select the desired subfield and return as a list
  if (is.list(x)) {
    y <- x %>%
      map(~ pluck(.x, subfield))

    return(y)
  }
}

limit <- 1000 # max you can access for a single query
max_skip <- 25000 # max skip value
skips <- seq(from = 0, to = max_skip, by = limit) # "skip" values to iterate over

# create raw data (note: this code takes a long time to run, ~15 min)
fda_pt_drugs_raw <- tibble(
  # report variables
  report_id = map(skips, ~ create_var("safetyreportid", skip = .x)) %>% flatten_chr(),
  receive_date = map(skips, ~ create_var("receivedate", skip = .x)) %>% flatten_chr(),
  receipt_date = map(skips, ~ create_var("receiptdate", skip = .x)) %>% flatten_chr(),
  country = map(skips, ~ create_var("occurcountry", skip = .x)) %>% flatten_chr(),
  reporter = map(skips, ~ create_var("primarysource.qualification", skip = .x)) %>% flatten_chr(),

  # patient variables
  age = map(skips, ~ create_var("patient.patientonsetage", skip = .x)) %>% flatten_chr(),
  age_unit = map(skips, ~ create_var("patient.patientonsetageunit", skip = .x)) %>% flatten_chr(),
  sex = map(skips, ~ create_var("patient.patientsex", skip = .x)) %>% flatten_chr(),
  weight = map(skips, ~ create_var("patient.patientweight", skip = .x)) %>% flatten_chr(),

  # drug variables
  # could instead use openfda.generic_name or openfda.brand_name, but these can have multiple redundant fields
  drug = map(skips, ~ create_var("patient.drug", "medicinalproduct", skip = .x)) %>% purrr::flatten(),
  dosage = map(skips, ~ create_var("patient.drug", "drugstructuredosagenumb", skip = .x)) %>% purrr::flatten(),
  dosage_unit = map(skips, ~ create_var("patient.drug", "drugstructuredosageunit", skip = .x)) %>% purrr::flatten(),
  indication = map(skips, ~ create_var("patient.drug", "drugindication", skip = .x)) %>% purrr::flatten(),
  drug_start_date = map(skips, ~ create_var("patient.drug", "drugstartdate", skip = .x)) %>% purrr::flatten(),
  drug_end_date = map(skips, ~ create_var("patient.drug", "drugenddate", skip = .x)) %>% purrr::flatten(),

  # reaction variables
  serious = map(skips, ~ create_var("serious", skip = .x)) %>% flatten_chr(),
  reaction = map(skips, ~ create_var("patient.reaction", "reactionmeddrapt", skip = .x)) %>% purrr::flatten(),
  outcome = map(skips, ~ create_var("patient.reaction", "reactionoutcome", skip = .x)) %>% purrr::flatten()
)

# clean data
fda_pt_drugs <-
  fda_pt_drugs_raw %>%
  mutate(
    weight = as.numeric(weight),
    age = as.numeric(age),
    # convert all ages to years
    age = case_when(
      age_unit == "800" ~ age * 10, # decade
      age_unit == "801" ~ age, # year
      age_unit == "802" ~ age / 12, # month
      age_unit == "803" ~ age / 52.143, # week,
      age_unit == "804" ~ age / 365, # day,
      age_unit == "805" ~ age / 8760, # hour
      TRUE ~ NA_real_
    ),
    # round down to nearest year
    age = floor(age),
    sex = case_when(
      sex == "1" ~ "male",
      sex == "2" ~ "female",
      TRUE ~ NA_character_
    ),
    reporter = case_when(
      reporter == "1" ~ "physician",
      reporter == "2" ~ "pharmacist",
      reporter == "3" ~ "otherhealth",
      reporter == "4" ~ "lawyer",
      reporter == "5" ~ "nonhealth",
      TRUE ~ NA_character_
    ),
    serious = case_when(
      serious == "1" ~ TRUE,
      serious == "2" ~ FALSE,
      TRUE ~ NA
    )
  ) %>%
  select(-age_unit) %>%
  # unnest drug variables
  unnest(cols = c(drug, dosage, dosage_unit, indication, drug_start_date, drug_end_date)) %>%
  # remove dates without year month and day
  filter(nchar(drug_start_date) == 8 & nchar(drug_end_date == 8)) %>%
  mutate(
    dosage = as.numeric(dosage),
    # format date variables
    across(ends_with("_date"), ymd),
    # convert dosage codes to units (note: ug = microgram)
    dosage_unit = case_when(
      dosage_unit == "001" ~ "kg",
      dosage_unit == "002" ~ "g",
      dosage_unit == "003" ~ "mg",
      dosage_unit == "004" ~ "ug",
      TRUE ~ NA_character_
    ),
    # convert to lowercase
    across(c(drug, indication), str_to_lower),
    # remove '^', as in 'chron^s disease'
    indication = str_replace_all(indication, "\\^", ""),
    # clean drug names
    drug =
      str_replace_all(
        drug,
        c(
          "\\.$" = "",
          "[:space:]*\\((.*)" = "",
          "\\/\\/(.*)" = "",
          "[:space:]*\\/[:digit:](.*)" = "",
          "\\^" = "",
          "\\,(.*)" = "",
          "[:space:]*\\[(.*)" = "",
          "[:space:]*[:digit:]*[:space:]mg(.*)" = "",
          "\\/(.*)" = "",
          "[:space:][:digit:]*\\.[:digit:]*(.*)" = ""
        )
      )
  ) %>%
  # unnest reaction variables
  unnest(cols = c(reaction, outcome)) %>%
  mutate(
    # descriptive labels for reaction outcomes
    outcome = case_when(
      outcome == "1" ~ "recovered",
      outcome == "2" ~ "recovering",
      outcome == "3" ~ "not recovered",
      outcome == "4" ~ "recovered with sequelae",
      outcome == "5" ~ "fatal",
      outcome == "6" ~ "unknown",
      TRUE ~ NA_character_
    ),
    reaction = str_to_lower(reaction),
    # remove '^', as in 'chron^s disease'
    reaction = str_replace_all(reaction, "\\^", "")
  ) %>%
  # remove non-sensible observations
  filter(
    weight > 0,
    !(age < 4 & weight > 30),
    receipt_date >= receive_date,
    drug_end_date >= drug_start_date
  ) %>%
  # removes rows with date parsing failures
  drop_na(ends_with("_date")) %>%
  # drop all other rows with missing values (removes many rows); can change this if desired
  drop_na()

# data dictionary
fda_pt_drugs_dictionary <- describe_dataset(
  fda_pt_drugs,
  .title = "Patient and drug information for FDA drug adverse events",
  report_id = "The 8-digit Safety Report ID number, also known as the case report number or case ID. Can be used to identify or find a specific adverse event report.",
  receive_date = "Date that the report was first received by FDA.",
  receipt_date = "Date that the most recent information in the report was received by FDA.",
  country = "The name of the country where the adverse event occurred.",
  reporter = "Category of individual who submitted the report: physician, pharmacist, other health professional, laywer or consumer/non-health professional.",
  age = "Age of the patient when the adverse event first occured.",
  sex = "The sex of the patient.",
  weight = "The patient weight, in kilograms (kg).",
  drug = "Drug name. This may be the valid trade name of the product (e.g. \"advil\" or \"aleve\") or the generic name (e.g. \"ibuprofen\").",
  dosage = "The number portion of a dosage; when combined with `dosage_unit` the complete dosage information is represented.",
  dosage_unit = "The drug dosasge unit: kilograms (kg), grams (g), milligrams (mg) or micrograms (ug).",
  indication = "Indication for the drug’s use.",
  drug_start_date = "Date the patient began taking the drug.",
  drug_end_date = "Date the patient stopped taking the drug.",
  serious = "A logical value indicating whether or not the adverse event was serious, i.e. resulted in death, a life threatening condition, hospitalization, disability, congenital anomaly, or some other serious condition.",
  reaction = "Patient reaction, as a term from the Medical Dictionary for Regulatory Activities, encoded in British English.",
  outcome = "Outcome of the patient reaction at the time of last observation: recovered, recovering, not recovered, recovered with sequelae (consequent health issues), fatal or unknown."
)

# add data to the package
usethis::use_data(
  fda_pt_drugs,
  fda_pt_drugs_dictionary,
  overwrite = TRUE
)
