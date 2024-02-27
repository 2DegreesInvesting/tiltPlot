test_that("returns an object of the expected class", {
  data <- tibble(
    postcode = c(53773L, 53774L, 53775L),
    emission_profile = c("high", "medium", "low"),
    benchmark = rep("all", 3)
  )
  prepared_data <- prepare_geo_data(data)
  expect_type(prepared_data, "list")
})
