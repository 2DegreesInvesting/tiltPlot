test_that("returns an object of the expected class", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("risk_category") := risk_category_levels()
  )
  prepared_data <- prepare_geo_data(
    data, "DE", "all", "equal_weight", scenarios()[1],
    years()[1]
  )
  expect_type(prepared_data, "list")
})

test_that("aggregation returns correct risk category values colors", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("risk_category") := risk_category_levels()
  )
  expected_colors <- list(
    low = low_hex(),
    medium = medium_hex(),
    high = high_hex()
  )
  prepared_data <- prepare_geo_data(
    data, "DE", "all", "equal_weight", scenarios()[1],
    years()[1]
  )
  aggregated_data <- prepared_data[[2]]

  colors <- aggregated_data$color
  names(colors) <- names(expected_colors)

  expect_true(identical(expected_colors, colors))
})

test_that("returns the correct postcodes", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("risk_category") := risk_category_levels()
  )
  prepared_data <- prepare_geo_data(
    data, "DE", "all", "equal_weight", scenarios()[1],
    years()[1]
  )
  aggregated_data <- prepared_data[[2]]

  postcodes <- unique(aggregated_data$postcode)
  expected_postcodes <- unique(data$postcode)

  expect_equal(sort(postcodes), sort(expected_postcodes))
})
