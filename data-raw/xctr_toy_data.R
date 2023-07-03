# styler: off
xctr_toy_data <- tibble::tribble(
  ~company_name, ~xctr_risk_category, ~xctr_share,
  "company_a",              "high",         0.5,
  "company_a",               "low",         0.5,
  "company_a",            "medium",         0.0,
  "company_b",              "high",         0.0,
  "company_b",            "medium",         0.0,
  "company_b",               "low",           1,
)
# styler: on

usethis::use_data(xctr_toy_data, overwrite = TRUE)
