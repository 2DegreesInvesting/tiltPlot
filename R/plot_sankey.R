#' Create a sankey plot
#'
#' @param data A data frame like [toy_data].
#'
#' @return
#' @export
#'
#' @examples
#' plot_sankey(toy_data)
plot_sankey <- function(data) {

  data_links <- toy_data |>
      mutate(
        source = "bank",
        target = "PCTR_risk_category",
        value = "amount",
        middle_node2 = "tilt_sec"
      )

  links <- data_links |>
      select(
        "bank",
        source = "bank",
        target = "middle_node2",
        value = "amount",
        group = "PCTR_risk_category"
      )

  links <- data_links |>
    select(
        "bank",
        source = "middle_node2",
        target = "PCTR_risk_category",
        value = "amount_of_disctinct_products",
        group = "PCTR_risk_category"
        ) |>
      bind_rows(links)

  nodes <- tibble(
    name = unique(c(as.character(links$source), as.character(links$target))),
    group = ifelse(name %in% c("high", "medium", "low"), name, "other")
    )

  #FIXME : this color scale breaks the code.
  my_color <- 'd3.scaleOrdinal() .domain(["high", "medium", "low", "other"]) .range(["#e10000", "#3d8c40", #808080", "#808080"])'

  links$IDsource <- match(links$source, nodes$name) - 1
  links$IDtarget <- match(links$target, nodes$name) - 1

  p <- networkD3::sankeyNetwork(
    Links = links,
    Nodes = nodes,
    Source = "IDsource",
    Target = "IDtarget",
    Value = "value",
    NodeID = "name",
    # colourScale = my_color,
    LinkGroup = "group",
    NodeGroup = "group",
    fontSize = 14
  )
  return(p)
}
