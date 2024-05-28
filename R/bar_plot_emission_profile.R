#' Create a horizontal stacked bar chart without financial data
#'
#' Generate a horizontal stacked bar chart showing the distribution of
#' the emission risk profiles risks for one or several benchmarks.
#'
#' @param data A data frame like [without_financial].
#' @param benchmarks A character vector specifying the benchmarks for which the
#' emission profiles will be plotted. The user can choose from one to several
#' benchmark(s) to be plotted.
#'
#' @return A [ggplot] object.
#'
#' @export
#'
#' @examples
#' benchmarks <- c("all", "unit", "isic_4digit")
#' bar_plot_emission_profile(without_financial, benchmarks)
bar_plot_emission_profile <- function(data,
                                      benchmarks = benchmarks()) {
  benchmarks <- arg_match(benchmarks, multiple = TRUE)

  crucial <- c(
    "benchmark",
    aka("risk_category")
  )
  data |> check_crucial_names(names_matching(data, crucial))

  risk_var <- names_matching(data, aka("risk_category"))

  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

  data <- calc_benchmark_emission_profile(data, risk_var, benchmarks)

  ggplot(data, aes(x = .data$proportion, y = .data$benchmark, fill = .data$risk_category_var)) +
    geom_col(position = position_stack(reverse = TRUE), width = width_bar()) +
    fill_score_colors() +
    theme_tiltplot() +
    xlim(0, 1)
}

#' Calculate emission profile proportions for specific benchmarks
#'
#' @param data A data frame.
#' @param risk_var A character vector.
#' @param benchmarks A character vector.
#'
#' @return A data frame.
#'
#' @noRd
calc_benchmark_emission_profile <- function(data, risk_var, benchmarks) {
  data <- data |>
    filter(.data$benchmark %in% benchmarks) |>
    group_by(.data$risk_category_var, .data$benchmark) |>
    summarise(count = n()) |>
    group_by(.data$benchmark) |>
    mutate(proportion = .data$count / sum(.data$count))
  return(data)
}
