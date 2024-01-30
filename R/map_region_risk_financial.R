#' Create a map with the risk color of each region (NUTS3 granularity), with
#' financial data
#'
#' @param data A data frame like [financial]
#' @param country_code Country code (ISO 3166 alpha-2) for which the map will be
#' plotted.
#' @param benchmark The mode of benchmark to plot.
#' It can be one of "all", "unit" or "tilt_sec", "unit_tilt_sec", "isic_sec"
#' or "unit_isic_sec". If nothing is chosen, "all" is the default mode.
#'
#' @param finance_weight The mode of financial data to plot (#TODO : fix financial columns).
#' It can be one of "equal_weight", "worst_case" or "best_case". If nothing is
#' chosen, "equal_weight" is the default mode.
#'
#' @return A ggplot2 object representing the country data plot.
#' @export
#'
#' @examples
#' # Plot a German with a "unit" benchmark and equal_weight finance
#' map_region_risk_financial(financial, country_code = "DE", benchmark = "unit")
map_region_risk_financial <- function(data,
                            # TODO : Plot for other countries
                            country_code = c("DE"),
                            benchmark = c(
                              "all",
                              "unit",
                              "tilt_sec",
                              "unit_tilt_sec",
                              "isic_sec",
                              "unit_isic_sec"
                            ),
                            finance_weight = c("equal_weight", "worst_case", "best_case")) {
  prepared_data <- prepare_geo_data_financial(
    data,
    country_code,
    benchmark,
    finance_weight
  )
  shp_1 <- prepared_data[[1]]
  aggregated_data <- prepared_data[[2]]

  # create map based on financial geo with two layers; financial data and map
  ggplot() +
    geom_sf(data = aggregated_data, mapping = aes(fill = .data$color)) +
    geom_sf(data = shp_1, fill = NA) +
    coord_sf()
}
