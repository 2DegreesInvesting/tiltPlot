test_that("returns an object of the expected class", {
  data <- example_financial(!!aka("europages_product") := "e")
  p <- plot_sankey(data)
  expect_s3_class(p, "ggplot")
})

test_that("returns expected data name values", {
  data <- example_financial(!!aka("europages_product") := "e")
  p <- plot_sankey(data)
  plot_names <- p$data |> colnames()
  expected_names <- data |> colnames()
  expect_equal(plot_names, expected_names)
})

test_that("returns correct risk categories values", {
  data <- example_financial(!!aka("europages_product") := "e")
  p <- plot_sankey(data, mode = "equal_weight")
  risk_names <- unique(p$data$emission_profile)
  possible_names <- c("low", "medium", "high", "other")
  expect_true(all(risk_names %in% possible_names))
})

test_that("y-axis amount is equal to loanbook amount for all the modes", {
  data <- example_financial(!!aka("europages_product") := "e")
  data <- data |>
    distinct(bank_id, company_name, ep_product, .keep_all = TRUE)

  test_mode <- function(mode) {
    p <- plot_sankey(data, mode = mode)
    expect_equal(sum(data[[switch_mode(mode)]]), sum(p$data[[switch_mode(mode)]]))
  }
  lapply(modes(), test_mode)
})

test_that("each bank_id has the correct amount for all the modes", {
  calculate_amount_bank_id <- function(data, mode) {
    data |>
      group_by(bank_id) |>
      mutate(sum = sum(data[[switch_mode(mode)]])) |>
      distinct(bank_id, sum)
  }
  data <- example_financial(bank_id = 1:2, !!aka("europages_product") := "e" )

  data <- data |>
    distinct(bank_id, company_name, ep_product, .keep_all = TRUE)
  amount_bank_id <- lapply(modes(), calculate_amount_bank_id, data = data)

  plots <- lapply(modes(), function(mode) plot_sankey(data, mode = mode))
  data_plots <- lapply(plots, `[[`, "data")
  amount_bank_id_plot <- lapply(seq_along(data_plots), function(i) {
    calculate_amount_bank_id(data_plots[[i]], mode = modes()[i])
  })

  all_results_equal <- lapply(seq_along(modes()), function(i) {
    all.equal(amount_bank_id_plot[[i]], amount_bank_id[[i]])
  })

  expect_true(all(unlist(lapply(all_results_equal, isTRUE))))
})

test_that("each risk category have the correct amount for all the modes", {
  data <- example_financial(!!aka("europages_product") := "e" )

  data <- data |>
    distinct(bank_id, company_name, ep_product, .keep_all = TRUE)

  calculate_amount_risk <- function(data, mode) {
    data |>
      group_by(aka("emission_profile")) |>
      mutate(sum = sum(data[[switch_mode(mode)]])) |>
      distinct(aka("emission_profile"), sum)
  }

  data <- data |>
    distinct(bank_id, company_name, ep_product, .keep_all = TRUE)
  amount_risk <- lapply(modes(), calculate_amount_risk, data = data)

  plots <- lapply(modes(), function(mode) plot_sankey(data, mode = mode))
  data_plots <- lapply(plots, `[[`, "data")
  amount_risk_plot <- lapply(seq_along(data_plots), function(i) {
    calculate_amount_risk(data_plots[[i]], mode = modes()[i])
  })

  all_results_equal <- lapply(seq_along(modes()), function(i) {
    all.equal(amount_risk[[i]], amount_risk_plot[[i]])
  })

  expect_true(all(unlist(lapply(all_results_equal, isTRUE))))
})

test_that("risk categories are in the right order", {
  data <- example_financial(
    !!aka("tilt_sector") := "f",
    !!aka("emission_profile") := c("low", "medium", "high"),
    !!aka("europages_product") := letters[1:3])
  p <- plot_sankey(data)
  risk_categories <- unique(p$data$emission_profile)
  expected_order <- c("low", "medium", "high")
  expect_identical(risk_categories, expected_order)
})
