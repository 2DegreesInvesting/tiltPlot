#' Plot xctr data on a portfolio level, with financial data
#'
#' @param data A data frame like [financial].
#' @param mode A string. Name of the financial weight.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' plot_xctr_portfolio_financial(financial, mode = "worst_case")
plot_xctr_portfolio_financial <- function(data, mode = c("equal_weight", "worst_case", "best_case", "main_activity")) {
  mode <- arg_match(mode)
  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    drop_na(-c(.data$equal_weight_finance, .data$worst_case_finance, .data$best_case_finance, .data$main_activity))

  crucial <- c(
    "main_activity",
    "_risk_category",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))

  risk_category_var <- names_matching(data, "_risk_category")

  data <- data |>
    mutate(risk_category_var = factor(
      data[[risk_category_var]],
      levels = c("low", "medium", "high")
    ))

  xctr_portfolio_grouped <- data |>
    group_by(.data$benchmark, risk_category_var) |>
    summarise(avg_financial_value = mean(.data[[switch_mode(mode)]]))

  ggplot(xctr_portfolio_grouped, aes(x = .data$risk_category_var, y = .data$avg_financial_value, fill = .data$risk_category_var)) +
    geom_bar(stat = "identity") +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    fill_score_colors() +
    theme_tiltplot()
}
