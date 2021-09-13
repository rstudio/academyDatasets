#' Weekly Electricity Consumption
#'
#' @description
#' This dataset contains weekly aggregated electricity consumption for 321
#' clients in Portugal from 2012 to 2014.
#'
#' @source <https://zenodo.org/record/4656141#.YSkxU9NKiM8>
#'
#' @format `r rd_describe_format(electricity_weekly, electricity_weekly_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' electricity_weekly %>%
#'   as_tsibble(key = client, index = date)
"electricity_weekly"

#' @describeIn electricity_weekly The `electricity_weekly` data dictionary
"electricity_weekly_dictionary"
