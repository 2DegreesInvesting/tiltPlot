create_german_map <- function(data, selected_benchmark, selected_finance_weight) {

  #Shapefile for European countries
  SHP_0 <- get_eurostat_geospatial(resolution = 10,
                          nuts_level = 2,
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
