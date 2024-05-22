test_that("returns an object of the expected class", {
  data <- example_without_financial()
  plot <- bar_plot_emission_profile(data, benchmarks())
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  data <- example_without_financial(!!aka("risk_category") := risk_category_levels())
  plot <- bar_plot_emission_profile(data, benchmarks())
  risk_categories <- levels(plot$data$risk_category_var)
  expected_risk_categories <- risk_category_levels()
  expect_true(setequal(risk_categories, expected_risk_categories))
})

test_that("returns correct benchmarks values", {
  data <- example_without_financial()
  plot <- bar_plot_emission_profile(data, benchmarks())
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- data |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("calculated proportions are less or equal to 1", {
  data <- example_without_financial()
  plot <- bar_plot_emission_profile(data, benchmarks())
  proportions <- plot$data$proportion
  expect_true(proportions >= 0 & proportions <= 1)
})
