test_that("returns an object of the expected class", {
  plot <- map_country(financial)
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values colors", {
  data <- tibble(
    postcode = c(53773L, 53774L, 53775L),
    xctr_risk_category = c("high", "medium", "low"),
    benchmark = rep("all", 3)
  )
  expected_colors <- list(rgb(1, 0, 0), rgb(1, 0.5, 0), rgb(0, 1, 0))

  plot <- map_country(data)

  layers <- ggplot_build(plot)$data
  colors <- layers[[1]]$fill

  expected <- lapply(expected_colors, function(x) sort(unlist(strsplit(x, ""))))
  actual <- lapply(colors, function(x) sort(unlist(strsplit(x, ""))))

  expect_true(identical(expected, actual))
})
