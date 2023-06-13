# styler: off
toy_data <- tibble::tribble(
  ~bank, ~amount, ~amount_of_disctinct_products, ~PCTR_risk_category,  ~tilt_sec,
    "A",       1,                             2,               "low", "sector_a",
    "B",       2,                             2,              "high", "sector_b",
)
# styler: on

usethis::use_data(toy_data, overwrite = TRUE)
