test_that("returns an object of the expected class", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("53773", "53774", "53775")
  )
  prepared_data <- prepare_geo_data(
    data, "DE", "all", scenarios()[1], years()[1], "emission_category"
  )
  expect_type(prepared_data, "list")
})

test_that("aggregation returns correct risk category values colors", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("70178", "71088", "71364")
  )
  expected_colors <- list(
    low = low_hex(),
    medium = medium_hex(),
    high = high_hex()
  )
  prepared_data <- prepare_geo_data(
    data, "DE", "all", scenarios()[1], years()[1], "emission_category"
  )
  aggregated_data <- prepared_data[[2]]

  colors <- aggregated_data$color
  names(colors) <- names(expected_colors)

  expect_true(identical(expected_colors, colors))
})

# test_that("returns the correct NUTS codes", {
#   skip_on_ci()
#   data <- example_without_financial(
#     postcode = c("70178", "71088", "71364")
#   )
#
#   shp_0 <- eurostat::get_eurostat_geospatial(
#     resolution = 10,
#     nuts_level = "all",
#     year = 2021,
#     crs = 3035
#   ) |>
#     filter(!(geo %in% c("FRY10", "FRY20", "FRY30", "FRY40", "FRY50"))) |>
#     select(geo = "NUTS_ID", "geometry") |>
#     st_as_sf() |>
#     inner_join(nuts_all, by = "geo")
#
#   prepared_data <- prepare_geo_data(
#     data, "DE", "all", scenarios()[1], years()[1], "emission_category"
#   )
#
#   NUTS_codes <- prepared_data[[1]] |>
#     filter(postcode %in% c("70178", "71088", "71364"))
#   aggregated_data <- prepared_data[[1]]
#
#   postcodes <- unique(aggregated_data$postcode)
#   expected_postcodes <- unique(data$postcode)
#
#   expect_equal(sort(postcodes), sort(expected_postcodes))
# })
