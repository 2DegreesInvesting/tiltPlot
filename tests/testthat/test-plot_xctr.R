test_that("returns an object of the expected class", {
  plot <- plot_xctr(xctr_toy_data, "company_a")
  plot_portfolio <- plot_xctr(xctr_toy_data, portfolio_level = TRUE)
  expect_s3_class(plot, "ggplot")
  expect_s3_class(plot_portfolio, "ggplot")
})

test_that("returns correct risk category values on a company level", {
  plot <- plot_xctr(xctr_toy_data, "company_a")
  risk_categories <- plot$data$xctr_risk_category
  expected_risk_categories <- c("high", "low", "medium")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct share values on a company level", {
  plot <- plot_xctr(xctr_toy_data, "company_a")
  shares <- unique(plot$data$xctr_share)
  expected_shares <- xctr_toy_data |>
    filter(company_name == "company_a") |>
    pull(xctr_share) |>
    unique()
  expect_true(all(shares %in% expected_shares))
})

test_that("returns correct risk category values on portfolio level", {
  plot <- plot_xctr(xctr_toy_data, portfolio_level = TRUE)
  risk_categories <- levels(plot$data$risk_category_var)
  expected_risk_categories <- c("low", "medium", "high")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct share values on a portfolio level", {
  plot <- plot_xctr(xctr_toy_data, portfolio_level = TRUE)
  shares <- unique(plot$data$avg_share_value)
  expected_shares <- xctr_toy_data |>
    group_by(benchmark, xctr_risk_category) |>
    summarise(avg_share_value = mean(xctr_share), .groups = "drop") |>
    pull(avg_share_value)
  expect_true(all(shares %in% expected_shares))
})
