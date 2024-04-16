#' Create a scatter plot with financial data
#'
#' Generate a scatter plot comparing the emission profile and transition risks
#' for each bank in the portfolio.
#'
#' @inheritParams bar_plot_emission_profile_financial
#' @param scenario A character vector specifying the scenario to be plot. It can
#' either be "IPR" or "WEO".
#' @param year A numerical specifying the year of the scenario to be plot. It
#' can be either 2030 or 2050.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' scatter_plot_financial(financial,
#'   benchmarks = c("all", "tilt_sector"),
#'   mode = "equal_weight",
#'   scenario = "IPR",
#'   year = 2030
#' )
scatter_plot_financial <- function(data,
                                   benchmarks = benchmarks(),
                                   mode = c(
                                     "equal_weight",
                                     "worst_case",
                                     "best_case"
                                   ),
                                   scenario = c("IPR", "WEO"),
                                   year = c(2030, 2050)) {
  #FIXME: .env$ instead of _arg seems to cause a bug too ?
  benchmarks_arg <- arg_match(benchmarks, multiple = TRUE)
  scenario_arg <- arg_match(scenario)
  year_arg <- year
  mode <- mode |>
    arg_match() |>
    switch_mode()

  data |>
    check_scatter_plot_financial() |>
    prepare_scatter_plot_financial(benchmarks_arg, scenario_arg, year_arg) |>
    calculate_scatter_plot_financial(mode) |>
    plot_scatter_financial_implementation()

}

#' Check scatter plot with financial data
#'
#' @param data A data frame.
#'
#' @return A data frame
#' @noRd
check_scatter_plot_financial <- function(data) {
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

  data
}

#' Process data
#'
#' @param data A data frame.
#' @param benchmarks A character vector.
#' @param scenario A character vector.
#' @param year A numerical value.
#'
#' @return A data frame.
#' @noRd
prepare_scatter_plot_financial <- function(data, benchmarks_arg, scenario_arg, year_arg) {
  data <- data |>
    filter(
      .data$benchmark %in% benchmarks_arg,
      .data$scenario == scenario_arg,
      .data$year == year_arg
    )

  data
}

#' Calculate Rank
#'
#' @param data A data frame.
#' @param mode A character vector.
#' @param col A character vector.
#'
#' @return A vector.
#' @noRd
calculate_rank <- function(data, mode, col) {
  rank <- switch(mode,
    "equal_weight_finance" = {
      rank <- ave(data[[col]], data[["bank_id"]])
    },
    "worst_case_finance" = ,
    "best_case_finance" = {
      data <- data[data[[mode]] != 0, ]
      rank <- ave(data[[col]], data[["bank_id"]])
    }
  )
  list(rank,data)
}

calculate_scatter_plot_financial <- function(data, mode) {

  data <- calculate_rank(data, mode, "profile_ranking")[[2]]

  data$emission_profile_average <- calculate_rank(data, mode, "profile_ranking")[[1]]
  data$transition_risk_average <- calculate_rank(data, mode, "transition_risk_score")[[1]]

  data
}

plot_scatter_financial_implementation <- function(data) {

  emission_rank_legend <- label_emission_rank() |> format_label()
  transition_risk_legend <- label_transition_risk() |> format_label()

  emission_rank_plot <- ggplot(data, aes(x = .data$amount_total, color = .data$bank_id)) +
    geom_point(aes(y = .data$emission_profile_average)) +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    ylim(0, NA) +
    xlim(0, NA) +
    ylab(emission_rank_legend) +
    theme_tiltplot()

  transition_score_plot <- ggplot(data, aes(x = .data$amount_total, color = .data$bank_id)) +
    geom_point(aes(y = .data$transition_risk_average)) +
    facet_wrap(~ .data$benchmark, scales = "fixed") +
    ylim(0, NA) +
    xlim(0, NA) +
    ylab(transition_risk_legend) +
    theme_tiltplot()

  plot <- ggarrange(emission_rank_plot, transition_score_plot, ncol = 2, nrow = 1)
  plot

}


