#' Create a sankey plot with financial data
#'
#' @inheritParams map_region_risk
#' @param with_company Logical. If TRUE, will plot a node with the company name.
#' If FALSE, will plot without the company name node.
#'
#' @return A sankey plot of class [ggalluvial].
#' @export
#'
#' @examples
#' # Plot with equal weight and with company name
#' plot_sankey(financial)
#'
#' # Plot with best_case weight and benchmark "all".
#' plot_sankey(financial, benchmark = "all", mode = "best_case")
plot_sankey <- function(data,
                        with_company = TRUE,
                        benchmark = benchmarks(),
                        mode = c("equal_weight", "worst_case", "best_case")) {
  mode <- arg_match(mode)
  benchmark <- arg_match(benchmark)

  crucial <- c(
    aka("risk_category"),
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))
  risk_var <- names_matching(data, aka("risk_category"))

  data <- data |>
    filter(.data$grouping_emission == .env$benchmark) |>
    distinct(.data$bank_id,
      .data$company_name,
      .data$ep_product,
      .keep_all = TRUE
    )

  limits <- c(
    label_bank() |> format_label(),
    if (with_company) label_company() |> format_label(),
    NULL,
    label_tilt_sector() |> format_label(),
    label_emission_profile() |> format_label()
  )

  p <- ggplot(
    data = data,
    aes(
      y = .data[[switch_mode(mode)]],
      axis1 = .data$bank_id,
      axis3 = .data$tilt_sector,
      axis4 = as_risk_category(.data[[risk_var]]),
      fill = as_risk_category(.data[[risk_var]])
    )
  ) +
    scale_x_discrete(
      limits = limits,
      expand = c(.2, .05)
    ) +
    geom_alluvium() +
    geom_stratum() +
    geom_text(stat = StatStratum, aes(label = after_stat(.data$stratum))) +
    fill_score_colors() +
    theme_tiltplot() +
    labs(fill = label_risk_categories() |> format_label())

  if (with_company) {
    p <- p + aes(axis2 = .data$company_name)
  }

  p
}
