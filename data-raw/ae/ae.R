# Retrieve ae data set
# Data provided by [Rho](https://rhoinc.github.io/data-library/) under the MIT license.

pkgload::load_all()

remote_url <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/ae.csv"
local_path <- here::here("data-raw", "ae", basename(remote_url))
download.file(remote_url, local_path)

ae <- readr::read_csv(local_path)

ae_dictionary <- describe_dataset(
  ae,
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
  ae,
  ae_dictionary,
  overwrite = TRUE
)
