#' Create a sankey plot object
#'
#' @param #TODO
#'
#' @return A [sankeyNetwork] object.
#'
#' @noRd
#'
#' @examples
#' # TODO
plot_sankey_impl <- function(links, nodes, color) {
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
