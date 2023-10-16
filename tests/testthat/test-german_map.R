test_that("returns an object of the expected class", {
  plot <- german_map(financial)
  expect_s3_class(plot, "ggplot")
})

