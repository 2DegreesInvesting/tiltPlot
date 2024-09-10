test_that("returns correct risk category values colors", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("53773", "53774", "53775")
  )
  expected_colors <- list(
    low = low_hex(),
    medium = medium_hex(),
    high = high_hex()
  )
  plot <- map_region_risk(data, "DE", "all", "emissions_profile_equal_weight",
                          scenarios()[1], years()[1], "emission_category")
  layers <- ggplot_build(plot)$data
  colors <- layers[[1]]$fill

  names(colors) <- names(expected_colors)
  expect_true(identical(expected_colors, colors))
})

test_that("plots the correct companies", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("53773", "53774", "53775"),
    company_name = letters[1:3]
  )
  plot <- map_region_risk(data, "DE", "all", "emissions_profile_equal_weight",
                          scenarios()[1], years()[1], "emission_category")

  company_names <- unique(plot$plot_env$data$company_name)
  expected_company_names <- unique(data$company_name)

  expect_equal(sort(company_names), sort(expected_company_names))
})

test_that("plots the selected benchmark", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("53773", "53774", "53775")
  )
  plot <- map_region_risk(data, "DE", "all", "emissions_profile_equal_weight",
                          scenarios()[1], years()[1], "emission_category")

  benchmark <- unique(plot$plot_env$grouping_emission)
  expected_benchmark <- unique(data$grouping_emission)

  expect_equal(sort(benchmark), sort(expected_benchmark))
})

test_that("plots the selected mode", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("53773", "53774", "53775")
  )
  plot <- map_region_risk(data, "DE", "all", "emissions_profile_equal_weight",
                          scenarios()[1], years()[1], "emission_category")

  mode <- unique(plot$plot_env$mode)
  expected_mode <- "emissions_profile_equal_weight"

  expect_equal(mode, expected_mode)
})
