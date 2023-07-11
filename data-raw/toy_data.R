# styler: off
toy_data <- tibble::tribble(
    ~kg_id, ~amount_total,   ~company_name, ~wz, ~amount_of_distinct_products, ~pctr_risk_category, ~product_name, ~tilt_sector, ~equal_weight_finance, ~worst_case_finance, ~best_case_finance, ~main_activity,
  "bank_a",         1000L, "peter peasant", "A",                           1L,               "low",         "car",          "D",                  1000,               1000L,              1000L,             NA,
  "bank_a",         1000L,         "peter", "B",                           2L,               "low",      "banana",          "A",                   500,                500L,               500L,             0L,
  "bank_a",         1000L,         "peter", "B",                           2L,               "low",       "wheat",          "B",                   500,                500L,               500L,          1000L,
  "bank_a",         1000L,        "pasant", "A",                           2L,               "low",       "apple",          "A",                   500,                  0L,              1000L,          1000L,
  "bank_a",         1000L,        "pasant", "A",                           2L,            "medium",     "tractor",          "D",                   500,               1000L,                 0L,             0L,
  "bank_a",         1000L,         "mauro", "C",                           2L,            "medium",       "steel",          "C",                   500,                  0L,              1000L,           500L,
  "bank_a",         1000L,         "mauro", "C",                           2L,              "high",     "machine",          "C",                   500,               1000L,                 0L,           500L,
  "bank_a",         1000L,         "mirja", "D",                           2L,               "low",     "tractor",          "D",                   500,                  0L,              1000L,          1000L,
  "bank_a",         1000L,         "mirja", "D",                           2L,              "high",      "cattle",          "A",                   500,               1000L,                 0L,             0L,
  "bank_a",         1000L,         "bruno", "B",                           3L,               "low",      "banana",          "B",           333.3333333,                  0L,              1000L,          1000L,
  "bank_a",         1000L,         "bruno", "B",                           3L,              "high",         "car",          "D",           333.3333333,               1000L,                 0L,             0L,
  "bank_a",         1000L,         "bruno", "B",                           3L,            "medium",       "steel",          "C",           333.3333333,                  0L,                 0L,             0L,
  "bank_a",         1000L,        "tilman", "D",                           3L,              "high",         "car",          "D",           333.3333333,                500L,                 0L,           500L,
  "bank_a",         1000L,        "tilman", "D",                           3L,              "high",     "tractor",          "D",           333.3333333,                500L,                 0L,           500L,
  "bank_a",         1000L,        "tilman", "D",                           3L,               "low",       "steel",          "C",           333.3333333,                  0L,              1000L,             0L,
  "bank_b",          500L, "peter peasant", "A",                           1L,               "low",         "car",          "D",                   500,                500L,               500L,             NA,
  "bank_b",          500L,        "tilman", "D",                           3L,              "high",         "car",          "D",           166.6666667,                250L,                 0L,           250L,
  "bank_b",          500L,        "tilman", "D",                           3L,              "high",     "tractor",          "D",           166.6666667,                250L,                 0L,           250L,
  "bank_b",          500L,        "tilman", "D",                           3L,               "low",       "steel",          "C",           166.6666667,                  0L,               500L,             0L
  )
# styler: on

usethis::use_data(toy_data, overwrite = TRUE)
