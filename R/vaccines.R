#' COVID-19 Vaccine Distribution Allocations
#'
#' @description
#'
#' A dataset containing the number of COVID-19 vaccines allocated in the US by date,
#' manufacturer, and state/territory.
#'
#' @source <https://data.cdc.gov/browse?category=Vaccinations>
#'
#' @format `r rd_describe_format(vaccines, vaccines_dictionary)`
"vaccines"

#' @describeIn vaccines The `vaccines` data dictionary
"vaccines_dictionary"


#' Modification of Diet In Renal Disease - Supplemental Data
#'
#' Supplemental data for the [mdrd] dataset. Note: this data is simulated and is
#' not from the original MDRD study.
#'
#' @source <https://repository.niddk.nih.gov/studies/mdrd/>
#' @family MDRD datasets
#'
#' @format `r rd_describe_format(mdrd_supplemental, mdrd_supplemental_dictionary)`
"mdrd_supplemental"

#' @describeIn mdrd_supplemental The `mdrd_supplemental` data dictionary
"mdrd_supplemental_dictionary"
