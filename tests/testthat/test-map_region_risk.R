test_that("returns an object of the expected class", {
  skip_on_ci()
  data <- example_without_financial(postcode = 53773L,
                                    !!aka("emission_profile") := c("high", "medium", "low"))
  plot <- map_region_risk(data)
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values colors", {
  skip_on_ci()
  data <- example_without_financial(
    postcode = c(53773L, 53774L, 53775L),
    !!aka("emission_profile") := c("high", "medium", "low")
  )
  expected_colors <- list(
    high = rgb(1, 0, 0),
    medium = rgb(1, 0.5, 0),
    low = rgb(0, 1, 0)
  )
  plot <- map_region_risk(data)
  layers <- ggplot_build(plot)$data
  colors <- layers[[1]]$fill

  names(colors) <- names(expected_colors)
  expect_true(identical(expected_colors, colors))
})
