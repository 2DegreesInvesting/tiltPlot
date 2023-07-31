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
#' * "main_activity" - sometimes banks give one sector classification to one
#' company. However, with our data we know that sometimes the products stem from
#' different sectors. Knowing that the bank categorizes the product in one
#' specific sector, we could assume that the bank only finance the product in
#' the sector that it categories the company in.
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
plot_sankey <- function(data, with_company = TRUE, mode = c("equal_weight", "worst_case", "best_case", "main_activity")) {
  mode <- arg_match(mode)

  crucial <- c(
    "main_activity",
    "_risk_category",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(c(names(select(data, matches(crucial)))))
  risk_category_var <- names(select(data, matches("_risk_category")))

  limits <- c("Bank", if (with_company) "Company", NULL, "Tilt Sector", risk_category_var)

  # TODO : color code per low, medium and high
  p <- ggplot(
    data = data,
    aes(
      axis1 = .data$kg_id,
      axis3 = .data$tilt_sector,
      axis4 = factor(.data[[risk_category_var]], levels = c("low", "medium", "high"))
    )
  ) +
    scale_x_discrete(
      limits = limits,
      expand = c(.2, .05)
    ) +
    geom_alluvium(aes(
      fill = case_when(
        mode == "equal_weight" ~ .data$equal_weight_finance,
        mode == "worst_case" ~ .data$worst_case_finance,
        mode == "best_case" ~ .data$best_case_finance,
        mode == "main_activity" ~ .data$main_activity
      )
    )) +
    geom_stratum() +
    geom_text(stat = StatStratum, aes(label = after_stat(.data$stratum))) +
    theme_minimal() +
    labs(fill = "amount") +
    ggtitle(
      "Sankey Plot",
      paste("Stratified by the amount of loan by the bank and", mode, "mode")
    )

  if (with_company) {
    p <- p + aes(axis2 = .data$company_name)
  }

  return(p)
}
