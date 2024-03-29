% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mdrd.R
\docType{data}
\name{mdrd}
\alias{mdrd}
\alias{mdrd_dictionary}
\title{Modification of Diet in Renal Disease (MDRD)}
\format{
A tibble with 1988 rows and 10 variables:
\describe{

\item{\code{ptid}}{[dbl] Patient identifier}
\item{\code{gfr}}{[dbl] Glomerular filtration rate in milliliters per minute. A measure of how much blood the kidneys filter per minute. }
\item{\code{months}}{[dbl] Number of months after the start of the study that the measurement was taken. }
\item{\code{dietl_normbp}}{[dbl] Was the participant assigned to the low-protein, normal-blood pressure diet? (0 = No, 1 = Yes)}
\item{\code{dietl_lowbp}}{[dbl] Was the participant assigned to the low-protein, low-blood pressure diet? (0 = No, 1 = Yes)}
\item{\code{dietk_normbp}}{[dbl] Was the participant assigned to the very low-protein, normal-blood pressure diet? (0 = No, 1 = Yes)}
\item{\code{dietk_lowbp}}{[dbl] Was the participant assigned to the very low-protein, low-blood pressure diet? (0 = No, 1 = Yes)}
\item{\code{log_protein}}{[dbl] Logarithm of the grams of protein consumed per day.}
\item{\code{followupmonths}}{[dbl] Number of months until patient follow-up.}
\item{\code{dropout}}{[dbl] Did the patient drop out of the study? (0 = No, 1 = Yes)}
}

An object of class \code{list} of length 3.
}
\source{
\url{https://repository.niddk.nih.gov/studies/mdrd/}
}
\usage{
mdrd

mdrd_dictionary
}
\description{
From \href{https://repository.niddk.nih.gov/studies/mdrd/}{NIDDK}:

\emph{The Modification of Diet in Renal Disease (MDRD) study consisted of two
randomized clinical trials that investigated whether protein restriction and
control of blood pressure had an effect on the progression of chronic kidney
disease (CKD). The study tested two hypotheses—that (1) a reduction in
dietary protein and phosphorous intake and (2) the maintenance of blood
pressure at a level below that usually recommended safely and effectively
delays the progression of CKD.}

Our data is from Study 2, which included patients with relatively advanced
renal disease (GFR between 13 and 24 ml/min). From
\href{https://repository.niddk.nih.gov/studies/mdrd/}{NIDDK}:

\emph{In study 2, 255 patients with GFR of 13 to 24 ml/min/1.73 m2 were randomly
assigned to the low-protein diet (0.58 g per kilogram per day) or a
very-low-protein diet (0.28 g per kilogram per day) with a keto acid-amino
acid supplement, and a usual- or a low-blood-pressure group (same values as
those in study 1). The length of follow-up varied from 18-to-45-months, with
monthly evaluations of the patients. The primary outcome was the change in
GFR rate over time.}
\subsection{Dropout}{

Many patients dropped out of the study before completion. Whether or not a
patient dropped out is captured in the \code{dropout} variable. Reasons for
dropout included dialysis, kidney transplant, death, and other medical
reasons.
}
}
\section{Functions}{
\itemize{
\item \code{mdrd_dictionary}: The \code{mdrd} data dictionary

}}
\seealso{
Other MDRD datasets: 
\code{\link{mdrd_supplemental}}
}
\concept{MDRD datasets}
\keyword{datasets}
