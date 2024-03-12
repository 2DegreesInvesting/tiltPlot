test_that("returns an object of the expected class", {
  p <- scatter_plot_financial(financial)
  expect_s3_class(p, "ggplot")
})

test_that("returns correct risk categories values", {
  p <- scatter_plot_financial(financial)
  risk_names <- unique(p$data$emission_profile)
  possible_names <- c("low", "medium", "high", "other")
  expect_true(all(risk_names %in% possible_names))
})

test_that("returns correct benchmarks values", {
  plot <- scatter_plot_financial(financial)
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- financial |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})
