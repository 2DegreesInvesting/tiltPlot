test_that("hasn't changed", {
  expect_snapshot(as.data.frame(financial))
})
