# hasn't changed

    Code
      financial
    Output
      # A tibble: 19 x 12
         kg_id  amount_total company_name  wz    amount_of_distinct_products
         <chr>         <int> <chr>         <chr>                       <int>
       1 bank_a         1000 peter peasant A                               1
       2 bank_a         1000 peter         B                               2
       3 bank_a         1000 peter         B                               2
       4 bank_a         1000 pasant        A                               2
       5 bank_a         1000 pasant        A                               2
       6 bank_a         1000 mauro         C                               2
       7 bank_a         1000 mauro         C                               2
       8 bank_a         1000 mirja         D                               2
       9 bank_a         1000 mirja         D                               2
      10 bank_a         1000 bruno         B                               3
      11 bank_a         1000 bruno         B                               3
      12 bank_a         1000 bruno         B                               3
      13 bank_a         1000 tilman        D                               3
      14 bank_a         1000 tilman        D                               3
      15 bank_a         1000 tilman        D                               3
      16 bank_b          500 peter peasant A                               1
      17 bank_b          500 tilman        D                               3
      18 bank_b          500 tilman        D                               3
      19 bank_b          500 tilman        D                               3
      # i 7 more variables: xctr_risk_category <chr>, product_name <chr>,
      #   tilt_sector <chr>, equal_weight_finance <dbl>, worst_case_finance <int>,
      #   best_case_finance <int>, main_activity <int>

