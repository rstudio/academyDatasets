# Retrieve cm data set
# Data provided by [Rho](https://rhoinc.github.io/data-library/) under the MIT license.

pkgload::load_all()

remote_url <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/cm.csv"
local_path <- here::here("data-raw", "cm", basename(remote_url))
download.file(remote_url, local_path)

cm <- readr::read_csv(local_path) %>%
  select(-CMINDC)

cm_dictionary <- describe_dataset(
  cm,
  .title = "SDTM formatted Concomitant Mediaction data",
  USUBJID = "Unique Subject Identifier",
  CMSEQ = "Sequence Number",
  CMSTDT = "Start date of the concomitant mediaction",
  CMSTDY = "The number of days the subject had been enrolled in the study when the concomitant mediaction began.",
  CMENDT = "End date of the concomitant mediaction",
  CMENDY = "The number of days the subject had been enrolled in the study when the concomitant mediaction ended.",
  CMTRT = "Reported name of the concomitant medication, i.e concomitant treatment",
  PREFTERM = "The nonproprietary, i.e. generic, name of the concomitant medication",
  ATCTEXT2 = "Anatomical Therapeutic Chemical (ATC) of the concomitant medication",
  CMONGO = "Is the concomitant medication ongoing? `Y` = Yes, `N` = No",
  CMDOSE = "Amount of concomitant medication taken per administration (dose)",
  CMROUTE = "Route of administration of the concomitant medication"
)

usethis::use_data(
  cm,
  cm_dictionary,
  overwrite = TRUE
)
