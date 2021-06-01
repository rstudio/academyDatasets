#' Modification of Diet in Renal Disease (MDRD)
#'
#' @description
#'
#' From [NIDDK](https://repository.niddk.nih.gov/studies/mdrd/):
#'
#' _The Modification of Diet in Renal Disease (MDRD) study consisted of two
#' randomized clinical trials that investigated whether protein restriction and
#' control of blood pressure had an effect on the progression of chronic kidney
#' disease (CKD). The study tested two hypotheses—that (1) a reduction in
#' dietary protein and phosphorous intake and (2) the maintenance of blood
#' pressure at a level below that usually recommended safely and effectively
#' delays the progression of CKD._
#'
#' Our data is from Study 2, which included patients with relatively advanced
#' renal disease (GFR between 13 and 24 ml/min). From
#' [NIDDK](https://repository.niddk.nih.gov/studies/mdrd/):
#'
#' _In study 2, 255 patients with GFR of 13 to 24 ml/min/1.73 m2 were randomly
#' assigned to the low-protein diet (0.58 g per kilogram per day) or a
#' very-low-protein diet (0.28 g per kilogram per day) with a keto acid-amino
#' acid supplement, and a usual- or a low-blood-pressure group (same values as
#' those in study 1). The length of follow-up varied from 18-to-45-months, with
#' monthly evaluations of the patients. The primary outcome was the change in
#' GFR rate over time._
#'
#' ### Dropout
#'
#' Many patients dropped out of the study before completion. Whether or not a
#' patient dropped out is captured in the `dropout` variable. Reasons for
#' dropout included dialysis, kidney transplant, death, and other medical
#' reasons.
#'
#' @source <https://repository.niddk.nih.gov/studies/mdrd/>
#' @family MDRD datasets
#'
#' @format `r rd_describe_format(mdrd, mdrd_dictionary)`
"mdrd"

#' @describeIn mdrd The `mdrd` data dictionary
"mdrd_dictionary"


#' Modification of Diet In Renal Disease - Supplemental Data
#'
#' @description
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
