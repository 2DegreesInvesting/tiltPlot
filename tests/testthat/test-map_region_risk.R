test_that("returns correct risk category values colors", {
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
  plot <- map_region_risk(data, "DE", "all", "equal_weight", scenarios()[1], years()[1])
  layers <- ggplot_build(plot)$data
  colors <- layers[[1]]$fill

  names(colors) <- names(expected_colors)
  expect_true(identical(expected_colors, colors))
})

test_that("plots the correct companies", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    company_name = letters[1:3],
    !!aka("risk_category") := risk_category_levels()
  )
  plot <- map_region_risk(data, "DE", "all", "equal_weight", scenarios()[1], years()[1])

  company_names <- unique(plot$plot_env$data$company_name)
  expected_company_names <- unique(data$company_name)

  expect_equal(sort(company_names), sort(expected_company_names))
})

test_that("plots the selected benchmark", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("risk_category") := risk_category_levels()
  )
  plot <- map_region_risk(data, "DE", "all", "equal_weight", scenarios()[1], years()[1])

  benchmark <- unique(plot$plot_env$benchmark)
  expected_benchmark <- unique(data$benchmark)

  expect_equal(sort(benchmark), sort(expected_benchmark))
})

test_that("plots the selected mode", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("risk_category") := risk_category_levels()
  )
  plot <- map_region_risk(data, "DE", "all", "equal_weight", scenarios()[1], years()[1])

  mode <- unique(plot$plot_env$mode)
  expected_mode <- "equal_weight"

  expect_equal(mode, expected_mode)
})
