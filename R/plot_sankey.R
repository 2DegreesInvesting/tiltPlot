#' Create a sankey plot with financial data
#'
#' @param data A data frame like [financial].
#' @param with_company Logical. If TRUE, will plot a node with the company name.
#' If FALSE, will plot without the company name node.
#' @param mode String. Several modes can be chosen by the user :
#' * "equal_weight" means to divide the amount of the loan by the number of
#' products of the company.
#' * "worst_case" means to weigh the loan as such that we assume that all money
#' goes into the highest risk product. If there are two or more products associated
#' with the same highest risk, we assume equal weights again.
#' * "best_case" - similar to the worst-case scenario but just with the
#' lowest-risk category.
#'
#' @return A sankey plot of class [ggalluvial].
#' @export
#'
#' @examples
#' # Plot with equal weight and with company name
#' plot_sankey(financial)
#'
#' # Plot with best_case weight
#' plot_sankey(financial, mode = "best_case")
plot_sankey <- function(data, with_company = TRUE, mode = c("equal_weight", "worst_case", "best_case")) {
  mode <- arg_match(mode)

  crucial <- c(
    "_risk_category",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))
  risk_var <- names_matching(data, "_risk_category")

  limits <- c("Bank", if (with_company) "Company", NULL, "Tilt Sector", risk_var)

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
    theme_minimal() +
    labs(fill = "Risk Categories") +
    ggtitle(
      "Sankey Plot",
      paste("Stratified by the amount of loan by the bank and", mode, "mode")
    )

  if (with_company) {
    p <- p + aes(axis2 = .data$company_name)
  }

  return(p)
}
