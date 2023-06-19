#' Create a sankey plot
#'
#' @param data A data frame like [toy_data].
#'
#' @return #FIXME
#' @export
#' @importFrom rlang .data
#'
#' @examples
#' plot_sankey(toy_data)
plot_sankey <- function(data) {
  data_links <- data |>
    mutate(
      source = .data$bank,
      target = .data$pctr_risk_category,
      value = .data$amount,
      middle_node2 = .data$tilt_sec
    )

  links <- data_links |>
    select(
      "bank",
      source = "bank",
      target = "middle_node2",
      value = "amount",
      group = "pctr_risk_category"
    )

  links <- data_links |>
    select(
      "bank",
      source = "middle_node2",
      target = "pctr_risk_category",
      value = "amount_of_disctinct_products",
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

  plot_sankey_impl(links, nodes, my_color)

  # FIXME: If I return invisible(data), then the plot does not show.
  # return(invisible(data))
}
