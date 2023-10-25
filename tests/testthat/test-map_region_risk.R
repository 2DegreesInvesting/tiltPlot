test_that("returns an object of the expected class", {
  plot <- map_region_risk(financial)
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values colors", {
  data <- tibble(
    postcode = c(53773L, 53774L, 53775L),
    xctr_risk_category = c("high", "medium", "low"),
    benchmark = rep("all", 3)
  )
  expected_colors <- list(high = rgb(1, 0, 0),
                          medium = rgb(1, 0.5, 0),
                          low = rgb(0, 1, 0))

  plot <- map_region_risk(data)

  layers <- ggplot_build(plot)$data
  colors <- layers[[1]]$fill

  names(colors) <- names(expected_colors)

  expect_true(identical(expected_colors, colors))
})
