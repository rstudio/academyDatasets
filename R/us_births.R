#' us_births
#'
#' @description
#' This dataset contains a single very long daily time series representing the
#' number of births in US from 01/01/1969 to 31/12/1988. It was extracted from R
#' mosaicData package. The length of this time series is 7305.
#'
#' For more details, please refer to Pruim, R., Kaplan, D., Horton, N., 2020.
#' mosaicData: project mosaic data sets. R package version 0.18.0.
#' <https://CRAN.R-project.org/package=mosaicData>
#'
#' @source <https://forecastingdata.org/>
#'
#' @format `r rd_describe_format(us_births, us_births_dictionary)`
"us_births"
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' us_births %>%
#'   as_tsibble()

#' @describeIn us_births The `us_births` data dictionary
"us_births_dictionary"


