# remotes::install_github("ropenhealth/openfda")
library(openfda)
library(tidyverse)
library(lubridate)

# load {academyDatasets} for access to helper functions
pkgload::load_all()

# search for reports from Jan 1, 2004 to Dec 31, 2020
query <-
  fda_query("/drug/event.json") %>%
  fda_filter("receivedate", "[20040101+TO+20201231]")

# daily counts for reports originating from public
public <-
  query %>%
  # _missing_:companynumb = reported directly by a member of the public
  fda_filter("_missing_", "companynumb") %>%
  fda_count("receivedate") %>%
  fda_exec() %>%
  as_tibble() %>%
  rename(public = count)

# daily counts for reports originating from drug manufacturer
manufacturer <-
  query %>%
  # _exists_:companynumb = reported through a drug manufacturer
  fda_filter("_exists_", "companynumb") %>%
  fda_count("receivedate") %>%
  fda_exec() %>%
  as_tibble() %>%
  rename(manufacturer = count)

# join into single data set
fda_adverse_daily <-
  full_join(public, manufacturer, by = "time") %>%
  replace_na(list(public = 0, manufacturer = 0)) %>%
  rename(receive_date = time) %>%
  mutate(receive_date = ymd(receive_date)) %>%
  arrange(receive_date)

fda_adverse_daily_dictionary <- describe_dataset(
  fda_adverse_daily,
  .title = "Daily counts of FDA drug adverse event reports",
  receive_date = "Date that the report was first received by FDA.",
  public = "Number of reports that were submitted directly by a member of the public.",
  manufacturer = "Number of reports that were submitted through a drug manufacturer."
)

usethis::use_data(
  fda_adverse_daily,
  fda_adverse_daily_dictionary,
  overwrite = TRUE
)
