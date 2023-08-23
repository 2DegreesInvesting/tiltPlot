#' Plot xctr data without financial data
#'
#' Generate bar plots showing the distribution of xctr_risk_category percentages for each benchmark.
#'
#' @param data A data frame like [without_financial]
#'
#' @return A [ggplot] object.
#'
#' @export
#'
#' @examples
#' plot_xctr(without_financial)
plot_xctr <- function(data) {
  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    na.omit()

  crucial <- c(
    benchmark(),
    risk_category()
  )
  data |> check_crucial_names(names_matching(data, crucial))

  risk_var <- names_matching(data, risk_category())

  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

  data <- data |>
    group_by(.data$risk_category_var, .data$benchmark) |>
    summarize(count = n()) |>
    group_by(.data$benchmark) |>
    mutate(proportion = .data$count / sum(.data$count))

  ggplot(data, aes(x = .data$risk_category_var, y = .data$proportion, fill = .data$risk_category_var)) +
    # TODO : Create a little wrapper function
    geom_col() +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    fill_score_colors() +
    theme_tiltplot() +
    ylim(0, 1)
}
