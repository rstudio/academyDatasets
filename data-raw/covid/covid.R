pkgload::load_all()
library(readr)
library(dplyr)
library(purrr)
library(lubridate)

download.file(
  "https://api.covidtracking.com/v2/states.json",
  here::here("data-raw", "covid", "states.json")
)

download.file(
  "https://covidtracking.com/data/download/all-states-history.csv",
  here::here("data-raw", "covid", "all-states-history.csv")
)

covid_state_pop <-
  here::here("data-raw", "covid", "states.json") %>%
  jsonlite::fromJSON(simplifyVector = FALSE) %>%
  .$data %>%
  map_dfr(function(x) {
    tibble(state = x$state_code, population = x$census$population)
  }) %>%
  filter(state %in% state.abb) %>%
  mutate(state = factor(state, state.abb))

covid <-
  here::here("data-raw", "covid", "all-states-history.csv") %>%
  read_csv() %>%
  select(
    date,
    state,
    tests = totalTestResultsIncrease,
    cases = positiveIncrease,
    hospitalizations = hospitalizedIncrease,
    deaths = deathIncrease
  ) %>%
  mutate(date = ymd(date), state = factor(state, state.abb)) %>%
  arrange(date, state)


covid_dictionary <- describe_dataset(
  covid,
  .title = "COVID-19 US Historical Data by State",
  data = "Date on which data was collected by The COVID Tracking Project.",
  state = "Two-letter abbreviation for the state or territory.",
  tests = "Daily increase in totalTestResults, calculated from the previous day’s value.",
  cases = "The daily increase in API field positive, which measures Cases (confirmed plus probable) calculated based on the previous day’s value.",
  hospitalizations = "Daily increase in hospitalizedCumulative, calculated from the previous day’s value.",
  deaths = "Daily increase in death, calculated from the previous day’s value."
)

usethis::use_data(
  covid,
  covid_dictionary,
  covid_state_pop
)
