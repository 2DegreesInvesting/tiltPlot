#' Create a map with the risk color of each region (NUTS3 granularity), without
#' financial data.
#'
#' @param data A data frame like [without_financial]
#' @param country_code Country code (ISO 3166 alpha-2) for which the map will be
#' plotted.
#' @param benchmark The mode of benchmark to plot.
#' It can be one of "all", "unit" or "tilt_sector", "unit_tilt_sector",
#' "isic_4digit" or "unit_isic_4digit". If nothing is chosen, "all" is the
#' default mode.
#' @param mode The mode to plot. It can be one of "equal_weight", "worst_case"
#' or "best_case". If nothing is chosen, "equal_weight" is the default mode.
#' @param scenario A character vector: `r toString(scenarios())`.
#' @param year A character vector: `r toString(years())`.
#'
#' @return A ggplot2 object representing the country data plot.
#' @export
#'
#' @examples
#' # Plot a German with a "unit" benchmark and equal_weight finance
#' try({
#'   map_region_risk(without_financial, country_code = "DE", benchmark = "unit")
#' })
map_region_risk <- function(data,
                            # TODO: plot for other countries
                            country_code = c("DE"),
                            grouping_emission = grouping_emission(),
                            mode = modes(),
                            scenario = scenarios(),
                            year = years(),
                            risk_category = risk_category()) {
  prepared_data <- prepare_geo_data(
    data,
    country_code,
    grouping_emission,
    mode,
    scenario,
    year,
    risk_category
  )
  shp_1 <- prepared_data[[1]]
  aggregated_data <- prepared_data[[2]]

  # create map based on financial geo with two layers; financial data and map
  ggplot() +
    geom_sf(data = aggregated_data, mapping = aes(fill = .data$color)) +
    geom_sf(data = shp_1, fill = NA) +
    coord_sf() +
    theme_tiltplot()
}
