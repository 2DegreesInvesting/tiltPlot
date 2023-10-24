test_that("custom_gradient_color generates correct colors", {
  input_vectors <- list(c(1, 0, 0),c(0, 1, 0),c(0, 0, 1))

  results <- lapply(input_vectors, function(inputs) {
    custom_gradient_color(inputs[1], inputs[2], inputs[3])
  })

  expected_results <- list(rgb(1, 0, 0), rgb(1, 0.5, 0), rgb(0, 1, 0))

  expect_true(identical(expected_results, results))
})

