#' Check crucial columns in data
#'
#' Checks for the presence of crucial columns in the data.
#'
#' @param data A data frame to be checked
#' @param crucial A character vector of column names that are crucial
check_data <- function(data, crucial) {
  check_crucial_names(data, names_matching(data, crucial))
}
