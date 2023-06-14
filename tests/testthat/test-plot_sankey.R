test_that("returns an object of the expected class", {
  p <- plot_sankey(toy_data)
  expect_s3_class(p, "sankeyNetwork")
  expect_s3_class(p, "htmlwidget")
})