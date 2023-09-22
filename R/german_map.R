create_german_map <- function(data, selected_benchmark, selected_finance_weight) {

  #Shapefile for European countries
  SHP_0 <- get_eurostat_geospatial(resolution = 10,
                          nuts_level = 3,
                          year = 2016,
                          crs = 3035)

  #Shapefile for Germany
  SHP_1 <- SHP_0 %>%
    filter(CNTR_CODE == "DE") %>%
    select(geo = NUTS_ID, geometry) %>%
    arrange(geo) %>%
    st_as_sf()

  #NUTS3 to zip file
  #Source from European Commission: https://gisco-services.ec.europa.eu/tercet/flat-files
  nuts_de <- read_csv2(
    here("NUTS_DE.csv"),
    col_types = cols(
      NUTS3 = col_character(),  # Specify the data type for the "geo" column
      CODE = col_integer()  # Specify the data type for the "postcode" column
    ),
    quote = "'"
  )

  colnames(nuts_de) <- c("geo", "postcode")

  #Merge to have zip codes with NUTS file
  SHP_1 <- SHP_1 %>%
    inner_join(nuts_de, by = "geo")

  #Merge Shapefile with financial data
  financial_geo <- financial %>%
    filter(benchmark == "isic_sec") %>%
    left_join(SHP_1, by = "postcode") %>%
    st_as_sf()

  #Create map based on financial geo : two layers; financial data and map
  ggplot() +
    geom_sf(data = financial_geo, mapping = aes(fill = xctr_risk_category), show.legend = TRUE) +
    geom_sf(data = SHP_1, fill = NA) +
    coord_sf()
}
