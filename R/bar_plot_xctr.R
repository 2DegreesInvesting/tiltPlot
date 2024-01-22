#' Create a horizontal stacked bar chart for xctr, without financial data
#'
#' Generate a horizontal stacked bar chart showing the distribution of xctr_risk_category
#' percentages for three benchmarks.
#'
#' @param data A data frame like [without_financial]
#'
#' @return A [ggplot] object.
#'
#' @export
#'
#' @examples
#' benchmarks <- c("all", "unit", "tilt_sec")
#' bar_plot_xctr(without_financial, benchmarks)
bar_plot_xctr <- function(without_financial,
                          benchmarks = c(
                            "all",
                            "unit",
                            "tilt_sec",
                            "unit_tilt_sec",
                            "isic_sec",
                            "unit_isic_sec"
                          )) {
  benchmarks_arg <- arg_match(benchmarks)
  # TODO: do we want to drop NA's everywhere silently?

  benchmark <- "unit"
  benchmarks <- c("all", "unit", "tilt_sec")
  data <- without_financial

  data <- data |>
    na.omit()

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
    geom_col(position = "stack") +
    #facet_wrap(~ .data$benchmark, scales = "fixed") +
    fill_score_colors() +
    theme_tiltplot() +
    ggplot2::xlim(0, 1)
    #ggtitle(paste("Stacked Horizontal Bar Plot for", benchmarks))

}
