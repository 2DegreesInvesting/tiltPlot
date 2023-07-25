#' Plot xctr data on a company level with financial data
#'
#' @param data A data frame like [financial].
#' @param company_name A string. Name of one company in the data set.
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
    na.omit() |>
    filter(company_name == .env$company_name)

  crucial_names <- c(
    names(select(data, matches("_risk_category"))),
    names(select(data, matches("equal_weight_finance"))),
    names(select(data, matches("worst_case_finance"))),
    names(select(data, matches("best_case_finance"))),
    names(select(data, matches("main_activity")))
  )
  data |> check_crucial_names(crucial_names)

  risk_category_var <- names(select(data, matches("_risk_category")))

  data <- data |>
    mutate(risk_category_var = factor(
      data[[risk_category_var]],
      levels = c("low", "medium", "high")
    ))

  score_colors <- score_colors()

  y_var <- switch(
    mode,
    "equal_weight" = "equal_weight_finance",
    "worst_case" = "worst_case_finance",
    "best_case" = "best_case_finance",
    "main_activity" = "main_activity"
  )

  ggplot(data, aes(x = .data$risk_category_var, y = .data[[y_var]], fill = .data$risk_category_var)) +
    geom_bar(stat = "identity") +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    scale_fill_manual(values = score_colors) +
    theme_tiltplot()
}
