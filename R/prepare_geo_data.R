#' Prepare Geo Data for a Specific Country, without financial data
#'
#' @inheritParams map_region_risk
#'
#' @return A list:
#'   - \code{shp_1}: Spatial data for the specified country.
#'   - \code{aggregated_data}: Aggregated data, without financial data.
#' @noRd
#'
prepare_geo_data <- function(data,
                             country_code = c("DE"),
                             benchmark = benchmarks(),
                             mode = modes(),
                             scenario = scenarios(),
                             year = years()) {
  benchmark <- arg_match(benchmark)
  mode <- mode |>
    arg_match() |>
    switch_mode_emission_profile()
  country_code <- arg_match(country_code)
  scenario <- arg_match(scenario)
  year <- year

  crucial <- c(
    aka("risk_category"),
    aka("companies_id"),
    "postcode",
    "benchmark",
    "scenario",
    aka("year")
  )
  data |> check_crucial_names(names_matching(data, crucial))
  risk_var <- get_colname(data, aka("risk_category"))
  data <- data |>
    mutate(risk_category_var = as_risk_category(data[[risk_var]]))

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
    filter(.data$benchmark == .env$benchmark &
             .data$scenario == .env$scenario &
             .data$year == .env$year) |>
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
  aggregated_data <- geo |>
    group_by(.data$postcode, .data$risk_category_var) |>
    summarise(total_mode = sum(.data[[mode]])) |>
    group_by(.data$postcode) |>
    mutate(proportion = total_mode / sum(total_mode)) |>
    ungroup()

  # apply custom_gradient_color to each row
  aggregated_data <- aggregated_data |>
    pivot_wider(names_from = "risk_category_var", values_from = "proportion", values_fill = 0) |>
    mutate(color = pmap(list(.data$high, .data$medium, .data$low), custom_gradient_color))
}
