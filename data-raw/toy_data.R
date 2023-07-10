# styler: off
#FIXME : styling is off
toy_data <- tibble::tribble(
  ~bank, ~amount, ~company_name, ~amount_of_distinct_products, ~pctr_risk_category,  ~tilt_sec,
  "A",       5,       "Peter",                            2,               "low", "sector_a",
  "A",       5,       "Peter",                            2,              "high", "sector_b",
  "B",      10,       "Mario",                            1,            "medium", "sector_c",
  "C",       8,       "Mario",                            1,               "low", "sector_c"
)
# styler: on

usethis::use_data(toy_data, overwrite = TRUE)
