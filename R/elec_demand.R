#' Victoria, Australia Electricity Demand Data
#'
#' @description
#' Single time series representing the half hourly electricity demand (in gigawatts) for
#' Victoria, Australia in 2014.
#'
#' @source <https://zenodo.org/record/4656069#.YSe0vdNKiM8>
#'
#' @format `r rd_describe_format(elec_demand, elec_demand_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' elec_demand %>%
#'   as_tsibble(index = timestamp)
"elec_demand"

#' @describeIn elec_demand The `elec_demand` data dictionary
"elec_demand_dictionary"
