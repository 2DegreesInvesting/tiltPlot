#' Plot xctr data on a company or portfolio level, without financial data
#'
#' Generate bar plots showing the distribution of xctr_risk_category percentages for each benchmark.
#'
#' @param data A data frame like [without_financial]
#' @param company_name (Optional) A character string specifying the company name.
#'   If provided, the function will generate the plot for the specified company only.
#'   If NULL (default), the plot will be generated for the entire portfolio.
#'
#' @return A [ggplot] object.
#'
#' @export
#'
#' @examples
#' # Example 1: Generate the plot for the entire portfolio
#' plot_xctr(without_financial)
#'
#' # Example 2: Generate the plot for a specific company
#' plot_xctr(without_financial, company_name = "peter peasant")
plot_xctr <- function(data, company_name = NULL) {
  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    na.omit()

  crucial <- c(
    "benchmark",
    "_risk_category"
  )
  data |> check_crucial_names(c(names(select(data, matches(crucial)))))

  risk_category_var <- names(select(data, matches("_risk_category")))

  data <- data |>
    mutate(risk_category_var = factor(data[[risk_category_var]], levels = c("low", "medium", "high")))

  if (!is.null(company_name)) {
    data <- data |> filter(company_name == .env$company_name)
  }

  data <- data |>
    group_by(risk_category_var, .data$benchmark) |>
    summarize(count = n()) |>
    group_by(.data$benchmark) |>
    mutate(percentage = .data$count / sum(.data$count))

  ggplot(data, aes(x = .data$risk_category_var, y = .data$percentage, fill = .data$risk_category_var)) +
    geom_bar(stat = "identity") +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    fill_score_colors() +
    theme_tiltplot() +
    ylim(0, 1)
}
