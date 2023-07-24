# hasn't changed

    Code
      as.data.frame(financial)
    Output
          kg_id amount_total  company_name wz amount_of_distinct_products
      1  bank_a         1000 peter peasant  A                           1
      2  bank_a         1000         peter  B                           2
      3  bank_a         1000         peter  B                           2
      4  bank_a         1000        pasant  A                           2
      5  bank_a         1000        pasant  A                           2
      6  bank_a         1000         mauro  C                           2
      7  bank_a         1000         mauro  C                           2
      8  bank_a         1000         mirja  D                           2
      9  bank_a         1000         mirja  D                           2
      10 bank_a         1000         bruno  B                           3
      11 bank_a         1000         bruno  B                           3
      12 bank_a         1000         bruno  B                           3
      13 bank_a         1000        tilman  D                           3
      14 bank_a         1000        tilman  D                           3
      15 bank_a         1000        tilman  D                           3
      16 bank_b          500 peter peasant  A                           1
      17 bank_b          500        tilman  D                           3
      18 bank_b          500        tilman  D                           3
      19 bank_b          500        tilman  D                           3
         xctr_risk_category product_name tilt_sector equal_weight_finance
      1                 low          car           D            1000.0000
      2                 low       banana           A             500.0000
      3                 low        wheat           B             500.0000
      4                 low        apple           A             500.0000
      5              medium      tractor           D             500.0000
      6              medium        steel           C             500.0000
      7                high      machine           C             500.0000
      8                 low      tractor           D             500.0000
      9                high       cattle           A             500.0000
      10                low       banana           B             333.3333
      11               high          car           D             333.3333
      12             medium        steel           C             333.3333
      13               high          car           D             333.3333
      14               high      tractor           D             333.3333
      15                low        steel           C             333.3333
      16                low          car           D             500.0000
      17               high          car           D             166.6667
      18               high      tractor           D             166.6667
      19                low        steel           C             166.6667
         worst_case_finance best_case_finance main_activity
      1                1000              1000            NA
      2                 500               500             0
      3                 500               500          1000
      4                   0              1000          1000
      5                1000                 0             0
      6                   0              1000           500
      7                1000                 0           500
      8                   0              1000          1000
      9                1000                 0             0
      10                  0              1000          1000
      11               1000                 0             0
      12                  0                 0             0
      13                500                 0           500
      14                500                 0           500
      15                  0              1000             0
      16                500               500            NA
      17                250                 0           250
      18                250                 0           250
      19                  0               500             0

