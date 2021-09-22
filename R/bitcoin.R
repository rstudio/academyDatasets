#' bitcoin
#'
#' @description
#' This dataset contains the potential influencers of the bitcoin price.
#' There are a total of 18 daily time-series including hash rate, block size, mining difficulty etc.
#' It also encompasses public opinion in the form of tweets and google searches mentioning the keyword bitcoin.
#' The data is scraped from the interactive web-graphs available at <https://bitinfocharts.com>.
#'
#' For more details, please refer to
#' BitInfoCharts, 2021. Cryptocurrency statistics. URL <https://bitinfocharts.com>
#'
#' @source <https://forecastingdata.org/>
#'
#' @format `r rd_describe_format(bitcoin, bitcoin_dictionary)`
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' bitcoin %>%
#'   as_tsibble()
"bitcoin"

#' @describeIn bitcoin The `bitcoin` data dictionary
"bitcoin_dictionary"
