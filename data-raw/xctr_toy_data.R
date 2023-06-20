# styler: off
pctr_toy_data <- tibble::tribble(
  ~company_name, ~pctr_risk_category, ~pctr_share,
  "company_a",              "high",           1,
  "company_a",               "low",         0.5,
  "company_a",            "medium",           0,
  "company_b",            "medium",         0.5,
  "company_b",               "low",           1,
)
# styler: on

usethis::use_data(pctr_toy_data, overwrite = TRUE)
