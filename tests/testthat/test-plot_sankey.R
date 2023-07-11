test_that("returns an object of the expected class", {
  p <- plot_sankey(toy_data)
  expect_s3_class(p, "ggplot")
})

test_that("returns expected data name values", {
  p <- plot_sankey(toy_data)
  plot_names <- p$data |> colnames()
  expected_names <- toy_data |> colnames()
  expect_equal(plot_names, expected_names)
})

test_that("returns correct risk categories values", {
  p <- plot_sankey(toy_data)
  risk_names <- unique(p$data$pctr_risk_category)
  possible_names <- c("low", "medium", "high", "other")
  expect_true(all(risk_names %in% possible_names))
})
