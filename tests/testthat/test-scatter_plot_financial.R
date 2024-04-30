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
    bank_id = c("a", "b"),
    profile_ranking = c(1, NA),
    equal_weight_finance = c(1, 1),
    best_case_finance = c(1, 1),
    worst_case_finance = c(1, 1)
  )
  results <- list(
    calculate_rank(data, "equal_weight_finance", aka("profile_ranking")),
    calculate_rank(data, "best_case_finance", aka("profile_ranking")),
    calculate_rank(data, "worst_case_finance", aka("profile_ranking"))
  )
  expect_true(all(unlist(lapply(results, function(x) all(x$rank == 1)))))
})

test_that("calculated ranks are between 0 and 1 for each scores", {
  test_rank <- function(data, mode, column) {
    result <- calculate_rank(data, mode, column)
    rank <- result[[1]]
    expect_true(all(rank >= 0 & rank <= 1))
  }

  lapply(modes(), function(mode) {
    test_rank(financial, mode, aka("profile_ranking"))
  })
  lapply(modes(), function(mode) {
    test_rank(financial, mode, aka("emission_profile"))
  })
})

test_that("amount_total is correct for each bank_id", {
  fin <- financial
  expected_amount_totals <- financial |>
    group_by(bank_id) |>
    summarise(expected_total = sum(amount_total))

  p_tr <- plot_scatter_financial_impl(financial, aka("transition_risk"))
  p_ep <- plot_scatter_financial_impl(financial, aka("emission_profile"))

  actual_amount_totals_tr <- p_tr$data |>
    group_by(bank_id) |>
    summarise(actual_total = sum(amount_total))

  actual_amount_totals_ep <- p_ep$data |>
    group_by(bank_id) |>
    summarise(actual_total = sum(amount_total))

  expect_identical(expected_amount_totals$expected_total, actual_amount_totals_tr$actual_total)
  expect_identical(expected_amount_totals$expected_total, actual_amount_totals_ep$actual_total)
})
