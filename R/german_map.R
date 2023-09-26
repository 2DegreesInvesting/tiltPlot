german_map <- function(data, benchmark = c("all", "unit", "tilt_sec", "unit_tilt_sec", "isic_sec", "unit_isic_sec"), finance_weight = c("equal_weight", "worst_case", "best_case")) {

  benchmark <- arg_match(benchmark)
  finance_weight <- arg_match(finance_weight)

  crucial <- c(
    "_risk_category",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))
  risk_var <- names_matching(data, "_risk_category")

  #Shapefile for European countries
  shp_0 <- get_eurostat_geospatial(resolution = 10,
                          nuts_level = 3,
                          year = 2016,
                          crs = 3035)

  #Filter for Germany
  shp_1 <- shp_0 |>
    filter(.data$CNTR_CODE == "DE") |>
    select(geo = .data$NUTS_ID, .data$geometry) |>
    arrange(.data$geo) |>
    st_as_sf()

  #Merge to have zip codes with NUTS file
  shp_1 <- shp_1 |>
    inner_join(nuts_de, by = "geo")

  #Merge shapefile with financial data
  financial_geo <- financial |>
    filter(benchmark == "isic_sec") |>
    left_join(shp_1, by = "postcode") |>
    st_as_sf()

  #Create map based on financial geo with two layers; financial data and map
  ggplot() +
    geom_sf(data = financial_geo, mapping = aes(fill = xctr_risk_category), show.legend = TRUE) +
    geom_sf(data = shp_1, fill = NA) +
    coord_sf()
}
