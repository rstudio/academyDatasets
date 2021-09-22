#' Solar Power
#'
#' @description
#' This dataset contains weekly solar power production records from 137
#' photovoltaic (PV) power plants in Alabama, in 2006. The data were originally
#' collected by the National Renewable Energy Laboratory (NREL): <https://www.nrel.gov/>
#'
#' @source <https://zenodo.org/record/4656151#.YSktINNKjSU>
#'
#' @format `r rd_describe_format(solar, solar_dictionary)`
"solar"

#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' solar %>%
#'   as_tsibble(key = plant, index = date)

#' @describeIn solar The `solar` data dictionary
"solar_dictionary"
