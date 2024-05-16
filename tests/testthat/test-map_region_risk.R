test_that("returns an object of the expected class", {
  try({
    plot <- map_region_risk(without_financial)
  })
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values colors", {
  data <- tibble(
    postcode = c(53773L, 53774L, 53775L),
    emission_profile = c("high", "medium", "low"),
    benchmark = rep("all", 3)
  )
  expected_colors <- list(
    high = high_hex(),
    medium = medium_hex(),
    low = low_hex()
  )
  try({
    plot <- map_region_risk(data)
    layers <- ggplot_build(plot)$data
    colors <- layers[[1]]$fill

    names(colors) <- names(expected_colors)
    expect_true(identical(expected_colors, colors))
  })
})
