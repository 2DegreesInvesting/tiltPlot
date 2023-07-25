# styler: off
xctr_toy_data <- tibble::tribble(
  ~company_name, ~xctr_risk_category, ~xctr_share, ~benchmark,
  "company_a",              "high",         0.5,     "unit",
  "company_a",               "low",         0.5,     "unit",
  "company_a",            "medium",         0.0,     "unit",
  "company_b",              "high",         0.0, "tilt_sec",
  "company_b",            "medium",         0.0, "tilt_sec",
  "company_b",               "low",           1, "tilt_sec",
)
# styler: on

usethis::use_data(xctr_toy_data, overwrite = TRUE)
