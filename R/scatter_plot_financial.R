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
  year_arg <- year

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

  data <- data |>
    filter(.data$benchmark %in% benchmarks_arg) |>
    filter(.data$scenario == scenario_arg) |>
    filter(.data$year == year_arg)

  data <- data |>
    mutate(percent = mean(.data$reduction_targets), .by = .data$tilt_sector) |>
    mutate(
      percent = round(percent, 4),
      title = glue::glue("{unique(tilt_sector)}: {unique(percent*100)}% SERT"),
           .by = .data$tilt_sector)

  emission_rank <- calculate_rank(data, mode_var, "profile_ranking")
  tr_score <- calculate_rank(data, mode_var, "transition_risk_score")

  ggplot(data, aes(x = .data$amount_total, color = .data$bank_id)) +
    geom_point(aes(y = emission_rank, shape = "Emission Rank")) +
    geom_point(aes(y = tr_score, shape = "TR Score")) +
    scale_shape_manual(name = "Legend", values = c("Emission Rank" = 17, "TR Score" = 18)) +
    facet_grid(.data$benchmark ~ .data$title, scales = "fixed") +
    ylim(0, NA) +
    xlim(0, NA) +
    ylab("Rank") +
    theme_tiltplot()
}


#' Calculate Rank
#'
#' @param data A data frame.
#' @param mode A character vector.
#' @param col A character vector.
#'
#' @return A numerical value.
#' @noRd
calculate_rank <- function(data, mode, col) {
  if (mode == "equal_weight_finance") {
    rank <- mean(data[[col]])
  } else if (mode %in% c("worst_case_finance", "best_case_finance")) {
    df <- data[data[[mode]] != 0, ]
    rank <- mean(data[[col]])
  }
  rank
}
