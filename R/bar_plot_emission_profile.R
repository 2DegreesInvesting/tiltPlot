#' Create a horizontal stacked bar chart without financial data
#'
#' Generate a horizontal stacked bar chart showing the distribution of
#' the emission risk profiles risks for one or several benchmarks.
#'
#' @param data A data frame like [without_financial].
#' @param benchmarks A character vector specifying the benchmarks for which the
#' emission profiles will be plotted. The user can choose from one to several
#' benchmark(s) to be plotted.
#' @param mode A character vector: `r toString(modes())`.
#' @param scenario A character vector: `r toString(scenarios())`.
#' @param year A character vector: `r toString(years())`.
#'
#' @return A [ggplot] object.
#'
#' @export
#'
#' @examples
#' benchmarks <- c("all", "unit", "isic_4digit")
#' bar_plot_emission_profile(without_financial, benchmarks)
bar_plot_emission_profile <- function(data,
                                      benchmarks = benchmarks(),
                                      mode = modes(),
                                      scenario = scenarios(),
                                      year = years()) {
  benchmarks <- arg_match(benchmarks, multiple = TRUE)
  mode <- mode |>
    arg_match() |>
    switch_mode_emission_profile()
  scenario <- arg_match(scenario)
  year <- year

  data |>
    check_bar_plot_emission_profile(mode) |>
    prepare_bar_plot_emission_profile(benchmarks, mode, scenario, year) |>
    plot_bar_plot_emission_profile_impl()
}

#' Check bar plot plot without financial data
#'
#' @param data A data frame.
#'
#' @return A data frame
#' @noRd
check_bar_plot_emission_profile <- function(data, mode) {
  crucial <- c(
    "benchmark",
    mode,
    aka("risk_category")
  )
  data |> check_crucial_names(names_matching(data, crucial))
}

#' Prepare emission profile proportions for specific benchmarks
#'
#' @param data A data frame.
#' @param benchmarks A character vector.
#' @param mode A character vector.
#'
#' @return A data frame.
#'
#' @noRd
prepare_bar_plot_emission_profile <- function(data, benchmarks, mode, scenario, year) {
  risk_var <- get_colname(data, aka("risk_category"))

  data <- data |>
    mutate(risk_category_var = as_risk_category(.data[[risk_var]]))

  data <- data |>
    filter((.data$benchmark %in% .env$benchmarks &
      .data$scenario == .env$scenario &
      .data$year == .env$year)) |>
    group_by(.data$risk_category_var, .data$benchmark) |>
    summarise(total_mode = sum(.data[[mode]])) |>
    group_by(.data$benchmark) |>
    mutate(proportion = total_mode / sum(total_mode))

  data
}

#' Implementation of the emission profile bar plot
#'
#' @param data A data frame.
#'
#' @return A [ggplot] object.
#' @noRd
plot_bar_plot_emission_profile_impl <- function(data) {
  ggplot(data, aes(x = .data$proportion, y = .data$benchmark, fill = .data$risk_category_var)) +
    geom_col(position = position_stack(reverse = TRUE), width = width_bar()) +
    fill_score_colors() +
    theme_tiltplot() +
    xlim(0, NA)
}
