#' Check if a named object contains expected names
#'
#' Based on fgeo.tool::check_crucial_names()
#'
#' @param x A named object.
#' @param expected_names String; expected names of `x`.
#'
#' @return Invisible `x`, or an error with informative message.
#'
#' Adapted from: https://github.com/RMI-PACTA/r2dii.match/blob/main/R/check_crucial_names.R
#'
#' @examples
#' x <- c(a = 1)
#' check_crucial_names(x, "a")
#' try(check_crucial_names(x, "bad"))
#' @noRd
check_crucial_names <- function(x, expected_names) {
  stopifnot(rlang::is_named(x))
  stopifnot(is.character(expected_names))

  ok <- all(unique(expected_names) %in% names(x))
  if (!ok) {
    abort_missing_names(sort(setdiff(expected_names, names(x))))
  }

  invisible(x)
}

abort_missing_names <- function(missing_names) {
  rlang::abort(
    "missing_names",
    message = glue::glue(
      "Must have missing names:
      {paste0('`', missing_names, '`', collapse = ', ')}"
    )
  )
}


#' Switch mode function
#'
#' Given a mode, this function returns the corresponding finance-related mode name
#' in the data set.
#'
#' @param mode A character string specifying the mode to be switched.
#'
#' @return A character string representing the finance-related mode name that corresponds
#'   to the input mode. If the input mode is not one of the supported options, NULL is returned.
#'
#' @export
#'
#' @examples
#' switch_mode("equal_weight")
#' # Returns: "equal_weight_finance"
#'
#' switch_mode("worst_case")
#' # Returns: "worst_case_finance"
switch_mode <- function(mode) {
  switch(mode,
         "equal_weight" = "equal_weight_finance",
         "worst_case" = "worst_case_finance",
         "best_case" = "best_case_finance",
         "main_activity" = "main_activity"
  )
}
