# Retrieve lb data set
# Data provided by [Rho](https://rhoinc.github.io/data-library/) under the MIT license.

pkgload::load_all()

remote_url <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/sv.csv"
local_path <- here::here("data-raw", "sv", basename(remote_url))
download.file(remote_url, local_path)

sv <- readr::read_csv(local_path)

sv_dictionary <- describe_dataset(
  sv,
  .title = "SDTM Subject Visits data",
  USUBJID = "Unique Subject Identifier",
  VISIT = "Protocol defined text description of the visit",
  VISITNUM = "Visit number",
  SVDT = "Subject visit date",
  SVDY = "Study day of subject visit",
  SVSTATUS = "Status of subject visit: Completed, Terminated, Missed, Expected, Overdue, Failed"
)

usethis::use_data(
  sv,
  sv_dictionary,
  overwrite = TRUE
)
