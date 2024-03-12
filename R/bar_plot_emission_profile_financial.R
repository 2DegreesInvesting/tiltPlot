#' Create a horizontal stacked bar chart with financial data
#'
#' Generate a horizontal stacked bar chart showing the distribution of
#' the emission risk profiles risks for one or several benchmarks.
#'
#' @param data A data frame like [financial].
#' @param benchmarks A character vector specifying the benchmarks for which the
#' emission profiles will be plotted. The user can choose from one to several
#' benchmark(s) to be plotted.
#' @param mode The mode of financial data to plot.
#' It can be one of "equal_weight", "worst_case" or "best_case".
#' If nothing is chosen, "equal_weight" is the default case.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' benchmarks <- c("all", "unit", "isic_4digit")
#' bar_plot_emission_profile_financial(financial, benchmarks, "equal_weight")
bar_plot_emission_profile_financial <- function(data,
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
                                                )) {
  benchmarks_arg <- arg_match(benchmarks, multiple = TRUE)
  #TODO: replace by mode_arg
  mode <- arg_match(mode)

  crucial <- c(
    "amount_total",
    "bank_id",
    "company_name",
    "emission_profile",
    "benchmark",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))

  risk_var <- names_matching(data, "emission_profile")

  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

  mode_var <- switch_mode(mode)

  data <- data |>
    calc_benchmark_emission_profile_financial(
      risk_var,
      benchmarks_arg,
      mode_var
    )

  ggplot(data, aes(x = .data$percentage_total, y = .data$benchmark, fill = .data$risk_category_var)) +
    geom_col(position = position_stack(reverse = TRUE), width = width_bar()) +
    fill_score_colors() +
    theme_tiltplot() +
    xlim(0, 1)
}

#' Calculate emission profile proportions for specific benchmarks, with financial
#' data
#'
#' @param data A data frame.
#' @param risk_var A character vector.
#' @param benchmarks A character vector.
#' @param mode_var A character vector.
#'
#' @return A data frame.
#'
#' @noRd
calc_benchmark_emission_profile_financial <- function(data,
                                                      risk_var,
                                                      benchmarks,
                                                      mode_var) {
  total_amount_portfolio <- data |>
    filter(.data$benchmark %in% benchmarks) |>
    distinct(.data$bank_id, .data$company_name, .keep_all = TRUE) |>
    summarise(total_amount_portfolio = sum(.data$amount_total)) |>
    pull()

  data <- data |>
    filter(.data$benchmark %in% benchmarks) |>
    mutate(proportion = .data[[mode_var]] / total_amount_portfolio) |>
    group_by(.data$risk_category_var, .data$company_name, .data$benchmark) |>
    summarise(percentage = sum(.data$proportion), .groups = "keep") |>
    summarise(percentage_total = sum(.data$percentage))

  data
}
