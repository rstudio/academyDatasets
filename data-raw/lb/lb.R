# Retrieve lb data set
# Data provided by [Rho](https://rhoinc.github.io/data-library/) under the MIT license.

pkgload::load_all()

remote_url <- "https://raw.githubusercontent.com/RhoInc/data-library/master/data/clinical-trials/sdtm/lb.csv"
local_path <- here::here("data-raw", "lb", basename(remote_url))
download.file(remote_url, local_path)

lb <- readr::read_csv(local_path)

lb_dictionary <- describe_dataset(
  lb,
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
  lb,
  lb_dictionary,
  overwrite = TRUE
)
