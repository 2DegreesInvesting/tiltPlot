#' Create a sankey plot
#'
#' @param data A data frame like [toy_data].
#' @param with_company Logical. If TRUE, will plot a node with the company name.
#' If FALSE, will plot without the company name node.
#'
#' @return A sankey plot of class [sankeyNetwork].
#' @export
#' @importFrom rlang .data
#'
#' @examples
#' plot_sankey(toy_data)
plot_sankey <- function(data, with_company = TRUE) {
  data_links <- data |>
    mutate(
      source = .data$bank,
      target = .data$pctr_risk_category,
      value = .data$amount,
      middle_node1 = .data$company_name,
      middle_node2 = .data$tilt_sec
    )

  if(with_company){

    links <- data_links |>
      select(
        "bank",
        source = "bank",
        target = "middle_node1",
        value = "amount",
        group = "pctr_risk_category"
      )

    links <- data_links |>
      select(
        "bank",
        source = "middle_node1",
        target = "middle_node2",
        value = "amount",
        group = "pctr_risk_category"
      ) |>
      bind_rows(links)
  }else{

    links <- data_links |>
      select(
        "bank",
        source = "bank",
        target = "middle_node2",
        value = "amount",
        group = "pctr_risk_category"
      )
  }

  links <- data_links |>
    select(
      "bank",
      source = "middle_node2",
      target = "pctr_risk_category",
      value = "amount",
      group = "pctr_risk_category"
    ) |>
    bind_rows(links)

  nodes <- tibble(
    name = unique(c(as.character(links$source), as.character(links$target))),
    group = ifelse(.data$name %in% c("high", "medium", "low"), .data$name, "other")
  )

  # FIXME : this color scale breaks the code.
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
