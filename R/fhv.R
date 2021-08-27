#' For-hire Vehicle (FHV) Trips
#'
#' @description
#' This dataset contains number of trips and vehicles belonging to
#' `r length(unique(fhv$base_name))` for-hire vehicle (FHV) companies in
#' New York City from January to August, 2015. Data were originally obtained
#' from the NYC Taxi & Limousine Commission (TLC).
#'
#' @source <https://zenodo.org/record/5122535#.YSk1SNNKiDE>
#'
#' @format `r rd_describe_format(fhv, fhv_dictionary)`
"fhv"

#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' library(dplyr)
#' fhv %>%
#'   tsibble::as_tsibble(key = starts_with("base"), index = date)

#' @describeIn fhv The `fhv` data dictionary
"fhv_dictionary"
