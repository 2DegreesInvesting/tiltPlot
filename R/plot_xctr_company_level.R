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

  data <- data |>
    na.omit() |>
    filter(company_name == {{ company_name }})

  score_colors <- c("low" = "#007F00", "medium" = "#FFC300", "high" = "#FF5733")
  risk_category_order <- c("low", "medium", "high")

  share_var <- names(data)[grep("_share", names(data))]
  risk_category_var <- names(data)[grep("_risk_category", names(data))]

  # Create a new variable that specifies the order of the levels
  data[[risk_category_var]] <- factor(data[[risk_category_var]], levels = risk_category_order)

  # Define the plot
  plot <- ggplot(data, aes(x = !!sym(risk_category_var), y = !!sym(share_var), fill = !!sym(risk_category_var))) +
    geom_bar(stat = "identity", position = "dodge", alpha = 0.8, width = 0.6) +
    facet_wrap(~data[[risk_category_var]], scales = "fixed") +
    labs(title = paste("Risk distribution of all products produced by", company_name),
         x = "Risk categories", y = paste("Risk categories of", share_var, "(%)"),
         fill = "Risk Categories") +
    theme_classic() +
    scale_fill_manual(values = score_colors) +
    theme(plot.title = element_text(hjust = 0.5, size = 16),
          axis.title = element_text(size = 12),
          axis.text = element_text(size = 10),
          legend.title = element_text(size = 12),
          legend.text = element_text(size = 10),
          legend.position = "bottom",
          panel.grid.major.y = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.spacing.y = unit(0.5, "lines")) +
    ylim(0, 1)

  return(plot)
}

