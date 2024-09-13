test_that("returns an object of the expected class", {
  data <- example_financial(
    !!aka("scenario") := "IPR",
    !!aka("year") := 1,
    !!aka("tilt_sector") := "t"
  )
  p <- scatter_plot_financial(data, grouping_emission(), scenario = "IPR", year = 1)
  expect_s3_class(p, "ggplot")
})

test_that("returns correct risk categories values", {
  data <- example_financial(
    !!aka("scenario") := "IPR",
    !!aka("year") := 1,
    !!aka("tilt_sector") := "t"
  )
  p <- scatter_plot_financial(data, grouping_emission(), scenario = "IPR", year = 1)
  risk_var <- data |> tiltIndicator:::extract_name(pattern(aka("risk_category")))
  risk_names <- unique(p |> plot_data(risk_var))
  possible_names <- c(risk_category_levels(), "other")
  expect_true(all(risk_names %in% possible_names))
})

test_that("returns correct benchmarks values", {
  data <- example_financial(
    !!aka("scenario") := "IPR",
    !!aka("year") := 1,
    !!aka("tilt_sector") := "t"
  )
  p <- scatter_plot_financial(data, grouping_emission(), scenario = "IPR", year = 1)
  benchmarks <- unique(p |> plot_data("grouping_emission"))
  expected_benchmarks <- data |>
    pull(grouping_emission) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("calculate_rank handles NAs for any mode", {
  data <- example_financial(
    !!aka("scenario") := "IPR",
    !!aka("year") := 1,
    !!aka("tilt_sector") := "t",
    !!aka("profile_ranking") := NA
  )

  results <- list(
    calculate_rank(data, "equal_weight_finance", aka("profile_ranking")),
    calculate_rank(data, "best_case_finance", aka("profile_ranking")),
    calculate_rank(data, "worst_case_finance", aka("profile_ranking"))
  )
  expect_true(all(unlist(lapply(results, \(x) all(x$rank == 1)))))
})

test_that("calculated ranks are between 0 and 1 for profile ranking", {
  test_rank <- function(data, mode, column) {
    result <- calculate_rank(data, mode, column)
    rank <- result[[1]]
    expect_true(all(rank >= 0 & rank <= 1))
  }

  data <- example_financial(
    !!aka("scenario") := "IPR",
    !!aka("year") := 1,
    !!aka("tilt_sector") := "t"
  )

  lapply(modes(), function(mode) {
    test_rank(data, mode, aka("profile_ranking"))
  })
})


test_that("calculated ranks are between 0 and 1 for emission profile", {
  test_rank <- function(data, mode, column) {
    result <- calculate_rank(data, mode, column)
    rank <- result[[1]]
    expect_true(all(rank >= 0 & rank <= 1))
  }

  data <- example_financial(
    !!aka("scenario") := "IPR",
    !!aka("year") := 1,
    !!aka("tilt_sector") := "t"
  )

  lapply(modes(), function(mode) {
    test_rank(data, mode, aka("risk_category"))
  })
})

test_that("amount_total is correct for each bank_id", {
  data <- example_financial(!!aka("scenario") := "IPR",
    !!aka("year") := 1,
    !!aka("tilt_sector") := "t",
    bank_id = 1:2
  )
  expected_amount_totals <- data |>
    group_by(bank_id) |>
    summarise(expected_total = sum(amount_total))

  p_tr <- plot_scatter_financial_impl(data, aka("transition_risk"))
  p_ep <- plot_scatter_financial_impl(data, aka("risk_category"))

  actual_amount_totals_tr <- p_tr$data |>
    group_by(bank_id) |>
    summarise(actual_total = sum(amount_total))

  actual_amount_totals_ep <- p_ep$data |>
    group_by(bank_id) |>
    summarise(actual_total = sum(amount_total))

  expect_identical(expected_amount_totals$expected_total, actual_amount_totals_tr$actual_total)
  expect_identical(expected_amount_totals$expected_total, actual_amount_totals_ep$actual_total)
})
