#' Plot the XCTR on a portfolio level
#'
#' @param data A data frame like [xctr_toy_data].
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' plot_xctr_portfolio_level(xctr_toy_data)
plot_xctr_portfolio_level <- function(data) {
  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    na.omit() |>
    filter(company_name == .env$company_name)

  crucial_names <- c(
    names(select(data, matches("_share"))),
    names(select(data, matches("_risk_category")))
  )
  data |> check_crucial_names(crucial_names)

  risk_category_var <- names(select(data, matches("_risk_category")))
  share_var <- names(data)[grep("_share", names(data))]

  data <- data |>
    mutate(risk_category_var = factor(data[[risk_category_var]], levels = c("low", "medium", "high")))

  xctr_portfolio_grouped <- data |>
    group_by(.data$benchmark, risk_category_var) |>
    summarise(avg_share_value = mean(.data[[share_var]]))

  score_colors <- c("low" = "#007F00", "medium" = "#FFC300", "high" = "#FF5733")

  ggplot(xctr_portfolio_grouped, aes(x = .data$risk_category_var, y = .data$avg_share_value, fill = .data$risk_category_var)) +
    geom_bar(stat = "identity", position = "dodge", alpha = 0.8, width = 0.6) +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    labs(
      title = paste("Risk distribution (", share_var, ") of all input products in the portfolio"),
      x = "Risk categories", y = "Risk categories of input products (%)",
      fill = "Risk Categories"
    ) +
    scale_fill_manual(values = score_colors) +
    tiltplot_theme() +
    ylim(0, 1)
}
