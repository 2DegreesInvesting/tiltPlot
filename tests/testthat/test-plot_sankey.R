test_that("returns an object of the expected class", {
  p <- plot_sankey_financial(financial)
  expect_s3_class(p, "ggplot")
})

test_that("returns expected data name values", {
  p <- plot_sankey_financial(financial)
  plot_names <- p$data |> colnames()
  expected_names <- financial |> colnames()
  expect_equal(plot_names, expected_names)
})

test_that("returns correct risk categories values", {
  p <- plot_sankey_financial(financial)
  risk_names <- unique(p$data$xctr_risk_category)
  possible_names <- c("low", "medium", "high", "other")
  expect_true(all(risk_names %in% possible_names))
})
