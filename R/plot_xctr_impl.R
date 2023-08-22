#' Generate financial data plot
#'
#' Generates a ggplot2 object representing the financial data plot.
#'
#' @param data A data frame with prepared financial data
#' @param y_label The label for the y-axis
#' @param benchmark_var The variable for facet wrapping
#' @return A ggplot2 object representing the financial data plot
plot_xctr_impl <- function(data, y_label, benchmark_var) {
  # Create the main plot
  ggplot(data, aes(x = .data$risk_category_var, y = .data[[y_label]], fill = .data$risk_category_var)) +
    facet_wrap(~ .data[[benchmark_var]], scales = "fixed") +
    labs(y = y_label)
}
