#' Melbourne pedestrian count data
#'
#' @description
#' This dataset records hourly pedestrian counts captured from 66 sensors in
#' Melbourne city, starting from May 2009.
#'
#' @source <https://zenodo.org/record/4656626#.YSVj8FNKjUI>
#'
#' @format `r rd_describe_format(pedestrian_counts, pedestrian_counts_dictionary)`
"pedestrian_counts"
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' pedestrian_counts %>%
#'   tsibble::as_tsibble(key = sensor_id, index = date)
#'
#' @describeIn pedestrian_counts The `pedestrian_counts` data dictionary
"pedestrian_counts_dictionary"
