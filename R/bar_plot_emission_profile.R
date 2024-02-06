#' Create a horizontal stacked bar chart without financial data
#'
#' Generate a horizontal stacked bar chart showing the distribution of
#' the emission risk profiles risks for one or several benchmarks
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
#' benchmarks <- c("all", "unit", "isic_sec")
#' bar_plot_emission_profile(without_financial, benchmarks)
bar_plot_emission_profile <- function(data,
                          benchmarks = c(
                            "all",
                            "unit",
                            "tilt_sec",
                            "unit_tilt_sec",
                            "isic_sec",
                            "unit_isic_sec"
                          )) {
  benchmarks_arg <- arg_match(benchmarks, multiple = TRUE)
  data <- data |>
    na.omit()
  warning("Rows with missing values in the data were dropped.")

  crucial <- c(
    "benchmark",
    "_risk_category"
  )
  data |> check_crucial_names(names_matching(data, crucial))

  risk_var <- names_matching(data, "_risk_category")

  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]])) |>
    filter(.data$benchmark %in% benchmarks) |>
    group_by(.data$risk_category_var, .data$benchmark) |>
    summarize(count = n()) |>
    group_by(.data$benchmark) |>
    mutate(proportion = .data$count / sum(.data$count))

  ggplot(data, aes(x = .data$proportion, y = .data$benchmark, fill = .data$risk_category_var)) +
    geom_col(position = position_stack(reverse = TRUE), width = width_bar()) +
    fill_score_colors() +
    theme_tiltplot() +
    xlim(0, 1)
}
