#' Create a horizontal stacked bar chart with financial data
#'
#' Generate a horizontal stacked bar chart showing the distribution of
#' the emission risk profiles risks for one or several benchmarks.
#'
#' @param data A data frame like [financial].
#' @param grouping_emission A character vector specifying the benchmarks for which the
#' emission profiles will be plotted. The user can choose from one to several
#' benchmark(s) to be plotted.
#' @param mode The mode of financial data to plot.
#' It can be one of "equal_weight", "worst_case" or "best_case".
#' If nothing is chosen, "equal_weight" is the default case.
#' @param risk_category A character vector.
#'
#' @return A [ggplot] object.
#' @export
#'
#' @examples
#' grouping_emission <- c("all", "unit", "isic_4digit")
#' bar_plot_emission_profile_financial(financial, grouping_emission,
#'   "equal_weight",
#'   risk_category = "emission_category"
#' )
bar_plot_emission_profile_financial <- function(data,
                                                grouping_emission = grouping_emission(),
                                                mode = c(
                                                  "equal_weight",
                                                  "worst_case",
                                                  "best_case"
                                                ),
                                                risk_category = risk_category()) {
  grouping_emission <- arg_match(grouping_emission, multiple = TRUE)
  mode <- arg_match(mode)

  crucial <- c(
    "amount_total",
    "bank_id",
    "company_name",
    aka("risk_category"),
    "grouping_emission",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))

  mode_var <- switch_mode(mode)

  data <- data |>
    calc_benchmark_emission_profile_financial(
      risk_category,
      grouping_emission,
      mode_var
    )

  ggplot(data, aes(x = .data$percentage_total, y = .data$grouping_emission, fill = .data[[risk_category]])) +
    geom_col(position = position_stack(reverse = TRUE), width = width_bar()) +
    fill_score_colors() +
    theme_tiltplot() +
    xlim(0, 1)
}

#' Calculate emission profile proportions for specific benchmarks, with financial
#' data
#'
#' @param data A data frame.
#' @param risk_category A character vector.
#' @param benchmarks A character vector.
#' @param mode_var A character vector.
#'
#' @return A data frame.
#'
#' @noRd
calc_benchmark_emission_profile_financial <- function(data,
                                                      risk_category,
                                                      benchmarks,
                                                      mode_var) {
  total_amount_portfolio <- data |>
    filter(.data$grouping_emission %in% benchmarks) |>
    distinct(.data$bank_id, .data$company_name, .keep_all = TRUE) |>
    summarise(total_amount_portfolio = sum(.data$amount_total, na.rm = TRUE)) |>
    pull()

  data <- data |>
    filter(.data$grouping_emission %in% benchmarks) |>
    distinct(.data$bank_id, .data$company_name, .data$ep_product, .data$grouping_emission, .keep_all = TRUE) |>
    mutate(proportion = .data[[mode_var]] / total_amount_portfolio) |>
    group_by(.data[[risk_category]], .data$company_name, .data$grouping_emission) |>
    summarise(percentage = sum(.data$proportion, na.rm = TRUE), .groups = "keep") |>
    summarise(percentage_total = sum(.data$percentage, na.rm = TRUE))

  data
}
