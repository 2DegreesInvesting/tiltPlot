#' Plot xctr bar plots
#'
#' @param data A data frame like [xctr_toy_data].
#' @param company_name A string. Name of one company in the data set, if the user
#' wants to have xctr plot on a company level.
#' @param portfolio_level A boolean. TRUE will plot on a portfolio level, FALSE
#' will plot on a company level, for which a company name must be provided.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' # Company level
#' plot_xctr(xctr_toy_data, "company_a")
#'
#' # Portfolio level
#' plot_xctr(xctr_toy_data, portfolio_level = TRUE)
plot_xctr <- function(data, company_name = NULL, portfolio_level = FALSE) {
  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    na.omit()

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

  score_colors <- c("low" = "#007F00", "medium" = "#FFC300", "high" = "#FF5733")

  if (portfolio_level) {
    data_grouped <- data |>
      group_by(.data$benchmark, risk_category_var) |>
      summarise(avg_share_value = mean(.data[[share_var]]))

    ggplot(data_grouped, aes(x = .data$risk_category_var, y = avg_share_value, fill = .data$risk_category_var)) +
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
  } else {
    if (is.null(company_name)) {
      stop("Company name must be provided for company-level plot.")
    }

    data <- data |>
      filter(company_name == .env$company_name)

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
}
