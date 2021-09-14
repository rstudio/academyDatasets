#' Hourly Summaries of Rideshare Service Data
#'
#' @description
#' This dataset contains various hourly time series representations of
#' attributes related to Uber and Lyft rideshare services for various locations
#' in New York between 2018-11-26 and 2018-12-18.
#' For a given starting location, provider and service,
#'
#' @source <https://zenodo.org/record/5122114#.YS0--9NKiM9>
#'
#' @format `r rd_describe_format(rideshare, rideshare_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' rideshare %>%
#'   as_tsibble(key = source_location:provider_service, index = timestamp)
"rideshare"

#' @describeIn rideshare The `rideshare` data dictionary
"rideshare_dictionary"
