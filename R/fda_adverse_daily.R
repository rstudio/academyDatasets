#' Daily counts of FDA drug adverse event reports
#'
#' @description
#'
#' This data set contains daily counts of reports received by the Food and Drug
#' Administration (FDA) from 2004 to 2020 regarding adverse events associated
#' with the administration of drugs in medical settings. This data was collected
#' from the [FDA Adverse Event Reporting System (FAERS)](https://open.fda.gov/data/faers/),
#' and has been made available through [openFDA](https://open.fda.gov/).
#'
#' According to openFDA: "an adverse event is submitted to the FDA to report any
#' undesirable experience associated with the use of a medical product in a
#' patient. For drugs, this includes serious drug side effects, product use errors,
#' product quality problems, and therapeutic failures for prescription or
#' over-the-counter medicines and medicines administered to hospital patients
#' or at outpatient infusion centers.
#'
#' Reporting of adverse events by healthcare professionals and consumers
#' is voluntary in the United States. FDA receives some adverse event reports
#' directly from healthcare professionals (such as physicians, pharmacists,
#' nurses and others) and consumers (such as patients, family members, lawyers
#' and others). Healthcare professionals and consumers may also report adverse
#' events to the products’ manufacturers. If a manufacturer receives an adverse
#' event report, it is normally required to send the report to FDA."
#'
#' @source <https://open.fda.gov/apis/drug/event/>
#' @family openFDA datasets
#'
#' @format `r rd_describe_format(fda_adverse_daily, fda_adverse_daily_dictionary)`
"fda_adverse_daily"

#' @describeIn fda_adverse_daily The `fda_adverse_daily` data dictionary
"fda_adverse_daily_dictionary"
