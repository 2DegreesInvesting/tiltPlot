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
#'   grouping_emission = c("all", "tilt_sector"),
#'   mode = "equal_weight",
#'   scenario = "IPR",
#'   year = 2030
#' )
scatter_plot_financial <- function(data,
                                   grouping_emission = grouping_emission(),
                                   mode = modes(),
                                   scenario = scenarios_financial(),
                                   year = years()) {
  # FIXME: .env$ instead of _arg seems to cause a bug only for grouping_emission
  grouping_emission <- arg_match(grouping_emission, multiple = TRUE)
  scenario <- arg_match(scenario)
  year <- year
  mode <- mode |>
    arg_match() |>
    switch_mode()

  data |>
    check_scatter_plot_financial() |>
    prepare_scatter_plot_financial(grouping_emission, scenario, year) |>
    calculate_scatter_plot_financial(mode) |>
    plot_scatter_financial()
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
    aka("risk_category"),
    "profile_ranking",
    "scenario",
    "year",
    "reduction_targets",
    "transition_risk_score",
    "benchmark_transition_risk_score",
    "grouping_emission",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))

  data
}

#' Prepare data
#'
#' @param data A data frame.
#' @param grouping_emission A character vector.
#' @param scenario A character vector.
#' @param year A numerical value.
#'
#' @return A data frame.
#' @noRd
prepare_scatter_plot_financial <- function(data, grouping_emission, scenario, year) {
  data <- data |>
    filter(
      .data$grouping_emission %in% .env$grouping_emission,
      .data$scenario == .env$scenario,
      .data$year == .env$year
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
      rank <- data |>
        group_by(.data$bank_id) |>
        mutate(avg = mean(!!sym(col), na.rm = TRUE)) |>
        pull(.data$avg)
    },
    "worst_case_finance" = ,
    "best_case_finance" = {
      data <- data[data[[mode]] != 0, ]
      rank <- data |>
        group_by(.data$bank_id) |>
        mutate(avg = mean(!!sym(col), na.rm = TRUE)) |>
        pull(.data$avg)
    }
  )
  list(rank, data)
}

#' Implement Rank
#'
#' @param data A data frame.
#' @param mode A string.
#'
#' @return A data frame.
#' @noRd
calculate_scatter_plot_financial <- function(data, mode) {
  data <- calculate_rank(data, mode, aka("profile_ranking"))[[2]]

  data$emission_category_average <- calculate_rank(data, mode, aka("profile_ranking"))[[1]]
  data$transition_risk_average <- calculate_rank(data, mode, aka("transition_risk_score"))[[1]]

  data
}

#' Plot the scatter financial plot
#'
#' @param data A data frame.
#'
#' @return A [ggplot] object.
#' @noRd
plot_scatter_financial <- function(data) {
  plot <- ggarrange(
    plot_scatter_financial_impl(data, type = aka("risk_category")),
    plot_scatter_financial_impl(data, type = aka("transition_risk"))
  )
  plot
}


#' Implementation of the scatter plot
#'
#' @param data A data frame.
#' @param type A string.
#'
#' @return A A [ggplot] object.
#' @noRd
plot_scatter_financial_impl <- function(data,
                                        type = c(
                                          aka("risk_category"),
                                          aka("transition_risk")
                                        )) {
  col <- paste0(type, "_average")
  plot_legend <- get(paste0(type, "_legend"))

  # TODO: What colors do we want for each bank_id ?
  scatter_plot <- ggplot(data, aes(x = .data$amount_total, color = .data$bank_id)) +
    geom_point(aes(y = .data[[col]])) +
    facet_grid(.data$tilt_sector ~ .data$grouping_emission, scales = "fixed") +
    ylim(0, 1) +
    xlim(0, NA) +
    ylab(plot_legend() |> format_label()) +
    theme_tiltplot()

  scatter_plot
}
