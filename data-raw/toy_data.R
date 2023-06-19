# styler: off
toy_data <- tibble::tribble(
  ~bank, ~amount, ~amount_of_disctinct_products, ~pctr_risk_category,  ~tilt_sec,
    "A",       5,                             1,               "low", "sector_a",
    "A",       5,                             1,               "low", "sector_b",
    "B",       2,                             2,               "medium", "sector_a",
    "B",       10,                            2,               "high", "sector_b",
)
# styler: on

usethis::use_data(toy_data, overwrite = TRUE)
