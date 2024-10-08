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
                             country_code = c("DE", "AT", "FR", "NL", "ES"),
                             grouping_emission = grouping_emission(),
                             mode = modes(),
                             scenario = scenarios(),
                             year = years(),
                             risk_category = risk_category()) {
  grouping_emission <- arg_match(grouping_emission)
  risk_category <- arg_match(risk_category)
  country_code <- arg_match(country_code)
  scenario <- arg_match(scenario)
  year <- year

  crucial <- c(
    aka("risk_category"),
    aka("companies_id"),
    "postcode",
    "grouping_emission",
    "scenario",
    aka("year")
  )
  data |> check_crucial_names(names_matching(data, crucial))

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
    inner_join(nuts_all, by = "geo")

  # merge shapefile with financial data
  geo <- data |>
    filter(
      .data$grouping_emission == .env$grouping_emission,
      .data$scenario == .env$scenario,
      .data$year == .env$year
    ) |>
    left_join(shp_1, by = "postcode") |>
    st_as_sf()

  aggregated_data <- aggregate_geo(geo, mode, risk_category)

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
#'   emission_profile = factor(c("low", "medium", "high"),
#'     levels = c("low", "medium", "high")
#'   )
#' )
#'
#' aggregate_geo(geo, mode = "emissions_profile_worst_case", risk_category = "emission_category")
aggregate_geo <- function(geo, mode, risk_category) {
  aggregated_data <- geo |>
    group_by(.data$postcode, .data[[risk_category]]) |>
    summarise(total_mode = sum(.data[[mode]])) |>
    group_by(.data$postcode) |>
    mutate(proportion = .data$total_mode / sum(.data$total_mode)) |>
    ungroup()

  # Pivot
  aggregated_data <- aggregated_data |>
    pivot_wider(names_from = all_of(risk_category) , values_from = "proportion", values_fill = 0) |>
    filter(.data$total_mode != 0)

  # Calculate color row by row
  aggregated_data <- aggregated_data |>
    group_by(.data$postcode) |>
    summarise(
      total_mode = add(.data$total_mode),
      geometry = first(.data$geometry),
      low = add(.data$low),
      medium = add(.data$medium),
      high = add(.data$high)
    ) |>
    mutate(color = pmap(list(.data$high, .data$medium, .data$low), custom_gradient_color))
  aggregated_data
}
