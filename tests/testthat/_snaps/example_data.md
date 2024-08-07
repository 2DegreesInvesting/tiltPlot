# example_financial() has the expected structure

    Code
      str(example_financial())
    Output
      tibble [1 x 10] (S3: tbl_df/tbl/data.frame)
       $ bank_id              : chr "a"
       $ amount_total         : num 10
       $ company_name         : chr "b"
       $ emission_profile     : chr "medium"
       $ benchmark            : chr "all"
       $ profile_ranking      : num 0.1
       $ transition_risk_score: num 0.1
       $ equal_weight_finance : num 10
       $ worst_case_finance   : num 10
       $ best_case_finance    : num 10

# example_without_financial() has the expected structure

    Code
      str(example_without_financial())
    Output
      tibble [1 x 8] (S3: tbl_df/tbl/data.frame)
       $ company_name                 : chr "a"
       $ emission_profile             : chr "medium"
       $ benchmark                    : chr "all"
       $ scenario                     : chr "1.5C RPS"
       $ year                         : num 2030
       $ equal_weight_emission_profile: num 0.1
       $ worst_case_emission_profile  : num 0.1
       $ best_case_emission_profile   : num 0.1

