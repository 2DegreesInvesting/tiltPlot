#' Plot xctr data on a company or portfolio level, with financial data
#'
#' Plots the financial data for either a specific company or for the portfolio as a whole.
#'
#' @param data A data frame like [financial]
#' @param company_name (optional) The name of the specific company to plot the
#' financial data for. If NULL, the function will plot the financial data for the portfolio.
#' @param mode The mode of financial data to plot.
#' It can be one of "equal_weight", "worst_case" or "best_case".
#'
#' @return A ggplot2 object representing the financial data plot.
#'
#' @export
#'
#' @examples
#' # Example 1: Plot financial data for a specific company
#' plot_xctr_financial(data = financial, company_name = "peter", mode = "equal_weight")
#'
#' # Example 2: Plot portfolio-level financial data
#' plot_xctr_financial(data = financial, mode = "worst_case")
#'
plot_xctr_financial <- function(data,
                                company_name = NULL,
                                mode = c("equal_weight", "worst_case", "best_case")) {
  mode <- arg_match(mode)

  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    drop_na(-c(.data$equal_weight_finance, .data$worst_case_finance, .data$best_case_finance))

  crucial <- c(
    "_risk_category",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))

  risk_var <- names_matching(data, "_risk_category")

  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

  y_var <- switch_mode(mode)
  y_label <- if (is.null(company_name)) "avg_financial_value" else y_var

  data <- if (is.null(company_name)) {
    data |>
      group_by(.data$benchmark, .data$risk_category_var) |>
      summarise(avg_financial_value = mean(.data[[y_var]]))
  } else {
    data |>
      filter(company_name == .env$company_name)
  }

  ggplot(data, aes(x = .data$risk_category_var, y = .data[[y_label]], fill = .data$risk_category_var)) +
    geom_col() +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    fill_score_colors() +
    theme_tiltplot() +
    labs(y = y_label)
}
