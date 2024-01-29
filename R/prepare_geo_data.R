#' Prepare Geo Data for a Specific Country
#'
#' @inheritParams map_region_risk_financial
#'
#' @return A list containing the following components:
#'   - \code{shp_1}: Spatial data for the specified country.
#'   - \code{aggregated_data}: Aggregated financial data.
#' @noRd
#'
#' @examples
#' prepare_geo_data(financial_data)
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
                             finance_weight = c("equal_weight", "worst_case", "best_case")) {
  benchmark_arg <- arg_match(benchmark)
  finance_weight <- arg_match(finance_weight)

  crucial <- c(
    "_risk_category",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))
  risk_var <- names_matching(data, "_risk_category")

  # get shapefile of European countries
  shp_0 <- get_eurostat_geospatial(
    resolution = 10,
    nuts_level = 3,
    year = 2016,
    crs = 3035,
    make_valid = TRUE
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
  financial_geo <- data |>
    filter(benchmark == benchmark_arg) |>
    left_join(shp_1, by = "postcode") |>
    st_as_sf()

  # Add the code for data aggregation and color mapping
  aggregated_data <- financial_geo |>
    group_by(.data$postcode, .data$xctr_risk_category) |>
    summarize(count = n()) |>
    group_by(.data$postcode) |>
    mutate(proportion = .data$count / sum(.data$count)) |>
    ungroup()

  # apply custom_gradient_color to each row
  aggregated_data <- aggregated_data |>
    pivot_wider(names_from = "xctr_risk_category", values_from = "proportion", values_fill = 0) |>
    mutate(color = pmap(list(.data$high, .data$medium, .data$low), custom_gradient_color))

  return(list(shp_1, aggregated_data))
}
