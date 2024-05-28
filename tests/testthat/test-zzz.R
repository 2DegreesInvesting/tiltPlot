test_that(".onLoad runs without error", {
  expect_no_error({
    .onLoad("tiltPlot", "tiltPlot")
  })
})
