test_that("returns an object of the expected class", {
  data <- example_financial(!!aka("europages_product") := "e")
  plot <- bar_plot_emission_profile_financial(data, grouping_emission(), risk_category = "emission_category")
  expect_s3_class(plot, "ggplot")
})

test_that("returns correct risk category values", {
  data <- example_financial(!!aka("europages_product") := "e")
  plot <- bar_plot_emission_profile_financial(data, grouping_emission(), risk_category = "emission_category")
  risk_categories <- plot |> plot_data("emission_category")
  expected_risk_categories <- c("medium")
  expect_equal(risk_categories, expected_risk_categories)
})

test_that("returns correct benchmarks values", {
  data <- example_financial(!!aka("europages_product") := "e")
  plot <- bar_plot_emission_profile_financial(data, grouping_emission(), risk_category = "emission_category")
  benchmarks <- unique(plot |> plot_data("grouping_emission"))
  expected_benchmarks <- financial |>
    pull(grouping_emission) |>
    unique()
  expect_true(all(benchmarks %in% expected_benchmarks))
})

test_that("calculated proportions are less or equal to 1 for every mode", {
  data <- example_financial(!!aka("europages_product") := "e")
  bar_plots <- function(mode) {
    bar_plot_emission_profile_financial(data, grouping_emission(), mode = mode, risk_category = "emission_category")
  }
  plots <- lapply(modes(), bar_plots)

  proportions <- lapply(seq_along(modes()), \(i) plots[[i]]$data$percentage_total)
  expect_true(all(proportions >= 0 & proportions <= 1))
})

test_that("risk categories are the correct ones displayed, on a company level", {
  data <- example_financial(bank_id = 1:2, !!aka("europages_product") := "e")

  comp_name <- data[1, "company_name"]
  expected_risk_cat <- data |>
    filter(company_name == comp_name$company_name) |>
    pull(aka("risk_category")) |>
    unique()

  plot <- data |>
    filter(company_name == comp_name$company_name) |>
    bar_plot_emission_profile_financial(benchmarks(), mode = "equal_weight", risk_category = "emission_category")
  risk_cat <- unique(plot$data$emission_category)

  expect_true(identical(sort(risk_cat), sort(expected_risk_cat)))
})
