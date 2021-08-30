#' Monthly Car Part Sales
#'
#' @description
#' This dataset contains 2674 intermittent monthly time series that represent
#' car parts sales from January 1998 to March 2002.
#' It was extracted from R expsmooth package.
#'
#' @source <https://zenodo.org/record/4656022#.YSzxsNNKj6O>
#'
#' @format `r rd_describe_format(car_parts, car_parts_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' car_parts %>%
#'   as_tsibble(key = part_num, index = date)
"car_parts"

#' @describeIn car_parts The `car_parts` data dictionary
"car_parts_dictionary"
