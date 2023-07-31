#' Plot xctr data on a company level with financial data
#'
#' @param data A data frame like [financial].
#' @param company_name A string. Name of one company in the data set.
#' @param mode A string. Name of the financial weight.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' plot_xctr_company_financial(financial, company_name = "peter", mode = "best_case")
plot_xctr_company_financial <- function(data, company_name, mode = c("equal_weight", "worst_case", "best_case", "main_activity")) {
  mode <- arg_match(mode)

  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    drop_na(-c(.data$equal_weight_finance, .data$worst_case_finance, .data$best_case_finance, .data$main_activity)) |>
    filter(company_name == .env$company_name)

  crucial <- c(
    "main_activity",
    "_risk_category",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(c(names(select(data, matches(crucial)))))

  risk_category_var <- names(select(data, matches("_risk_category")))

  data <- data |>
    mutate(risk_category_var = factor(
      data[[risk_category_var]],
      levels = c("low", "medium", "high")
    ))

  ggplot(data, aes(x = .data$risk_category_var, y = .data[[switch_mode(mode)]], fill = .data$risk_category_var)) +
    geom_bar(stat = "identity") +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    fill_score_colors() +
    theme_tiltplot()
}
