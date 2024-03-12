#' Create a scatter plot with financial data
#'
#' Generate a scatter plot comparing the emission profile and transition risks
#' for each bank in the portfolio.
#'
#' @param data A data frame like [financial].
#' @param benchmarks A character vector specifying the benchmarks for which the
#' emission profiles will be plotted. The user can choose from one to several
#' benchmark(s) to be plotted.
#' @param mode A character vector specifying the mode of financial data to plot.
#' It can be one of "equal_weight", "worst_case" or "best_case". If nothing is
#' chosen, "equal_weight" is the default case.
#' @param scenario A character vector specifying the scenario to be plot. It can
#' either be "IPR" or "WEO".
#' @param year A numerical specifying the year of the scenario to be plot. It
#' can be either 2030 or 2050.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
scatter_plot_financial <- function(data,
                                   benchmarks = c(
                                     "all",
                                     "isic_4digit",
                                     "tilt_sector",
                                     "unit",
                                     "unit_isic_4digit",
                                     "unit_tilt_sector"
                                   ),
                                   mode = c(
                                     "equal_weight",
                                     "worst_case",
                                     "best_case"
                                   ),
                                   scenario = c("WEO","IPR"),
                                   year = c(2030, 2050)
                                   ) {

  benchmarks_arg <- arg_match(benchmarks, multiple = TRUE)
  mode_arg <- arg_match(mode)
  scenario_arg <- arg_match(scenario)
  year_arg <- arg_match(year)

  crucial <- c(
    "amount_total",
    "bank_id",
    "company_name",
    "emission_profile",
    "profile_ranking",
    "scenario",
    "year",
    "reduction_targets",
    "transition_risk_score",
    "benchmark_transition_risk_score",
    "benchmark",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))

  risk_var <- names_matching(data, "emission_profile")

  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

  mode_var <- switch_mode(mode_arg)

  data <- financial
  benchmarks_arg <- ("all")
  scenario_arg <- "IPR"
  year_arg <- 2030

  data_test <- data |>
    filter(.data$benchmark %in% benchmarks_arg) |>
    filter(.data$scenario == scenario_arg) |>
    filter(.data$year == year_arg) |>
    head(3)


  # Function to calculate the y value based on user choice
  calculate_y <- function(df, mode, col) {
    if (mode == "equal_weight_finance") {
      y <- mean(df[[col]])
    } else if (mode %in% c("worst_case_finance", "best_case_finance")) {
      df <- df[df[[mode]] != 0, ]
      y <- mean(df[[col]])
    }
    return(y)
  }

  calculate_mean_percentage <- function(df) {
    mean_percentage <- aggregate(reduction_targets ~ tilt_sector, df, function(x) {
      mean_value <- mean(x)
      return(paste0(mean_value * 100, "%"))
    })
    return(mean_percentage)
  }

  mean_percentage <- calculate_mean_percentage(data_test)

  mean_reduction_targets <- aggregate(reduction_targets ~ tilt_sector, data_test, mean)

  data_test <- merge(data_test, mean_reduction_targets, by = "tilt_sector", all.x = TRUE)

  data_test$tilt_sector <- as.factor(data_test$tilt_sector)

  tilt_sector_labels <- paste(data_test$tilt_sector, ": ", data_test$reduction_targets, "% SERT")

  data_test$tilt_sector.labs = tilt_sector_labels

  # User-selected finance type
  finance_type <- "worst_case_finance"

  # Calculate y value based on user choice
  y_value <- calculate_y(data_test, finance_type, "profile_ranking")
  y_value2 <- calculate_y(data_test, finance_type, "transition_risk_score")

  # Create scatter plot
  p <- ggplot(data_test, aes(x = amount_total, color = bank_id, shape = bank_id)) +
    geom_point(aes(y = y_value)) +
    geom_point(aes(y = y_value2)) +
    facet_wrap(~ tilt_sector, scales = "fixed", labeller = labeller(data_test$tilt_sector.labs)) +
    ylim(0, NA) +
    xlim(0, NA)
}
