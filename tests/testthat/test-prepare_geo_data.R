test_that("returns an object of the expected class", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("53773", "53774", "53775")
  )
  prepared_data <- prepare_geo_data(
    data, "DE", "all", "emissions_profile_equal_weight", scenarios()[1],
    years()[1], "emission_category"
  )
  expect_type(prepared_data, "list")
})

test_that("aggregation returns correct risk category values colors", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("53773", "53774", "53775")
  )
  expected_colors <- list(
    low = low_hex(),
    medium = medium_hex(),
    high = high_hex()
  )
  prepared_data <- prepare_geo_data(
    data, "DE", "all", "emissions_profile_equal_weight", scenarios()[1],
    years()[1], "emission_category"
  )
  aggregated_data <- prepared_data[[2]]

  colors <- aggregated_data$color
  names(colors) <- names(expected_colors)

  expect_true(identical(expected_colors, colors))
})

test_that("returns the correct postcodes", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("53773", "53774", "53775")
  )
  prepared_data <- prepare_geo_data(
    data, "DE", "all", "emissions_profile_equal_weight", scenarios()[1],
    years()[1], "emission_category"
  )
  aggregated_data <- prepared_data[[2]]

  postcodes <- unique(aggregated_data$postcode)
  expected_postcodes <- unique(data$postcode)

  expect_equal(sort(postcodes), sort(expected_postcodes))
})
