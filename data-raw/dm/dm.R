# Retrieve dm data set
# Data provided by [Rho](https://rhoinc.github.io/data-library/) under the MIT license.

pkgload::load_all()

remote_url <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/dm.csv"
local_path <- here::here("data-raw", "dm", basename(remote_url))
download.file(remote_url, local_path)

dm <- readr::read_csv(local_path)

dm_dictionary <- describe_dataset(
  dm,
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
  dm,
  dm_dictionary,
  overwrite = TRUE
)
