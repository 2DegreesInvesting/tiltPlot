test_that("returns an object of the expected class", {
  data <- example_without_financial()
  plot <- bar_plot_emission_profile(data, benchmarks())
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  data <- example_without_financial(!!aka("risk_category") := risk_category_levels())
  plot <- bar_plot_emission_profile(data, benchmarks())
  risk_categories <- levels(plot$data$risk_category_var)
  expected_risk_categories <- risk_category_levels()
  expect_true(setequal(risk_categories, expected_risk_categories))
})

test_that("returns correct benchmarks values", {
  data <- example_without_financial()
  plot <- bar_plot_emission_profile(data, benchmarks())
  benchmarks <- unique(plot$data$benchmark)
  expected_benchmarks <- data |>
    pull(benchmark) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("calculated proportions are less or equal to 1", {
  data <- example_without_financial()
  bar_plots <- function(mode) {
    bar_plot_emission_profile(data, benchmarks())
  }
  plots <- lapply(modes(), bar_plots)

  lapply(seq_along(modes()), function(i) {
    proportions <- plots[[i]]$data$proportion
    expect_true(all(proportions >= 0 & proportions <= 1))
  })
})

test_that("risk categories are the correct ones displayed, on a company level", {
  data <- example_without_financial(company_name = letters[1:2])
  comp_name <- data[1, "company_name"]
  expected_risk_cat <- data |>
    filter(company_name == comp_name$company_name) |>
    pull(aka("risk_category")) |>
    unique() |>
    as_risk_category()

  plot <- data |>
    filter(company_name == comp_name$company_name) |>
    bar_plot_emission_profile(benchmarks())
  risk_cat <- unique(plot$data$risk_category_var)

  expect_true(identical(sort(risk_cat), sort(expected_risk_cat)))
})
