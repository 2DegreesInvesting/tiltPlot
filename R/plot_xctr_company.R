#' Plot xctr data on a company level
#'
#' @param data A data frame like [xctr_toy_data].
#' @param company_name A string. Name of one company in the data set.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' plot_xctr_company(xctr_toy_data, "company_a")
plot_xctr_company <- function(data, company_name) {
  # TODO: do we want to drop NA's everywhere silently?
  data <- data |>
    na.omit() |>
    filter(company_name == .env$company_name)

  crucial <- c(
    "_share",
    "_risk_category"
  )
  data |> check_crucial_names(c(names(select(data, matches(crucial)))))

  share_var <- names(select(data, matches("_share")))
  risk_category_var <- names(select(data, matches("_risk_category")))

  data <- data |>
    mutate(risk_category_var = factor(
      data[[risk_category_var]],
      levels = c("low", "medium", "high")
    ))

  score_colors <- score_colors()

  ggplot(data, aes(x = .data$risk_category_var, y = .data[[share_var]], fill = .data$risk_category_var)) +
    geom_bar(stat = "identity") +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    scale_fill_manual(values = score_colors) +
    theme_tiltplot() +
    ylim(0, 1)
}
