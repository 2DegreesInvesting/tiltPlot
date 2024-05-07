test_that("returns an object of the expected class", {
  col <- aka("europages_product")
  data <- example_financial(!!col := "e")
  plot <- bar_plot_emission_profile_financial(data, benchmarks())
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  col <- aka("europages_product")
  data <- example_financial(!!col := "e")
  plot <- bar_plot_emission_profile_financial(data, benchmarks())
  risk_categories <- levels(plot$data$risk_category_var)
  expected_risk_categories <- c("low", "medium", "high")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct benchmarks values", {
  col <- aka("europages_product")
  data <- example_financial(!!col := "e")
  plot <- bar_plot_emission_profile_financial(data, benchmarks())
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- financial |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("calculated proportions are less or equal to 1 for every mode", {
  col <- aka("europages_product")
  data <- example_financial(!!col := "e")
  bar_plots <- function(mode) {
    bar_plot_emission_profile_financial(data, benchmarks(), mode = mode)
  }
  plots <- lapply(modes(), bar_plots)

  lapply(seq_along(modes()), function(i) {
    proportions <- plots[[i]]$data$percentage_total
    expect_true(all(proportions >= 0 & proportions <= 1))
  })
})
