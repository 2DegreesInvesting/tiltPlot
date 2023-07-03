test_that("returns an object of the expected class", {
  p <- plot_sankey(toy_data)
  expect_s3_class(p, "sankeyNetwork")
  expect_s3_class(p, "htmlwidget")
})

test_that("returns expected nodes name values", {
  p <- plot_sankey(toy_data)
  nodes_names <- unique(p$x$nodes$name)
  expected_names <- unique(c(
    as.character(toy_data$tilt_sec),
    as.character(toy_data$company_name),
    as.character(toy_data$bank),
    as.character(toy_data$pctr_risk_category)
  ))
  expect_equal(nodes_names, expected_names)
})

test_that("returns correct nodes group values", {
  p <- plot_sankey(toy_data)
  group_names <- unique(p$x$nodes$group)
  possible_names <- c("low", "medium", "high", "other")
  expect_true(all(group_names %in% possible_names))
})
