#' Plot xctr data on a company level
#'
#' @param data A data frame like [xctr_toy_data].
#' @param company_name A string. Name of one company in the data set.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' plot_xctr_company_level(xctr_toy_data, "company_a")
plot_xctr_company_level <- function(data, company_name) {
  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    na.omit() |>
    filter(company_name == .env$company_name)

  score_colors <- c("low" = "#007F00", "medium" = "#FFC300", "high" = "#FF5733")

  crucial_names <- c(
    names(select(data, matches("_share"))),
    names(select(data, matches("_risk_category")))
  )
  data |> check_crucial_names(crucial_names)

  share_var <- names(select(data, matches("_share")))
  risk_category_var <- names(select(data, matches("_risk_category")))

  data <- data |>
    mutate(risk_category_var = factor(
      data[[risk_category_var]],
      levels = c("low", "medium", "high")
    ))

  ggplot(data, aes(x = .data$risk_category_var, y = .data[[share_var]], fill = .data$risk_category_var)) +
    geom_bar(stat = "identity", position = "dodge", alpha = 0.8, width = 0.6) +
    facet_wrap(~ .data$risk_category_var, scales = "fixed") +
    labs(
      title = paste("Risk distribution of all products produced by", company_name),
      x = "Risk categories", y = paste("Risk categories of", share_var, "(%)"),
      fill = "Risk Categories"
    ) +
    scale_fill_manual(values = score_colors) +
    tiltplot_theme() +
    ylim(0, 1)
}
