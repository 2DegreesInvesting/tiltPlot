# example_financial() has the expected structure

    Code
      str(example_financial())
    Output
      tibble [1 x 10] (S3: tbl_df/tbl/data.frame)
       $ bank_id              : chr "a"
       $ amount_total         : num 10
       $ company_name         : chr "b"
       $ emission_category    : chr "medium"
       $ grouping_emission    : chr "all"
       $ profile_ranking      : num 0.1
       $ transition_risk_score: num 0.1
       $ equal_weight_finance : num 10
       $ worst_case_finance   : num 10
       $ best_case_finance    : num 10

# example_without_financial() has the expected structure

    Code
      str(example_without_financial())
    Output
      tibble [3 x 9] (S3: tbl_df/tbl/data.frame)
       $ company_name                  : chr [1:3] "a" "a" "a"
       $ emission_category             : chr [1:3] "low" "medium" "high"
       $ grouping_emission             : chr [1:3] "all" "all" "all"
       $ scenario                      : chr [1:3] "1.5C RPS" "1.5C RPS" "1.5C RPS"
       $ year                          : num [1:3] 2030 2030 2030
       $ product                       : chr [1:3] "a" "b" "c"
       $ emissions_profile_equal_weight: num [1:3] 0.1 0.1 0.1
       $ emissions_profile_worst_case  : num [1:3] 0.1 0.1 0.1
       $ emissions_profile_best_case   : num [1:3] 0.1 0.1 0.1

