test_that("returns an object of the expected class", {
  data <- example_without_financial()
  plot <- bar_plot_emission_profile(data, benchmarks(), mode = "equal_weight")
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values for equal weight mode", {
  data <- example_without_financial(!!aka("risk_category") := risk_category_levels())
  data <- prepare_bar_plot_emission_profile(data, benchmarks(), "equal_weight")
  risk_categories <- levels(data$risk_category_var)
  expected_risk_categories <- risk_category_levels()
  expect_true(setequal(risk_categories, expected_risk_categories))
})

test_that("returns correct risk category values for best case mode", {
  data <- example_without_financial(!!aka("risk_category") := risk_category_levels())
  data <- prepare_bar_plot_emission_profile(data, benchmarks(), "best_case")
  risk_categories <- levels(data$risk_category_var)
  expected_risk_categories <- risk_category_levels()
  expect_true(setequal(risk_categories, expected_risk_categories))
})

test_that("returns correct risk category values for worst_case mode", {
  data <- example_without_financial(!!aka("risk_category") := risk_category_levels())
  data <- prepare_bar_plot_emission_profile(data, benchmarks(), "worst_case")
  risk_categories <- levels(data$risk_category_var)
  expected_risk_categories <- risk_category_levels()
  expect_true(setequal(risk_categories, expected_risk_categories))
})

test_that("returns correct benchmarks values for equal weight mode", {
  data <- example_without_financial()
  data <- prepare_bar_plot_emission_profile(data, benchmarks(), "equal_weight")
  benchmarks <- unique(data$benchmark)
  expected_benchmarks <- example_without_financial() |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("returns correct benchmarks values for best case mode", {
  data <- example_without_financial()
  data <- prepare_bar_plot_emission_profile(data, benchmarks(), "best_case")
  benchmarks <- unique(data$benchmark)
  expected_benchmarks <- example_without_financial() |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("returns correct benchmarks values for worst case mode", {
  data <- example_without_financial()
  data <- prepare_bar_plot_emission_profile(data, benchmarks(), "worst_case")
  benchmarks <- unique(data$benchmark)
  expected_benchmarks <- example_without_financial() |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("proportions are less or equal to 1 for equal weight mode", {
  data <- example_without_financial()
  data <- data |>
    prepare_bar_plot_emission_profile(benchmarks(), mode = "equal_weight")

  proportions <- data$proportion
  expect_true(all(proportions >= 0 & proportions <= 1))
})

test_that("proportions are less or equal to 1 for best case mode", {
  data <- example_without_financial()
  data <- data |>
    prepare_bar_plot_emission_profile(benchmarks(), mode = "best_case")

  proportions <- data$proportion
  expect_true(all(proportions >= 0 & proportions <= 1))
})

test_that("proportions are less or equal to 1 for worst case mode", {
  data <- example_without_financial()
  data <- data |>
    prepare_bar_plot_emission_profile(benchmarks(), mode = "worst_case")

  proportions <- data$proportion
  expect_true(all(proportions >= 0 & proportions <= 1))
})
