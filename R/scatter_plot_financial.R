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
#' scatter_plot_financial(financial, "all", "equal_weight", "IPR", 2030)
scatter_plot_financial <- function(data,
                                   benchmarks = benchmarks(),
                                   mode = mode(),
                                   scenario = c("IPR", "WEO"),
                                   year = c(2030, 2050)) {
  benchmarks <- arg_match(benchmarks, multiple = TRUE)
  scenario <- arg_match(scenario)
  year <- year
  mode <- mode |>
    arg_match() |>
    switch_mode()

  data <- data |>
    check_scatter_plot_financial() |>
    prepare_scatter_plot_financial(benchmarks, scenario, year)

  emission_rank <- calculate_rank(data, mode, "profile_ranking")
  tr_score <- calculate_rank(data, mode, "transition_risk_score")

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
prepare_scatter_plot_financial <- function(data, benchmarks, scenario, year) {
  data <- data |>
    filter(
      .data$benchmark %in% benchmarks,
      .data$scenario == scenario,
      .data$year == year
    )

  data <- data |>
    group_by(.data$tilt_sector) |>
    mutate(percent = mean(.data$reduction_targets)) |>
    mutate(
      percent = round(.data$percent * 100, 4),
      title = glue::glue("{unique(.data$tilt_sector)}: {unique(.data$percent)}% SERT")
    ) |>
    ungroup()

  data
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
