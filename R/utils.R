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
#' @examples
#' switch_mode("equal_weight")
#' # Returns: "equal_weight_finance"
#'
#' switch_mode("worst_case")
#' # Returns: "worst_case_finance"
#' @noRd
switch_mode <- function(mode) {
  switch(mode,
    "equal_weight" = "equal_weight_finance",
    "worst_case" = "worst_case_finance",
    "best_case" = "best_case_finance"
  )
}

#' Get column names matching a specific pattern
#'
#' This function takes a data frame and a pattern as input and returns the column names
#' that match the given pattern.
#'
#' @param data A data frame.
#' @param pattern A regular expression pattern to match column names.
#'
#' @return A character vector containing the column names that match the pattern.
#'
#' @examples
#' data <- data.frame(abc = 1:5)
#'
#' # Get column names containing "ab"
#' names_matching(data, "ab")
#' @noRd
names_matching <- function(data, pattern) {
  names(select(data, matches(pattern)))
}


#' Convert vector to risk category
#'
#' @param x
#'
#' @return A factor representing the risk category with levels: "low", "medium", and "high".
#'
#' @examples
#' x <- c("low", "low")
#' as_risk_category(x)
#' @noRd
as_risk_category <- function(x) {
  check_levels(x)
  factor(x, levels = risk_category_levels())
}

check_levels <- function(x) {
  stopifnot(all(sort(unique(x)) %in% sort(risk_category_levels())))
}

risk_category_levels <- function() c("low", "medium", "high")


#' Calculate Proportions for Worst or Best Case Scenarios
#'
#' @param categories A factor vector of risk categories.
#' @param mode A character string specifying the mode.
#'
#' @return A numeric vector representing the calculated proportions for each
#' category.
#'
#' @examples
#' categories <- as_risk_category(c("low", "medium", "medium", "high"))
#' calculate_case_proportions(categories, mode = "worst_case")
#' @noRd
calculate_case_proportions <- function(categories, mode) {
  if (mode == "worst_case") {
    extreme_risk <- levels(categories)[max(as.integer(categories))]
  } else if (mode == "best_case") {
    extreme_risk <- levels(categories)[min(as.integer(categories))]
  }

  is_extreme <- categories == extreme_risk
  proportions <- ifelse(is_extreme, 1 / sum(is_extreme), 0)

  return(proportions)
}
