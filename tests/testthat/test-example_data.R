test_that("example_financial() has the expected structure", {
  expect_snapshot(str(example_financial()))
})

test_that("example_without_financial() has the expected structure", {
  expect_snapshot(str(example_without_financial()))
})
