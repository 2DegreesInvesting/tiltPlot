create_german_map <- function(data, selected_benchmark, selected_finance_weight) {

  #Shapefile for European countries
  SHP_0 <- get_eurostat_geospatial(resolution = 10,
                          nuts_level = 3,
                          year = 2016,
                          crs = 3035)

  EU28 <- eu_countries %>%
    select(geo = code, name)

  #Shapefile for Germany
  SHP_1 <- SHP_0 %>%
    filter(CNTR_CODE == "DE") %>%
    select(geo = NUTS_ID, geometry) %>%
    arrange(geo) %>%
    st_as_sf()

  SHP_1 %>%
    ggplot() +
    geom_sf()

  #NUTS3 to zip file
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
  SHP_test <- SHP_1 %>%
    inner_join(nuts_de, by = "geo")

  #Merge Shapefile with financial data
  financial_test <- financial[c(1, 7), ]

  financial_geo <- financial_test %>%
    left_join(SHP_test, by = "postcode") %>%
    st_as_sf()

  #Create map based on financial geo
  financial_geo %>%
    ggplot(aes(fill = xctr_risk_category)) +
    geom_sf()

  ggplot() +
    geom_sf(data = financial_geo, mapping = aes(fill = xctr_risk_category), show.legend = TRUE) +
    geom_sf(data = SHP_1, fill = NA) +
    coord_sf()

  #European map
  SHP_28 <- SHP_0 %>%
    select(geo = NUTS_ID, geometry) %>%
    inner_join(EU28, by = "geo") %>%
    arrange(geo) %>%
    st_as_sf()

  SHP_28 %>%
    ggplot() +
    geom_sf() +
    scale_x_continuous(limits = c(-10, 35)) +
    scale_y_continuous(limits = c(35, 65))

}
