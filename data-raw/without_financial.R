# styler: off
without_financial <- tibble::tribble(
              ~amount,   ~company_name, ~amount_of_distinct_products, ~xctr_risk_category, ~xctr_share,      ~benchmark, ~equal_weight_finance,
                1000L, "peter peasant",                           1L,               "low",         0.5, "unit_tilt_sec",                  1000,
                 500L, "peter peasant",                           1L,               "low",           0, "unit_tilt_sec",                   500,
                 200L, "peter peasant",                           1L,               "low",           0, "unit_tilt_sec",                   200,
                 400L,         "peter",                           2L,               "low",         0.5, "unit_tilt_sec",                   200,
                 400L,         "peter",                           2L,               "low",         0.5, "unit_tilt_sec",                   200,
                 600L,         "peter",                           2L,               "low",           0, "unit_tilt_sec",                   300,
                 600L,         "peter",                           2L,               "low",           0, "unit_tilt_sec",                   300,
                1000L,         "mario",                           4L,            "medium",         0.5, "unit_tilt_sec",                   250,
                1000L,         "mario",                           4L,            "medium",           0, "unit_tilt_sec",                   250,
                1000L,         "mario",                           4L,               "low",         0.5, "unit_tilt_sec",                   250,
                1000L,         "mario",                           4L,               "low",           0, "unit_tilt_sec",                   250,
                  50L,        "pasant",                           2L,               "low",           1, "unit_tilt_sec",                    25,
                  50L,        "pasant",                           2L,            "medium",           0, "unit_tilt_sec",                    25,
                 800L,       "andreas",                           1L,              "high",           1, "unit_tilt_sec",                   800,
                  50L,          "maja",                           1L,               "low",           0, "unit_tilt_sec",                    50,
                 100L,          "milo",                           1L,            "medium",           0, "unit_tilt_sec",                   100,
                1000L,        "martha",                           2L,              "high",         0.5, "unit_tilt_sec",                   500,
                1000L,        "martha",                           2L,              "high",         0.5, "unit_tilt_sec",                   500,
                 500L,       "kirsten",                           3L,            "medium",         0.5, "unit_tilt_sec",           166.6666667,
                 500L,       "kirsten",                           3L,               "low",           0, "unit_tilt_sec",           166.6666667,
                 500L,       "kirsten",                           3L,            "medium",           0, "unit_tilt_sec",           166.6666667,
                 300L,         "bruno",                           3L,               "low",           1, "unit_tilt_sec",                   100,
                 300L,         "bruno",                           3L,              "high",           0, "unit_tilt_sec",                   100,
                 300L,         "bruno",                           3L,               "low",           0, "unit_tilt_sec",                   100,
                 100L,           "lea",                           5L,               "low",         0.5, "unit_tilt_sec",                    20,
                 100L,           "lea",                           5L,               "low",           0, "unit_tilt_sec",                    20,
                 100L,           "lea",                           5L,               "low",           0, "unit_tilt_sec",                    20,
                 100L,           "lea",                           5L,            "medium",         0.5, "unit_tilt_sec",                    20,
                 100L,           "lea",                           5L,               "low",           0, "unit_tilt_sec",                    20,
                  40L,      "matthias",                           1L,            "medium",           1, "unit_tilt_sec",                    40
              )
# styler: on

usethis::use_data(without_financial, overwrite = TRUE)
