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

#' Switch mode function for emission profile plots
#'
#' @param mode A character string.
#'
#' @return A character string.
#'
#' @examples
#' switch_mode("equal_weight")
#' # Returns: "equal_weight_emission_profile"
#'
#' switch_mode("worst_case")
#' # Returns: "worst_case_emission_profile"
#' @noRd
switch_mode_emission_profile <- function(mode) {
  switch(mode,
    "equal_weight" = "equal_weight_emission_profile",
    "worst_case" = "worst_case_emission_profile",
    "best_case" = "best_case_emission_profile"
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

#' Get column name
#'
#' @param data A data frame.
#' @param column_name A character vector.
#'
#' @return A character vector.
#'
#' @examples
#' data <- data.frame(ab = 1:3, abc = 4:6)
#'
#' # Get column name "abc"
#' get_colname(data, "abc")
#' @noRd
get_colname <- function(data, column_name) {
  exact_match <- which(names(data) == column_name)
  names(data)[exact_match]
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

plot_data <- function(p, name) p$data[[name]]

add <- function(x) sum(x, na.rm = TRUE)

risk_category_levels <- function() c("low", "medium", "high")

#' Benchmarks used in the functions' arguments.
#'
#' @examples
#' benchmarks()
#' @keywords internal
#' @export
benchmarks <- function() {
  c(
    "all",
    "isic_4digit",
    "tilt_sector",
    "unit",
    "unit_isic_4digit",
    "unit_tilt_sector"
  )
}


#' Create a dictionary for brittle columns names
#'
#' @return A data frame.
#' @noRd
dictionary <- function() {
  #styler: off
  tibble::tribble(
                      ~aka,                         ~column,
               "best_case",    "best_case_emission_profile",
            "companies_id",                  "companies_id",
       "europages_product",                    "ep_product",
            "equal_weight", "equal_weight_emission_profile",
         "profile_ranking",               "profile_ranking",
           "risk_category",              "emission_profile",
                "scenario",                      "scenario",
   "transition_risk_score",         "transition_risk_score",
         "transition_risk",               "transition_risk",
             "tilt_sector",                   "tilt_sector",
                    "year",                          "year",
              "worst_case",   "worst_case_emission_profile"
   )
  # styler: on
}

aka <- function(x) {
  candidates <- dictionary() |>
    filter(aka == x) |>
    pull(.data$column)
  candidates
}

pattern <- function(x) paste0(x, collapse = "|")

#' Modes
#'
#' @keywords internal
#' @export
modes <- function() {
  c(
    "equal_weight",
    "best_case",
    "worst_case"
  )
}

#' Scenarios
#'
#' @keywords internal
#' @export
scenarios <- function() {
  c(
    "1.5C RPS",
    "NZ 2050"
  )
}

#' Scenarios Financial
#'
#' @keywords internal
#' @export
scenarios_financial <- function() {
  c(
    "IPR",
    "WEO"
  )
}

#' Years
#'
#' @keywords internal
#' @export
years <- function() {
  c(
    2030,
    2050
  )
}
