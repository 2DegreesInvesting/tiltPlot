test_that("returns an object of the expected class", {
  data <- tibble(
    postcode = c(53773L, 53774L, 53775L),
    emission_profile = c("high", "medium", "low"),
    benchmark = rep("all", 3)
  )
  prepared_data <- prepare_geo_data(data)
  expect_type(prepared_data, "list")
})

test_that("aggregation returns correct risk category values colors", {
  data <- tibble(
    postcode = c(53773L, 53774L, 53775L),
    risk_category_var = c("high", "medium", "low"),
    benchmark = rep("all", 3)
  )
  expected_colors <- list(
    high = rgb(1, 0, 0),
    medium = rgb(1, 0.5, 0),
    low = rgb(0, 1, 0)
  )
  aggregated_data <- aggregate_geo(data, mode = "equal_weight")

  colors <- aggregated_data$color
  names(colors) <- names(expected_colors)

  expect_true(identical(expected_colors, colors))
})
