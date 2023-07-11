#' Plot the XCTR on a portfolio level
#'
#' @param data A data frame like [xctr_toy_data].
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' plot_xctr_portfolio_level(xctr_toy_data)
plot_xctr_portfolio_level <- function(data){

  data <- xctr_toy_data

  risk_category_order <- c("low", "medium", "high")

  risk_category_var <- names(select(data, matches("_risk_category")))
  share_var <- names(data)[grep("_share", names(data))]

  data <- data |>
    mutate(risk_category_var = factor(data[[risk_category_var]], levels = risk_category_order))

  score_colors <- c("low" = "#007F00", "medium" = "#FFC300", "high" = "#FF5733")

  xctr_portfolio_grouped <- data %>%
    group_by(benchmark, risk_category_var) %>%
    summarise(avg_share_value = mean(xctr_share))

  ggplot(xctr_portfolio_grouped, aes(x = risk_category_var, y = avg_share_value, fill = risk_category_var)) +
    geom_bar(stat = "identity", position = "dodge", alpha = 0.8, width = 0.6) +
    facet_wrap(~benchmark, scales = "fixed") +
    labs(title = paste("Risk distribution (", share_var, ") of all input products in the portfolio"),
         x = "Risk categories", y = "Risk categories of input products (%)",
         fill = "Risk Categories") +
    scale_fill_manual(values = score_colors) +
    theme_classic() +
    theme(plot.title = element_text(hjust = 0.5, size = 16),
          axis.title = element_text(size = 12),
          axis.text = element_text(size = 10),
          legend.title = element_text(size = 12),
          legend.text = element_text(size = 10),
          legend.position = "bottom",
          panel.grid.major.y = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.spacing.y = unit(0.5, "lines")) +
    ylim(0,1)
}
