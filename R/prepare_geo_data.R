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
                               "unit",
                               "tilt_sec",
                               "unit_tilt_sec",
                               "isic_sec",
                               "unit_isic_sec"
                             ),
                             mode = c("equal_weight", "worst_case", "best_case")) {
  benchmark_arg <- arg_match(benchmark)
  mode <- arg_match(mode)

  crucial <- c(
    "_risk_category",
    "company_name",
    "postcode",
    "benchmark"
  )
  data |> check_crucial_names(names_matching(data, crucial))
  risk_var <- names_matching(data, "_risk_category")
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

  aggregated_data <- aggregate_geo_data(geo, mode)

  return(list(shp_1, aggregated_data))
}
