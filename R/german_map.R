create_german_map <- function(data, selected_benchmark, selected_finance_weight) {

  map_data_ger <- map_data('world')[map_data('world')$region == "Germany",]
  ## The map (maps + ggplot2 )
  ggplot() +
    geom_polygon(data = map_data_ger,
                 aes(x=long, y=lat, group = group),
                 color = 'red', fill = 'pink') +
    coord_map() +
    ggtitle("A map of Germany") +
    theme(panel.background =element_rect(fill = 'blue'))
}
