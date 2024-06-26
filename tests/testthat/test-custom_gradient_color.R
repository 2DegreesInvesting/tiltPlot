test_that("custom_gradient_color generates correct colors", {
  input_vectors <- list(
    high = c(1, 0, 0),
    medium = c(0, 1, 0),
    low = c(0, 0, 1)
  )

  results <- lapply(
    input_vectors,
    \(inputs) custom_gradient_color(inputs[1], inputs[2], inputs[3])
  )

  expected_results <- list(
    high = high_hex(),
    medium = medium_hex(),
    low = low_hex()
  )
  expect_true(identical(expected_results, results))
})
