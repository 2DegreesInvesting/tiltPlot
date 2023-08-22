#' Prepare financial data for plotting
#'
#' Prepares the financial data for plotting by handling missing values and transforming risk categories.
#'
#' @param data A data frame like [financial]
#' @return A processed data frame ready for plotting
prepare_financial_data <- function(data) {
  data <- data %>%
    drop_na(-c(.data$equal_weight_finance, .data$worst_case_finance, .data$best_case_finance, .data$main_activity))

  risk_var <- names_matching(data, "_risk_category")

  data <- data %>%
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

  return(data)
}




