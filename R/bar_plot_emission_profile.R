#' Create a horizontal stacked bar chart without financial data
#'
#' Generate a horizontal stacked bar chart showing the distribution of
#' the emission risk profiles risks for one or several benchmarks.
#'
#' @param data A data frame like [without_financial].
#' @param grouping_emission A character vector specifying the benchmarks for which the
#' emission profiles will be plotted. The user can choose from one to several
#' benchmark(s) to be plotted.
#' @param mode A character vector: `r toString(modes())`.
#' @param scenario A character vector: `r toString(scenarios())`.
#' @param year A character vector: `r toString(years())`.
#' @param risk_category A character vector.
#'
#' @return A [ggplot] object.
#'
#' @export
#'
#' @examples
#' grouping_emission <- c("unit")
#' bar_plot_emission_profile(without_financial, grouping_emission, risk_category = "emission_category")
bar_plot_emission_profile <- function(data,
                                      grouping_emission = grouping_emission(),
                                      mode = modes(),
                                      scenario = scenarios(),
                                      year = years(),
                                      risk_category = risk_category()) {
  grouping_emission <- arg_match(grouping_emission, multiple = TRUE)
  mode <- mode |>
    arg_match() |>
    switch_mode_emission_profile()
  scenario <- arg_match(scenario)
  year <- year

  data |>
    check_bar_plot_emission_profile(mode) |>
    prepare_bar_plot_emission_profile(grouping_emission = grouping_emission, mode = mode,
                                      scenario = scenario, year = year, risk_category = risk_category) |>
    plot_bar_plot_emission_profile_impl(risk_category = risk_category)
}

#' Check bar plot plot without financial data
#'
#' @param data A data frame.
#'
#' @return A data frame
#' @noRd
check_bar_plot_emission_profile <- function(data, mode) {
  crucial <- c(
    "grouping_emission",
    mode,
    aka("risk_category")
  )
  data |> check_crucial_names(names_matching(data, crucial))
}

#' Prepare emission profile proportions for specific grouping_emission
#'
#' @param data A data frame.
#' @param grouping_emission A character vector.
#' @param mode A character vector.
#' @param risk_category A character vector.
#'
#' @return A data frame.
#'
#' @noRd
prepare_bar_plot_emission_profile <- function(data, grouping_emission, mode, scenario, year, risk_category) {
  data <- data |>
    filter((.data$grouping_emission %in% .env$grouping_emission &
      .data$scenario == .env$scenario &
      .data$year == .env$year)) |>
    group_by(.data[[risk_category]], .data$grouping_emission) |>
    summarise(total_mode = sum(.data[[mode]])) |>
    group_by(.data$grouping_emission) |>
    mutate(proportion = .data$total_mode / sum(.data$total_mode))

  data
}

#' Implementation of the emission profile bar plot
#'
#' @param data A data frame.
#' @param risk_category A character vector.
#'
#' @return A [ggplot] object.
#' @noRd
plot_bar_plot_emission_profile_impl <- function(data, risk_category) {
  ggplot(data, aes(x = .data$proportion, y = .data$grouping_emission, fill = .data[[risk_category]])) +
    geom_col(position = position_stack(reverse = TRUE), width = width_bar()) +
    fill_score_colors() +
    theme_tiltplot() +
    xlim(0, NA)
}
