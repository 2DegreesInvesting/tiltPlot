#' Prepare Geo Data for a Specific Country, without financial data
#'
#' @inheritParams map_region_risk
#'
#' @return A list containing the following components:
#'   - \code{shp_1}: Spatial data for the specified country.
#'   - \code{aggregated_data}: Aggregated data, without financial data.
#' @noRd
#'
#' @examples
#' prepare_geo_data(without_financial)
prepare_geo_data <- function(data,
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
  benchmark_arg <- arg_match(benchmark)
  mode <- arg_match(mode)

  crucial <- c(
    "emission_profile",
    "company_name",
    "postcode",
    "benchmark"
  )
  data |> check_crucial_names(names_matching(data, crucial))
  risk_var <- names_matching(data, "emission_profile")
  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

  # get shapefile of European countries
  shp_0 <- get_eurostat_geospatial(
    resolution = 10,
    nuts_level = 3,
    year = 2016,
    crs = 3035
  )

  # filter for the specified country
  shp_1 <- shp_0 |>
    filter(.data$CNTR_CODE == country_code) |>
    select(geo = "NUTS_ID", "geometry") |>
    arrange(.data$geo) |>
    st_as_sf()

  # merge to have zip codes with NUTS file
  shp_1 <- shp_1 |>
    inner_join(nuts_de, by = "geo")

  # merge shapefile with financial data
  geo <- data |>
    filter(benchmark == benchmark_arg) |>
    left_join(shp_1, by = "postcode") |>
    st_as_sf()

  aggregated_data <- aggregate_geo(geo, mode)

  list(shp_1, aggregated_data)
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
