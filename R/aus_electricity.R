#' Australian electricity demand data
#'
#' @description
#' This dataset records half-hourly electricity demand for five states in
#' Australia: Victoria, New South Wales, Queensland, Tasmania, and South Australia.
#'
#' @source <https://zenodo.org/record/4659727>
#'
#' @format `r rd_describe_format(aus_electricity, aus_electricity_dictionary)`
"aus_electricity"
#'
#' @examples
#' # Convert to `tsibble`
#' aus_electricity %>%
#'   tsibble::as_tsibble(key = state, index = date)
#'
#' @describeIn aus_electricity The `aus_electricity` data dictionary
"aus_electricity_dictionary"
