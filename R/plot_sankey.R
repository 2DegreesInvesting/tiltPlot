#' Create a sankey plot
#'
#' @param data A data frame like [toy_data].
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
#' * "main-activity" - sometimes banks give one sector classification to one
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
#' plot_sankey(toy_data)
#'
#' # Plot with best_case weight
#' plot_sankey(toy_data, mode = "best_case")
plot_sankey <- function(data, with_company = TRUE, mode = "equal_weight") {
  if (with_company) {
    p <- ggplot2::ggplot(
      data = data,
      aes(axis1 = .data$kg_id, axis2 = .data$company_name, axis3 = .data$tilt_sector, axis4 = .data$pctr_risk_category)
    ) +
      scale_x_discrete(limits = c("Bank", "Company", "Tilt Sector", "PCTR risk category"), expand = c(.2, .05)) +
      geom_alluvium(aes(fill = case_when(
        mode == "equal_weight" ~ .data$equal_weight_finance,
        mode == "worst_case" ~ .data$worst_case_finance,
        mode == "best_case" ~ .data$best_case_finance,
        mode == "main_activity" ~ .data$main_activity
      ))) +
      geom_stratum() +
      geom_text(stat = StatStratum, aes(label = after_stat(.data$stratum))) +
      theme_minimal() +
      labs(fill = "amount") +
      ggtitle(
        "Sankey Plot",
        paste("Stratified by the amount of loan by the bank and", mode, "mode")
      )
  } else {
    p <- ggplot2::ggplot(
      data = data,
      aes(axis1 = .data$kg_id, axis2 = .data$tilt_sector, axis3 = .data$pctr_risk_category)
    ) +
      scale_x_discrete(limits = c("Bank", "Tilt Sector", "PCTR risk category"), expand = c(.2, .05)) +
      geom_alluvium(aes(fill = case_when(
        mode == "equal_weight" ~ .data$equal_weight_finance,
        mode == "worst_case" ~ .data$worst_case_finance,
        mode == "best_case" ~ .data$best_case_finance,
        mode == "main_activity" ~ .data$main_activity
      ))) +
      geom_stratum() +
      geom_text(stat = StatStratum, aes(label = after_stat(.data$stratum))) +
      theme_minimal() +
      labs(fill = "amount") +
      ggtitle(
        "Sankey Plot",
        paste("Stratified by the amount of loan by the bank and", mode, "mode")
      )
  }

  return(p)
}
