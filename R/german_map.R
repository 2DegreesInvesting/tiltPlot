create_german_map <- function(data, selected_benchmark, selected_finance_weight) {

  #Shapefile for European countries
  SHP_0 <- eurostat::get_eurostat_geospatial(resolution = 10,
                          nuts_level = 0,
                          year = 2016)

  EU28 <- eu_countries %>%
    select(geo = code, name)

  EU27 <- eu_countries %>%
    filter(code != 'UK') %>%
    select(geo = code, name)

  SHP_28 <- SHP_0 %>%
    select(geo = NUTS_ID, geometry) %>%
    inner_join(EU28, by = "geo") %>%
    arrange(geo) %>%
    st_as_sf()

  SHP_27 <- SHP_0 %>%
    select(geo = NUTS_ID, geometry) %>%
    inner_join(EU27, by = "geo") %>%
    arrange(geo) %>%
    st_as_sf()

  SHP_27 %>%
    ggplot() +
    geom_sf() +
    scale_x_continuous(limits = c(-10, 35)) +
    scale_y_continuous(limits = c(35, 65))


}
