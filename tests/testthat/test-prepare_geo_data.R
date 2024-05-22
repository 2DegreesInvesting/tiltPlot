test_that("returns an object of the expected class", {
  skip_on_ci()
  data <- tibble(
    postcode = c(53773L, 53774L, 53775L),
    emission_profile = risk_category_levels(),
    benchmark = rep("all", 3)
  )
  prepared_data <- prepare_geo_data(data)
  expect_type(prepared_data, "list")
})

test_that("aggregation returns correct risk category values colors", {
  skip_on_ci()
  data <- tibble(
    postcode = c(53773L, 53774L, 53775L),
    risk_category_var = risk_category_levels(),
    benchmark = rep("all", 3)
  )
  expected_colors <- list(
    low = low_hex(),
    medium = medium_hex(),
    high = high_hex()
  )
  aggregated_data <- aggregate_geo(data, mode = "equal_weight")

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
  aggregated_data <- prepare_geo_data(data)[[2]]

  postcodes <- unique(aggregated_data$postcode)
  expected_postcodes <- unique(data$postcode)

  expect_equal(sort(postcodes), sort(expected_postcodes))
})
