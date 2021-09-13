#' U.S. macro-economic indicators from the FRED-MD database.
#'
#' @description
#'
#' A dataset containing six macro-economic indicators tracked by the Federal
#' Reserve Bank, extracted from the FRED-MD database.
#'
#' For more information on a variable, look it up by name here:
#' <https://fred.stlouisfed.org/>
#'
#' @source <https://research.stlouisfed.org/econ/mccracken/fred-databases/>
#'
#' @format `r rd_describe_format(fred_md, fred_md_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(dplyr)
#' library(tsibble)
#' fred_md %>%
#'   mutate(date = yearmonth(date)) %>%
#'   as_tsibble(index = date)
"fred_md"

#' @describeIn fred_md The `fred_md` data dictionary
"fred_md_dictionary"
