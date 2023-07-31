#' Plot xctr data on a portfolio level
#'
#' @param data A data frame like [xctr_toy_data].
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' plot_xctr_portfolio(xctr_toy_data)
plot_xctr_portfolio <- function(data) {
  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    na.omit()

  crucial <- c(
    "_share",
    "_risk_category"
  )
  data |> check_crucial_names(c(names(select(data, matches(crucial)))))

  risk_category_var <- names(select(data, matches("_risk_category")))
  share_var <- names(data)[grep("_share", names(data))]

  data <- data |>
    mutate(risk_category_var = factor(data[[risk_category_var]], levels = c("low", "medium", "high")))

  xctr_portfolio_grouped <- data |>
    group_by(.data$benchmark, risk_category_var) |>
    summarise(avg_share_value = mean(.data[[share_var]]))

  ggplot(xctr_portfolio_grouped, aes(x = .data$risk_category_var, y = .data$avg_share_value, fill = .data$risk_category_var)) +
    geom_bar(stat = "identity") +
    facet_wrap(~.data$benchmark, scales = "fixed") +
    fill_score_colors() +
    theme_tiltplot() +
    ylim(0, 1)
}
