test_that("custom_gradient_color generates correct colors", {
  input_vectors <- list(
    high = c(1, 0, 0),
    medium = c(0, 1, 0),
    low = c(0, 0, 1)
  )

  results <- lapply(input_vectors, function(inputs) {
    custom_gradient_color(inputs[1], inputs[2], inputs[3])
  })

  expected_results <- list(
    high = hex_to_rgb(high_hex()),
    medium = hex_to_rgb(medium_hex()),
    low = hex_to_rgb(low_hex())
  )

  expect_true(identical(expected_results, results))
})
