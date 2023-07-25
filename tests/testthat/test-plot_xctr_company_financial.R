test_that("returns an object of the expected class", {
  plot <- plot_xctr_company_financial(financial, "peter")
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  plot <- plot_xctr_company_financial(financial, "peter")
  risk_categories <- plot$data$xctr_risk_category
  expected_risk_categories <- c("high", "low", "medium")
  expect_true(all(risk_categories %in% expected_risk_categories))
})

test_that("returns correct benchmark values", {
  plot <- plot_xctr_company_financial(financial, "peter")
  shares <- unique(plot$data$benchmark)
  expected_shares <- financial |>
    filter(company_name == "peter") |>
    pull(benchmark) |>
    unique()
  expect_true(all(shares %in% expected_shares))
})
