test_that("returns an object of the expected class", {
  p <- plot_sankey(toy_data)
  expect_s3_class(p, "sankeyNetwork")
  expect_s3_class(p, "htmlwidget")
})

# TODO: Test that `p` has the data we expect, e.g.
# p <- plot_sankey(toy_data)
# p$x$nodes$links
# p$x$nodes$name
# p$x$nodes$group
# ...
