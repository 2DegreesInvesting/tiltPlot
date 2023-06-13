#' TODO : Documentation

toy_data <- tibble::tribble(
  ~bank, ~amount, ~amount_of_disctinct_products, ~PCTR_risk_category, ~tilt_sec,
  "A", 1, 2, "low", "sector_a",
  "B", 2, 1, "medium", "sector_b",
)

usethis::use_data(toy_data, overwrite = TRUE)
