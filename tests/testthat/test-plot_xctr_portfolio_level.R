test_that("returns an object of the expected class", {
  plot <- plot_xctr_portfolio_level(xctr_toy_data)
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values",{
  plot <- plot_xctr_portfolio_level(xctr_toy_data)
  risk_categories <- levels(plot$data$risk_category_var)
  expected_risk_categories <- c("low", "medium", "high")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct share values",{
  plot <- plot_xctr_portfolio_level(xctr_toy_data)
  shares <- unique(plot$data$avg_share_value)
  expected_shares <- xctr_toy_data |>
    group_by(benchmark, xctr_risk_category) |>
    summarise(avg_share_value = mean(xctr_share)) |>
    pull(avg_share_value)
  expect_true(all(shares %in% expected_shares))
})
