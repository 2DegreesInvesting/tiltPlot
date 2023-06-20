ICTR_data <- readr::read_csv(here("data/ictr_company_level_final_v4.csv"), show_col_types = FALSE)

# If we don't delete all NAs, we have a problem to do the plots
# Original code: PCTR_data <- PCTR_data |> na.omit()

delete_NAs <- function(data){
  data <- na.omit(data)
  return(data)
}

PCTR_data <- delete_NAs(PCTR_data)
ICTR_data <- delete_NAs(ICTR_data)


###########For a specific company#######################


# To display the graph for one specific company, we need to sample one company_name
# old code: PCTR_company_name <- sample(PCTR_data$companies_id, 1)

sample_company_name <- function(data){
  set.seed(3) # To reproduce the code, we set a seed
  company_name <- sample(data$company_name, 1)
  return(company_name)
}

PCTR_company_name <- sample_company_name(PCTR_data)
ICTR_company_name <- sample_company_name(ICTR_data)

# We now create a subset to only receive one company to plot the graph.
#Old code: PCTR_company_subset <- PCTR_data[PCTR_data$companies_id == PCTR_company_name, ]

create_subset <- function(data, company_name) {
  subset_data <- data[data$company_name == company_name, ]
  return(subset_data)
}

PCTR_company_subset <- create_subset(PCTR_data, PCTR_company_name)
ICTR_company_subset <- create_subset(ICTR_data, ICTR_company_name)

# Define the desired order of the score levels
#Old code: risk_category_order <- c("low", "medium", "high")

# Create a new variable that specifies the order of the levels
#old code: PCTR_company_subset$PCTR_risk_category <- factor(PCTR_company_subset$PCTR_risk_category, levels = risk_category_order)

#define_risk_category_order <- function(data, risk_category_var) {
  # Define the desired order of the score levels
  #risk_category_order <- c("low", "medium", "high")
  # Create a new variable that specifies the order of the levels
  #data[[risk_category_var]] <- factor(data[[risk_category_var]], levels = risk_category_order)
  #return(data)
#}

#define_risk_category_order_PCTR <- define_risk_category_order(PCTR_company_subset, "PCTR_risk_category")
#define_risk_category_order_ICTR <- define_risk_category_order(ICTR_company_subset, "ICTR_risk_category")

# Define the color palette for the score levels
# Old code: score_colors <- c("low" = "#007F00", "medium" = "#FFC300", "high" = "#FF5733")

score_colors <- c("low" = "#007F00", "medium" = "#FFC300", "high" = "#FF5733")



# Create the plot
#Old code: ggplot(PCTR_company_subset, aes(x = PCTR_risk_category, y = PCTR_share, fill = PCTR_risk_category)) +
  #geom_bar(stat = "identity", position = "dodge", alpha = 0.8, width = 0.6) +
  #facet_wrap(~benchmark, scales = "fixed") +
  #labs(title = paste("Risk distribution (PCTR) of all products produced by", PCTR_company_name),
       #x = "Risk categories", y = "Risk categories of products (%)",
       #fill = "Risk Categories") +
  #scale_fill_manual(values = score_colors) +
  #theme_classic() +
  #theme(plot.title = element_text(hjust = 0.5, size = 16),
        #axis.title = element_text(size = 12),
        #axis.text = element_text(size = 10),
        #legend.title = element_text(size = 12),
        #legend.text = element_text(size = 10),
        #legend.position = "bottom",
        #panel.grid.major.y = element_blank(),
        #panel.grid.minor.y = element_blank(),
        #panel.spacing.y = unit(0.5, "lines")) +
  #ylim(0,1)


create_plot_XCTR_company_level <- function(data, risk_category_var, share_var, company_name) {
  # Define the desired order of the score levels
  risk_category_order <- c("low", "medium", "high")

  # Create a new variable that specifies the order of the levels
  data[[risk_category_var]] <- factor(data[[risk_category_var]], levels = risk_category_order)

  # Define the plot
  plot <- ggplot(data, aes(x = !!sym(risk_category_var), y = !!sym(share_var), fill = !!sym(risk_category_var))) +
    geom_bar(stat = "identity", position = "dodge", alpha = 0.8, width = 0.6) +
    facet_wrap(~benchmark, scales = "fixed") +
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

plot_PCTR_company_level <- create_plot_XCTR_company_level(PCTR_company_subset, "PCTR_risk_category", "PCTR_share", PCTR_company_name)
plot_PCTR_company_level
plot_ICTR_company_level <- create_plot_XCTR_company_level(ICTR_company_subset, "ICTR_risk_category", "ICTR_share", ICTR_company_name)
plot_ICTR_company_level


