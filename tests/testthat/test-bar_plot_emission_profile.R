test_that("returns an object of the expected class", {
  plot <- bar_plot_emission_profile(without_financial, benchmarks())
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  plot <- bar_plot_emission_profile(without_financial, benchmarks())
  risk_categories <- levels(plot$data$risk_category_var)
  expected_risk_categories <- c("low", "medium", "high")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct benchmarks values", {
  plot <- bar_plot_emission_profile(without_financial, benchmarks())
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- without_financial |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})
