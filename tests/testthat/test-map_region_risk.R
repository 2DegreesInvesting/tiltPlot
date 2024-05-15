test_that("returns an object of the expected class", {
  skip_on_ci()
  data <- example_without_financial(postcode = 53773L,
                                    !!aka("emission_profile") := c("high", "medium", "low"))
  plot <- map_region_risk(data)
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values colors", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("emission_profile") := c("high", "medium", "low")
  )
  expected_colors <- list(
    high = rgb(1, 0, 0),
    medium = rgb(1, 0.5, 0),
    low = rgb(0, 1, 0)
  )
  plot <- map_region_risk(data)
  layers <- ggplot_build(plot)$data
  colors <- layers[[1]]$fill

  names(colors) <- names(expected_colors)
  expect_true(identical(expected_colors, colors))
})

test_that("plots the correct postcodes", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("emission_profile") := c("high", "medium", "low"))
  plot <- map_region_risk(data)

  postcodes <- unique(plot$plot_env$aggregated_data$postcode)
  expected_postcodes <- unique(data$postcode)

  expect_equal(sort(postcodes), sort(expected_postcodes))
})

test_that("plots the correct companies", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    company_name = letters[1:3],
    !!aka("emission_profile") := c("high", "medium", "low"))
  plot <- map_region_risk(data)

  company_names <- unique(plot$plot_env$data$company_name)
  expected_company_names <- unique(data$company_name)

  expect_equal(sort(company_names), sort(expected_company_names))
})

test_that("plots the selected benchmark", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("emission_profile") := c("high", "medium", "low"))
  plot <- map_region_risk(data, "DE", "all")

  benchmark <- unique(plot$plot_env$benchmark)
  expected_benchmark <- unique(data$benchmark)

  expect_equal(sort(benchmark), sort(expected_benchmark))
})

test_that("plots the selected mode", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("emission_profile") := c("high", "medium", "low"))
  plot <- map_region_risk(data, "DE", "all", "equal_weight")

  mode <- unique(plot$plot_env$mode)
  plot$plot_env$
  expected_mode <- "equal_weight"

  expect_equal(mode, expected_mode)
})
