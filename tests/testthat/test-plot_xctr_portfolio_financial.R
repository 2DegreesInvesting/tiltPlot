test_that("returns an object of the expected class", {
  plot <- plot_xctr_portfolio_financial(financial)
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  plot <- plot_xctr_portfolio_financial(financial)
  risk_categories <- plot$data$risk_category_var
  expected_risk_categories <- c("high", "low", "medium")
  expect_true(all(risk_categories %in% expected_risk_categories))
})

test_that("returns correct benchmark values", {
  plot <- plot_xctr_portfolio_financial(financial)
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- financial |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})
