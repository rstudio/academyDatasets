#' Daily historical sunspot data
#'
#' @description
#'
#' A dataset containing daily sunspot counts, from
#' `r format(min(sunspots$date), "%B %d, %Y")` to
#' `r format(max(sunspots$date), "%B %d, %Y")`.
#'
#' @source <https://zenodo.org/record/4654773#.YSVlvdNKg8M>
#'
#' @format `r rd_describe_format(sunspots, sunspots_dictionary)`
"sunspots"

#' @describeIn sunspots The `sunspots` data dictionary
"sunspots_dictionary"

