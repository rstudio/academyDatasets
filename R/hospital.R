#' Monthly counts of patients use of medical products
#'
#' @description
#' Monthly patient count for products that are related to medical problems. There are 767 time series that had a mean count of at least 10 and no zeros.
#'
#' @source <https://robjhyndman.com/expsmooth/>
#' @family hospital timeseries datasets
#'
#' @format `r rd_describe_format(hospital, hospital_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' library(dplyr)
#' hospital %>%
#'   mutate(
#'     date = yearmonth(paste(year, month, sep = "-")),
#'     .keep = "unused"
#'   ) %>%
#'   as_tsibble(key = c(sku, entity_code), index = date)
"hospital"

#' @describeIn hospital The `hospital` data dictionary
"hospital_dictionary"
