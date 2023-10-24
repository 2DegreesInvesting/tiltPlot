#' Create a German map with the risk color of each region
#'
#' @param data A data frame like [financial]
#' @param benchmark The mode of benchmark to plot.
#' It can be one of "all", "unit" or "tilt_sec", "unit_tilt_sec", "isic_sec"
#' or "unit_isic_sec". If nothing is chosen, "all" is the default mode.
#'
#' @param finance_weight The mode of financial data to plot (#TODO : fix financial columns).
#' It can be one of "equal_weight", "worst_case" or "best_case". If nothing is
#' chosen, "equal_weight" is the default mode.
#'
#' @return A ggplot2 object representing the german data plot.
#' @export
#'
#' @examples
#' # Plot a German map with a "unit" benchmark and equal_weight finance
#' german_map(financial, benchmark = "unit")
german_map <- function(data,
                       benchmark = c("all",
                                     "unit",
                                     "tilt_sec",
                                     "unit_tilt_sec",
                                     "isic_sec",
                                     "unit_isic_sec"),
                       finance_weight = c("equal_weight", "worst_case", "best_case")) {
  benchmark_arg <- arg_match(benchmark)
  # FIXME : Correct the columns of financial values
  finance_weight <- arg_match(finance_weight)

  crucial <- c(
    "_risk_category",
    "equal_weight_finance",
    "worst_case_finance",
    "best_case_finance"
  )
  data |> check_crucial_names(names_matching(data, crucial))
  risk_var <- names_matching(data, "_risk_category")

  # get shapefile of European countries
  shp_0 <- get_eurostat_geospatial(
    resolution = 10,
    nuts_level = 3,
    year = 2016,
    crs = 3035,
    make_valid = TRUE
  )

  # filter for Germany
  shp_1 <- shp_0 |>
    filter(.data$CNTR_CODE == "DE") |>
    select(geo = "NUTS_ID", "geometry") |>
    arrange(.data$geo) |>
    st_as_sf()

  # merge to have zip codes with NUTS file
  shp_1 <- shp_1 |>
    inner_join(nuts_de, by = "geo")

  # merge shapefile with financial data
  financial_geo <- data |>
    filter(benchmark == benchmark_arg) |>
    left_join(shp_1, by = "postcode") |>
    st_as_sf()

  aggregated_data <- financial_geo |>
    group_by(.data$postcode, .data$xctr_risk_category) |>
    summarize(count = n()) |>
    group_by(.data$postcode) |>
    mutate(proportion = .data$count / sum(.data$count)) |>
    ungroup()

  # apply custom_gradient_color to each row
  aggregated_data <- aggregated_data |>
    pivot_wider(names_from = "xctr_risk_category", values_from = "proportion", values_fill = 0) |>
    mutate(color = pmap(list(.data$high, .data$medium, .data$low), custom_gradient_color))

  # create map based on financial geo with two layers; financial data and map
  ggplot() +
    geom_sf(data = aggregated_data, mapping = aes(fill = .data$color)) +
    geom_sf(data = shp_1, fill = NA) +
    coord_sf()
}

custom_gradient_color <- function(high, medium, low) {
  # define RGB values for "high," "medium," and "low"
  high_color <- c(1, 0, 0) # Red
  medium_color <- c(1, 0.5, 0) # Orange
  low_color <- c(0, 1, 0) # Green

  # interpolate the colors based on proportions : 1 is highest intensity
  final_color <- high_color * high + medium_color * medium + low_color * low

  # TODO : find a way to translate that into a scale / Interactive map
  final_color <- do.call(rgb, as.list(final_color))

  return(final_color)
}
