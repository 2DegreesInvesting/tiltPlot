#' Title
#'
#' @param data
#' @param with_company
#' @param mode
#'
#' @return
#' @export
#'
#' @examples
plot_sankey_ggplot <- function(data, with_company = TRUE, mode = "equal_weight") {

  if(with_company){

    p <- ggplot2::ggplot(data = toy_data,
              aes(axis1 = kg_id, axis2 = company_name, axis3 = tilt_sector, axis4 = pctr_risk_category)) +
      scale_x_discrete(limits = c("Bank", "Company", "Tilt Sector", "PCTR risk category"), expand = c(.2, .05)) +
      geom_alluvium(aes(fill = case_when(
        mode == "equal_weight" ~ equal_weight_finance,
        mode == "worst_case" ~ worst_case_finance,
        mode == "best_case" ~ best_case_finance,
        mode == "main_activity" ~ main_activity
      ))) +
      geom_stratum() +
      geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
      theme_minimal() +
      labs(fill= "amount")+
      ggtitle("Sankey Plot",
               paste("Stratified by the amount of loan by the bank and", mode, "mode"))

  }else{

  }

p <- ggplot::ggplot(data = data,
         aes(axis1 = Class, axis2 = Sex, axis3 = Age,
             y = Freq)) +
    scale_x_discrete(limits = c("Class", "Sex", "Age"), expand = c(.2, .05)) +
    xlab("Demographic") +
    geom_alluvium(aes(fill = Survived)) +
    geom_stratum() +
    geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
    theme_minimal() +
    ggtitle("passengers on the maiden voyage of the Titanic",
            "stratified by demographics and survival")

}
