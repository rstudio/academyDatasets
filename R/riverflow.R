#' Daily flow rate of the Saugeen River
#'
#' @description
#' This dataset contains a time series representing the daily mean flow in cubic
#' meters per second of the Saugeen River in Ontario, Canada from 01/01/1915
#' to 12/31/1979.
#'
#' @source <https://zenodo.org/record/4656058#.YSY4VtNKjJJ>
#'
#' @format `r rd_describe_format(riverflow, riverflow_dictionary)`
"riverflow"

#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' riverflow %>%
#'   tsibble::as_tsibble()

#' @describeIn riverflow The `riverflow` data dictionary
"riverflow_dictionary"
