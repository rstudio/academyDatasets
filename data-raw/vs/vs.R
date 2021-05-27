# Retrieve lb data set
# Data provided by [Rho](https://rhoinc.github.io/data-library/) under the MIT license.

pkgload::load_all()

remote_url <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/vs.csv"
local_path <- here::here("data-raw", "vs", basename(remote_url))
download.file(remote_url, local_path)

vs <- readr::read_csv(local_path)

vs_dictionary <- describe_dataset(
  vs,
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
  vs,
  vs_dictionary,
  overwrite = TRUE
)
