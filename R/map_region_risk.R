#' Create a map with the risk color of each region (NUTS3 granularity), without
#' financial data.
#'
#' @param data A data frame like [without_financial]
#' @param country_code Country code (ISO 3166 alpha-2) for which the map will be
#' plotted.
#' @param benchmark The mode of benchmark to plot.
#' It can be one of "all", "unit" or "tilt_sector", "unit_tilt_sector",
#' "isic_4digit" or "unit_isic_4digit". If nothing is chosen, "all" is the
#' default mode.
#' @param mode The mode to plot. It can be one of "equal_weight", "worst_case"
#' or "best_case". If nothing is chosen, "equal_weight" is the default mode.
#'
#' @return A ggplot2 object representing the country data plot.
#' @export
#'
#' @examples
#' # Plot a German with a "unit" benchmark and equal_weight finance
#' map_region_risk(without_financial, country_code = "DE", benchmark = "unit")
map_region_risk <- function(data,
                            # TODO: plot for other countries
                            country_code = c("DE"),
                            benchmark = c(
                              "all",
                              "isic_4digit",
                              "tilt_sector",
                              "unit",
                              "unit_isic_4digit",
                              "unit_tilt_sector"
                            ),
                            mode = c("equal_weight", "worst_case", "best_case")) {
  prepared_data <- prepare_geo_data(
    data,
    country_code,
    benchmark,
    mode
  )

  shp_1 <- prepared_data[[1]]

  aggregated_data <- aggregate_geo(prepared_data[[2]], mode)

  # create map based on financial geo with two layers; financial data and map
  ggplot() +
    geom_sf(data = aggregated_data, mapping = aes(fill = .data$color)) +
    geom_sf(data = shp_1, fill = NA) +
    coord_sf()
}

#' Aggregate Geo Data
#'
#' @param geo A data frame containing geographical data.
#' @param mode The mode to plot. It can be one of "equal_weight", "worst_case"
#' or "best_case". If nothing is chosen, "equal_weight" is the default mode.
#'
#' @return A data frame with aggregated data, with the colors proportional to
#' the risks.
#' @noRd
#'
#' @examples
#' library(tibble)
#'
#' # Create a sample geo_data tibble
#' geo <- tibble(
#'   postcode = c("1", "2", "3"),
#'   company_name = c("A", "B", "C"),
#'   risk_category_var = factor(c("low", "medium", "high"),
#'     levels = c("low", "medium", "high")
#'   )
#' )
#'
#' aggregate_geo(geo, mode = "worst_case")
aggregate_geo <- function(geo, mode) {
  if (mode %in% c("worst_case", "best_case")) {
    aggregated_data <- geo |>
      group_by(.data$postcode, .data$company_name) |>
      mutate(
        # Choose the worst or best risk category and set the others to 0.
        proportion = calculate_case_proportions(.data$risk_category_var, mode)
      ) |>
      group_by(.data$postcode, .data$risk_category_var) |>
      summarize(proportion = sum(.data$proportion)) |>
      ungroup()
  } else if (mode == "equal_weight") {
    aggregated_data <- geo |>
      group_by(.data$postcode, .data$risk_category_var) |>
      summarize(count = n()) |>
      # Do not group by company here since all of them have equal weights.
      group_by(.data$postcode) |>
      mutate(proportion = .data$count / sum(.data$count)) |>
      ungroup()
  }

  # apply custom_gradient_color to each row
  aggregated_data <- aggregated_data |>
    pivot_wider(names_from = "risk_category_var", values_from = "proportion", values_fill = 0) |>
    mutate(color = pmap(list(.data$high, .data$medium, .data$low), custom_gradient_color))
}

#' Calculate Proportions for Worst or Best Case Scenarios
#'
#' @param categories A factor vector of risk categories.
#' @param mode A character string specifying the mode.
#'
#' @return A numeric vector representing the calculated proportions for each
#' category.
#'
#' @examples
#' categories <- as_risk_category(c("low", "medium", "medium", "high"))
#' calculate_case_proportions(categories, mode = "worst_case")
#' @noRd
calculate_case_proportions <- function(categories, mode) {
  if (mode == "worst_case") {
    extreme_risk <- levels(categories)[max(as.integer(categories))]
  } else if (mode == "best_case") {
    extreme_risk <- levels(categories)[min(as.integer(categories))]
  }

  is_extreme <- categories == extreme_risk
  proportions <- ifelse(is_extreme, 1 / sum(is_extreme), 0)
  proportions
}
