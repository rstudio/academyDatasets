#' Kaggle Tourism forecasting competition time series
#'
#' @description
#' From [Athanasopoulos, Hyndman, Song, and Wu (2010)](https://robjhyndman.com/papers/forecompijf.pdf)
#'
#' The data include 366 monthly series. They were supplied by both tourism
#' bodies (such as Tourism Australia, the Hong Kong Tourism Board and Tourism
#' New Zealand) and various academics, who had used them in previous tourism
#' forecasting studies.
#'
#' In order to adhere to all confidentiality agreements with all parties, the
#' data are presented under coded titles.
#'
#' City and countries were fabricated and assigned to the data. This data does
#' not reflect true tourism trends for these cities.
#' @source <https://zenodo.org/record/4656096>
#'
#' @format `r rd_describe_format(tourists, tourists_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(dplyr)
#' library(tsibble)
#' tourists %>%
#'   mutate(month = yearmonth(month)) %>%
#'   as_tsibble(key = c("city", "country"), index = month)
"tourists"

#' @describeIn tourists The `tourists` data dictionary
"tourists_dictionary"
