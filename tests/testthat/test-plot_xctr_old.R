test_that("returns an object of the expected class", {
  plot <- plot_xctr_old(without_financial)
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  plot <- plot_xctr_old(without_financial)
  risk_categories <- levels(plot$data$risk_category_var)
  expected_risk_categories <- c("low", "medium", "high")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct benchmarks values", {
  plot <- plot_xctr_old(without_financial)
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- without_financial |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})
