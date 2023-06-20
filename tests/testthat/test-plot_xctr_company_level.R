test_that("returns an object of the expected class", {
  plot <- plot_xctr_company_level(xctr_toy_data, "company_a")
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values",{
  plot <- plot_xctr_company_level(xctr_toy_data, "company_a")
  risk_categories <- levels(plot$data$xctr_risk_category)
  expected_risk_categories <- c("low", "medium", "high")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct share values",{
  plot <- plot_xctr_company_level(xctr_toy_data, "company_a")
  shares <- unique(plot$data$xctr_share)
  expected_shares <- xctr_toy_data |>
    filter(company_name == "company_a") |>
    pull(xctr_share) |>
    unique()
  expect_true(all(shares %in% expected_shares))
})





