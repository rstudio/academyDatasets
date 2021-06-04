# Retrieve sdtm data sets
# Data provided by [Rho](https://rhoinc.github.io/data-library/) under the MIT license.
library(tidyverse)

pkgload::load_all()

ae <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/ae.csv"
cm <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/cm.csv"
dm <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/dm.csv"
lb <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/lb.csv"
sv <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/sv.csv"
vs <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/vs.csv"

get_data <- function(remote_url) {
  local_path <- here::here("data-raw", "sdtm", basename(remote_url))
  download.file(remote_url, local_path)
  readr::read_csv(local_path)
}

sdtm_adverse_events <- get_data(ae)
sdtm_concomitant_meds <- get_data(cm) %>% select(-CMINDC)
sdtm_demographics <- get_data(dm)
sdtm_lab_results <- get_data(lb)
sdtm_subject_visits <- get_data(sv)
sdtm_vital_signs <- get_data(vs)


sdtm_adverse_events_dictionary <- describe_dataset(
  sdtm_adverse_events,
  .title = "SDTM formatted Adverse Event data",
  USUBJID = "Unique Subject Identifier",
  AESEQ = "Sequence Number",
  AESTDT = "Start date of the adverse event",
  AESTDY = "The number of days the subject had been enrolled in the study when the adverse event began.",
  AEENDT = "End date of the adverse event",
  AEENDY = "The number of days the subject had been enrolled in the study when the adverse event ended.",
  AETERM = "The reported term for the adverse event, i.e. how the reporter described the adverse event.",
  AEDECOD = "The official term for the adverse event, i.e. the dictionary derived description of the adverse event.",
  AEBODSYS = "Body system or organ class involved in the adverse event.",
  AESER = "Was the adverse event serious? `Y` = Yes, `N` = No.",
  AEONGO = "Is the adverse event ongoing? `Y` = Yes, `N` = No.",
  AESEV = "Severity of the adverse event.",
  AEREL = "The investigator's opinion as to whether or not the adverse event was related to the study treatment.",
  AEOUT = "Outcome of the adverse event."
)

usethis::use_data(
  sdtm_adverse_events,
  sdtm_adverse_events_dictionary,
  overwrite = TRUE
)

sdtm_concomitant_meds_dictionary <- describe_dataset(
  sdtm_concomitant_meds,
  .title = "SDTM formatted Concomitant Medication data",
  USUBJID = "Unique Subject Identifier",
  CMSEQ = "Sequence Number",
  CMSTDT = "Start date of the concomitant medication",
  CMSTDY = "The number of days the subject had been enrolled in the study when the concomitant medication began.",
  CMENDT = "End date of the concomitant medication",
  CMENDY = "The number of days the subject had been enrolled in the study when the concomitant medication ended.",
  CMTRT = "Reported name of the concomitant medication, i.e concomitant treatment",
  PREFTERM = "The nonproprietary, i.e. generic, name of the concomitant medication",
  ATCTEXT2 = "Anatomical Therapeutic Chemical (ATC) of the concomitant medication",
  CMONGO = "Is the concomitant medication ongoing? `Y` = Yes, `N` = No",
  CMDOSE = "Amount of concomitant medication taken per administration (dose)",
  CMROUTE = "Route of administration of the concomitant medication"
)

usethis::use_data(
  sdtm_concomitant_meds,
  sdtm_concomitant_meds_dictionary,
  overwrite = TRUE
)

sdtm_demographics_dictionary <- describe_dataset(
  sdtm_demographics,
  .title = "SDTM formatted Demographic data",
  USUBJID = "Unique Subject Identifier",
  SITE = "Name of study site",
  SITEID = "Study Site Identifier",
  AGE = "Age of subject",
  SEX = "Sex of subject",
  RACE = "Race of subject",
  ARM = "Treatment arm that subject is assigned to",
  ARMCD = "Code for treatment arm that subject is assigned to",
  SBJTSTAT = "Subject status in study",
  RFSTDTC = "Reference start date. Usually the day the subject begins treatment.",
  RFENDTC = "Reference end date. Usually the day the subject takes their last treatment.",
  RFENDY = "The number of days after the RFSTDTC that the RFENDTC occurred, i.e. the number of days the subject spent in the study/in treatment",
  SAFFL = "Safety population flag. Did the subject actually receive a treatment (including placebo) and should therefore be included in the population of subjects studied to determine the safety of the treatment? `Y` = Yes and `N` = No",
  SAFFN = "Numeric coding of safety population flag. `Y` = Yes and `N` = No"
)

usethis::use_data(
  sdtm_demographics,
  sdtm_demographics_dictionary,
  overwrite = TRUE
)

sdtm_lab_results_dictionary <- describe_dataset(
  sdtm_lab_results,
  .title = "SDTM Laboratory Test Results data",
  USUBJID = "Unique Subject Identifier",
  VISIT = "Protocol defined text description of the visit",
  VISITNUM = "Visit number",
  LBDT = "Date of specimen collection",
  LBDY = "Study day of specimen collection",
  LBCAT = "Category of the lab test performed",
  LBTEST = "Name of the lab test performed",
  LBSTRESU = "Standard units for lab test result (LBSTRESN)",
  LBSTRESN = "Lab test result in standard units",
  LBSTNRLO = "Lower limit of normal range lab test result",
  LBSTNRHI = "Upper (high) limit of normal range for lab test result"
)

usethis::use_data(
  sdtm_lab_results,
  sdtm_lab_results_dictionary,
  overwrite = TRUE
)

sdtm_subject_visits_dictionary <- describe_dataset(
  sdtm_subject_visits,
  .title = "SDTM Subject Visits data",
  USUBJID = "Unique Subject Identifier",
  VISIT = "Protocol defined text description of the visit",
  VISITNUM = "Visit number",
  SVDT = "Subject visit date",
  SVDY = "Study day of subject visit",
  SVSTATUS = "Status of subject visit: Completed, Terminated, Missed, Expected, Overdue, Failed"
)

usethis::use_data(
  sdtm_subject_visits,
  sdtm_subject_visits_dictionary,
  overwrite = TRUE
)


sdtm_vital_signs_dictionary <- describe_dataset(
  sdtm_vital_signs,
  .title = "SDTM Subject Visits data",
  USUBJID = "Unique Subject Identifier",
  VISIT = "Protocol defined text description of the visit",
  VISITNUM = "Visit number",
  VSDT = "Date vital signs were collected",
  VSDY = "Day of study when vital signs were collected",
  VSCAT = "Category of vital signs test",
  VSTEST = "Name of vital signs test",
  VSSTRESU = "Standard units of vital signs test result",
  VSSTRESN = "Result of vital signs test in standard units",
  VSSTNRLO = "Lower limit of normal range for result of vital signs test",
  VSSTNRHI = "Upper (high) limit of normal range for result of vital signs test"
)

usethis::use_data(
  sdtm_vital_signs,
  sdtm_vital_signs_dictionary,
  overwrite = TRUE
)
