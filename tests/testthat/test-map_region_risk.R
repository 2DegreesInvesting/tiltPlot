test_that("returns correct risk category values colors", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("70178", "71088", "71364")
  )
  expected_colors <- list(
    low = low_hex(),
    medium = medium_hex(),
    high = high_hex()
  )
  plot <- map_region_risk(data, "DE", "all", scenarios()[1], years()[1],
                          "emission_category")
  layers <- ggplot_build(plot)$data
  colors <- layers[[1]]$fill

  names(colors) <- names(expected_colors)
  expect_true(identical(expected_colors, colors))
})

test_that("plots the correct companies", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("70178", "71088", "71364"),
    company_name = letters[1:3]
  )
  plot <- map_region_risk(data, "DE", "all", scenarios()[1], years()[1],
                          "emission_category")

  company_names <- unique(plot$plot_env$data$company_name)
  expected_company_names <- unique(data$company_name)

  expect_equal(sort(company_names), sort(expected_company_names))
})

test_that("plots the selected benchmark", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c("70178", "71088", "71364")
  )
  plot <- map_region_risk(data, "DE", "all", scenarios()[1], years()[1],
                          "emission_category")

  benchmark <- unique(plot$plot_env$grouping_emission)
  expected_benchmark <- unique(data$grouping_emission)

  expect_equal(sort(benchmark), sort(expected_benchmark))
})

test_that("plots the risk category `emission_category`", {
  skip_on_ci()
  data <- without_financial |>
    rename(product = ep_product) |>
    mutate(postcode = as.character(postcode))
  plot <- map_region_risk(data, "DE", "unit_tilt_sector", scenarios()[1],
                          years()[1], "emission_category")

  risk_category <- unique(plot$plot_env$risk_category)
  expected_risk_category <- "emission_category"

  expect_equal(risk_category, expected_risk_category)
})

test_that("plots the risk category `transition_risk_category`", {
  skip_on_ci()
  data <- without_financial |>
    rename(product = ep_product) |>
    mutate(postcode = as.character(postcode))
  plot <- map_region_risk(data, "DE", "unit_tilt_sector", scenarios()[1],
                          years()[1], "transition_risk_category")

  risk_category <- unique(plot$plot_env$risk_category)
  expected_risk_category <- "transition_risk_category"

  expect_equal(risk_category, expected_risk_category)
})
