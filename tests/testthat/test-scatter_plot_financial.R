test_that("returns an object of the expected class", {
  p <- scatter_plot_financial(financial, benchmarks())
  expect_s3_class(p, "ggplot")
})

test_that("returns correct risk categories values", {
  p <- scatter_plot_financial(financial, benchmarks())
  risk_names <- unique(p$data$emission_profile)
  possible_names <- c("low", "medium", "high", "other")
  expect_true(all(risk_names %in% possible_names))
})

test_that("returns correct benchmarks values", {
  plot <- scatter_plot_financial(financial, benchmarks())
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- financial |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("calculate_rank handles NAs for any mode", {
  data <- tibble(
    profile_ranking = c(1, NA),
    equal_weight_finance = c(1, 1),
    best_case_finance = c(1, 1),
    worst_case_finance = c(1, 1)
  )
  results <- c(
    calculate_rank(data, "equal_weight_finance", "profile_ranking"),
    calculate_rank(data, "best_case_finance", "profile_ranking"),
    calculate_rank(data, "worst_case_finance", "profile_ranking")
  )
  expect_true(all(results == 1))
})

test_that("prepare_scatter_plot_financial removes NAs", {
  test_fin <- financial
  test_fin[3, "reduction_targets"] <- NA
  result <- prepare_scatter_plot_financial(test_fin, "all", "IPR", 2030)

  expect_true(all(!is.na(result$percent)))
})
