# styler: off
pctr_toy_data <- tibble::tribble(
  ~company_name, ~pctr_risk_category, ~pctr_share,
  "A",              "high",           0,
  "A",               "low",         0.5,
  "B",            "medium",           1,
  "B",               "low",           1
)
# styler: on

usethis::use_data(pctr_toy_data, overwrite = TRUE)
