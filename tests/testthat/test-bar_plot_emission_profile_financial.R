test_that("returns an object of the expected class", {
  plot <- bar_plot_emission_profile_financial(financial)
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  plot <- bar_plot_emission_profile_financial(financial)
  risk_categories <- levels(plot$data$risk_category_var)
  expected_risk_categories <- c("low", "medium", "high")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct benchmarks values", {
  plot <- bar_plot_emission_profile_financial(financial)
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- financial |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("calculate_rank returns rank between 0 and 1", {
  # Create sample data
  set.seed(42)
  data <- data.frame(
    profile_ranking = runif(100),  # Assuming profile_ranking values are between 0 and 1
    transition_risk_score = runif(100)  # Assuming transition_risk_score values are between 0 and 1
  )

  # Call the function
  rank <- calculate_rank(data, mode = "equal_weight_finance", col = "profile_ranking")

  # Check if the rank is between 0 and 1
  expect_true(rank >= 0 & rank <= 1, "Rank should be between 0 and 1")
})
