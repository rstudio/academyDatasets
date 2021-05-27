#' COVID-19 US Historical Data by State
#'
#' @description
#' From [The COVID Tracking Project](https://covidtracking.com):
#'
#' We collect, cross-check, and publish COVID-19
#' [data](https://covidtracking.com/data) from 56 US states and territories in
#' three main areas: **testing, hospitalization, and patient outcomes**,
#' **racial and ethnic demographic information** via
#' [The COVID Racial Data Tracker](https://covidtracking.com/race), and
#' **long-term-care facilities** via the
#' [Long-Term-Care tracker](https://covidtracking.com/data/longtermcare).
#' We compile these numbers to provide the most complete picture we can assemble
#' of the US COVID-19 testing effort and the outbreak’s effects on the people
#' and communities it strikes.
#'
#' If you’d like to use the data, whether it’s for a specialized project or just
#' to better understand COVID-19 in the US, here are a few things you should
#' know right away.
#'
#' - We update [the full dataset](https://covidtracking.com/data/) each day
#'   between about 5:30pm and 7pm Eastern time, with limited additional updates
#'   as new information arrives.
#'
#' - All our data comes from state and territory public health authorities or
#'   official statements from state officials. Not all states report all data,
#'   which means we can’t, either. You can
#'   [read more about our data sources here](https://covidtracking.com/data-sources).
#'
#' @source <https://covidtracking.com/data/download/all-states-history.csv>
#' @family COVID-19 datasets
#'
#' @format `r rd_describe_format(covid, covid_dictionary)`
"covid"

#' @describeIn covid The `covid` data dictionary
"covid_dictionary"

#' COVID-19 US State Populations
#'
#' State populations as reported by the
#' [The COVID Tracking Project](https://covidtracking.com).
#'
#' @source <https://api.covidtracking.com/v2/states.json>
#' @family COVID-19 datasets
#'
#' @format A tibble with 50 rows and 2 variables:
#' \describe{
#'   \item{\code{state}}{\[factor\] Two-letter abbreviation for the state or territory.}
#'   \item{\code{population}}{\[int\] The state population, as reported by the COVID-19 Tracking Project.}
#' }
"covid_state_pop"
