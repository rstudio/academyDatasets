`%||%` <- function(x, y) if (is.null(x)) y else x

#' Describe the dataset
#'
#' An internal function to construct a machine-friendly description of the
#' dataset.
#'
#' @param x The data set
#' @param ... Descriptions of column names.
#'
#' @keywords internal
describe_dataset <- function(x, ..., .title = NULL) {
  var_desc <- list(...)
  desc <- list(
    dims = if (is.data.frame(x)) list(
      rows = nrow(x),
      cols = ncol(x)
    ),
    title = .title %||% deparse(substitute(x)),
    variables = lapply(names(x), function(var) {
      data.frame(
        variable = var,
        type = typeof(x[[var]]),
        description = var_desc[[var]] %||% NA_character_,
        stringsAsFactors = FALSE
      )
    })
  )

  desc$variables <- do.call(rbind, desc$variables)
  class(desc$variables) <- c("tbl_df", "tbl", "data.frame")
  desc
}

rd_describe_format <- function(x, dd) {
  #' @format A data frame with 255 rows and 10 variables:
  #' \describe{
  #'   \item{\code{NAME}}{[TYPE] DESCRIPTION}
  #'   ...
  #' }

  type_of_thing <- switch(
    class(x)[[1]],
    "tbl_df" = "tibble",
    "data.frame" = "data frame",
    class(x)[[1]]
  )

  fmt <- if (type_of_thing %in% c("tibble", "data frame")) {
    sprintf(
      "A %s with %d rows and %d variables:",
      type_of_thing,
      dd$dims$rows,
      dd$dims$cols
    )
  } else {
    sprintf("A %s:", type_of_thing)
  }

  items <- apply(dd$variables, 1, function(v) {
    if (is.na(v["description"])) v["description"] <- ""
    sprintf("\n  \\item{\\code{%s}}{\\[%s\\] %s}", v["variable"], v["type"], v["description"])
  })

  paste0(fmt, "\n\\describe{\n", paste(items, collapse = ""), "\n}")
}
