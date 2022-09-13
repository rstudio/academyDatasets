#' Duchenne Muscular Dystrophy Dataset
#'
#' @description
#'
#' From the data source page: "This dataset is from M. Percy, listed in Table 38
#' of DF Andrews and AM Herzberg: Data, New York: Springer-Verlag, 1985 and also
#' available on StatLib. The 209 observations correspond to blood samples on 192
#' patients (17 patients have two samples in the dataset) collected in a project
#' to develop a screening program for female relatives of boys with DMD. The
#' program's goal was to inform a woman of her chances of being a carrier based
#' on serum markers as well as her family pedigree. Another question of interest
#' is whether age and season should be taken into account. Enzyme levels were
#' measured in known carriers (75 samples) and in a group of non-carriers (134
#' samples). Note that the original observation numbers (within subject) on this
#' dataset do not agree with replicates of hospital IDs, so they have been
#' recomputed here. Another anomaly of the dataset is that 16 out of 17 subjects
#' having two blood samples drawn had differing carrier status for the two
#' observations. The first two serum markers, creatine kinase and hemopexin, are
#' inexpensive to obtain, while the last two, pyruvate kinase and lactate
#' dehydroginase, are more expensive. It is of interest to measure how much pk
#' and ld add toward predicting the carrier status. The importance of age and
#' sample date is also of interest. Percy noted that the water supply for the
#' lab changed during the study."
#'
#' @source <https://biostat.app.vumc.org/wiki/pub/Main/DataSets/dmd.html>
#' @family DMD datasets
#'
#' @format `r rd_describe_format(dmd, dmd_dictionary)`
"dmd"
