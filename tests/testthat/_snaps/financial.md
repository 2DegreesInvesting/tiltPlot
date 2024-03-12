# hasn't changed

    Code
      as.data.frame(financial)
    Output
          bank_id amount_total  company_name postcode        benchmark ep_product
      1    bank_a         1000        tilman    12043              all        car
      2    bank_a         1000        tilman    12043              all    tractor
      3    bank_a         1000        tilman    12043              all      steel
      4    bank_a         1000        tilman    12043              all        car
      5    bank_a         1000        tilman    12043              all    tractor
      6    bank_a         1000        tilman    12043              all      steel
      7    bank_a         1000        tilman    12043              all        car
      8    bank_a         1000        tilman    12043              all    tractor
      9    bank_a         1000        tilman    12043              all      steel
      10   bank_a         1000        tilman    12043              all        car
      11   bank_a         1000        tilman    12043              all    tractor
      12   bank_a         1000        tilman    12043              all      steel
      13   bank_b          500        tilman    12043              all        car
      14   bank_b          500        tilman    12043              all    tractor
      15   bank_b          500        tilman    12043              all      steel
      16   bank_a         1000         bruno    27568              all      truck
      17   bank_a         1000         bruno    27568              all        car
      18   bank_a         1000         bruno    27568              all      steel
      19   bank_a         1000         mirja    34117              all      truck
      20   bank_a         1000         mirja    34117              all     cattle
      21   bank_a         1000         mauro    39221              all      steel
      22   bank_a         1000         mauro    39221              all    machine
      23   bank_a         1000 peter peasant    53773              all        car
      24   bank_b          500 peter peasant    53773              all        car
      25   bank_a         1000        pasant    80337              all      apple
      26   bank_a         1000        pasant    80337              all    tractor
      27   bank_a         1000         peter    88131              all     banana
      28   bank_a         1000         peter    88131              all      wheat
      29   bank_a         1000        tilman    12043      isic_4digit        car
      30   bank_a         1000        tilman    12043      isic_4digit    tractor
      31   bank_a         1000        tilman    12043      isic_4digit      steel
      32   bank_b          500        tilman    12043      isic_4digit        car
      33   bank_b          500        tilman    12043      isic_4digit    tractor
      34   bank_b          500        tilman    12043      isic_4digit      steel
      35   bank_a         1000         bruno    27568      isic_4digit      truck
      36   bank_a         1000         bruno    27568      isic_4digit        car
      37   bank_a         1000         bruno    27568      isic_4digit      steel
      38   bank_a         1000         mirja    34117      isic_4digit      truck
      39   bank_a         1000         mirja    34117      isic_4digit     cattle
      40   bank_a         1000         mauro    39221      isic_4digit      steel
      41   bank_a         1000         mauro    39221      isic_4digit    machine
      42   bank_a         1000 peter peasant    53773      isic_4digit        car
      43   bank_b          500 peter peasant    53773      isic_4digit        car
      44   bank_a         1000        pasant    80337      isic_4digit      apple
      45   bank_a         1000        pasant    80337      isic_4digit    tractor
      46   bank_a         1000         peter    88131      isic_4digit     banana
      47   bank_a         1000         peter    88131      isic_4digit      wheat
      48   bank_a         1000        tilman    12043      tilt_sector        car
      49   bank_a         1000        tilman    12043      tilt_sector    tractor
      50   bank_a         1000        tilman    12043      tilt_sector      steel
      51   bank_b          500        tilman    12043      tilt_sector        car
      52   bank_b          500        tilman    12043      tilt_sector    tractor
      53   bank_b          500        tilman    12043      tilt_sector      steel
      54   bank_a         1000         bruno    27568      tilt_sector      truck
      55   bank_a         1000         bruno    27568      tilt_sector        car
      56   bank_a         1000         bruno    27568      tilt_sector      steel
      57   bank_a         1000         mirja    34117      tilt_sector      truck
      58   bank_a         1000         mirja    34117      tilt_sector     cattle
      59   bank_a         1000         mauro    39221      tilt_sector      steel
      60   bank_a         1000         mauro    39221      tilt_sector    machine
      61   bank_a         1000 peter peasant    53773      tilt_sector        car
      62   bank_b          500 peter peasant    53773      tilt_sector        car
      63   bank_a         1000        pasant    80337      tilt_sector      apple
      64   bank_a         1000        pasant    80337      tilt_sector    tractor
      65   bank_a         1000         peter    88131      tilt_sector     banana
      66   bank_a         1000         peter    88131      tilt_sector      wheat
      67   bank_a         1000        tilman    12043             unit        car
      68   bank_a         1000        tilman    12043             unit    tractor
      69   bank_a         1000        tilman    12043             unit      steel
      70   bank_b          500        tilman    12043             unit        car
      71   bank_b          500        tilman    12043             unit    tractor
      72   bank_b          500        tilman    12043             unit      steel
      73   bank_a         1000         bruno    27568             unit      truck
      74   bank_a         1000         bruno    27568             unit        car
      75   bank_a         1000         bruno    27568             unit      steel
      76   bank_a         1000         mirja    34117             unit      truck
      77   bank_a         1000         mirja    34117             unit     cattle
      78   bank_a         1000         mauro    39221             unit      steel
      79   bank_a         1000         mauro    39221             unit    machine
      80   bank_a         1000 peter peasant    53773             unit        car
      81   bank_b          500 peter peasant    53773             unit        car
      82   bank_a         1000        pasant    80337             unit      apple
      83   bank_a         1000        pasant    80337             unit    tractor
      84   bank_a         1000         peter    88131             unit     banana
      85   bank_a         1000         peter    88131             unit      wheat
      86   bank_a         1000        tilman    12043 unit_isic_4digit        car
      87   bank_a         1000        tilman    12043 unit_isic_4digit    tractor
      88   bank_a         1000        tilman    12043 unit_isic_4digit      steel
      89   bank_b          500        tilman    12043 unit_isic_4digit        car
      90   bank_b          500        tilman    12043 unit_isic_4digit    tractor
      91   bank_b          500        tilman    12043 unit_isic_4digit      steel
      92   bank_a         1000         bruno    27568 unit_isic_4digit      truck
      93   bank_a         1000         bruno    27568 unit_isic_4digit        car
      94   bank_a         1000         bruno    27568 unit_isic_4digit      steel
      95   bank_a         1000         mirja    34117 unit_isic_4digit      truck
      96   bank_a         1000         mirja    34117 unit_isic_4digit     cattle
      97   bank_a         1000         mauro    39221 unit_isic_4digit      steel
      98   bank_a         1000         mauro    39221 unit_isic_4digit    machine
      99   bank_a         1000 peter peasant    53773 unit_isic_4digit        car
      100  bank_b          500 peter peasant    53773 unit_isic_4digit        car
      101  bank_a         1000        pasant    80337 unit_isic_4digit      apple
      102  bank_a         1000        pasant    80337 unit_isic_4digit    tractor
      103  bank_a         1000         peter    88131 unit_isic_4digit     banana
      104  bank_a         1000         peter    88131 unit_isic_4digit      wheat
      105  bank_a         1000        tilman    12043 unit_tilt_sector        car
      106  bank_a         1000        tilman    12043 unit_tilt_sector    tractor
      107  bank_a         1000        tilman    12043 unit_tilt_sector      steel
      108  bank_b          500        tilman    12043 unit_tilt_sector        car
      109  bank_b          500        tilman    12043 unit_tilt_sector    tractor
      110  bank_b          500        tilman    12043 unit_tilt_sector      steel
      111  bank_a         1000         bruno    27568 unit_tilt_sector      truck
      112  bank_a         1000         bruno    27568 unit_tilt_sector        car
      113  bank_a         1000         bruno    27568 unit_tilt_sector      steel
      114  bank_a         1000         mirja    34117 unit_tilt_sector      truck
      115  bank_a         1000         mirja    34117 unit_tilt_sector     cattle
      116  bank_a         1000         mauro    39221 unit_tilt_sector      steel
      117  bank_a         1000         mauro    39221 unit_tilt_sector    machine
      118  bank_a         1000 peter peasant    53773 unit_tilt_sector        car
      119  bank_b          500 peter peasant    53773 unit_tilt_sector        car
      120  bank_a         1000        pasant    80337 unit_tilt_sector      apple
      121  bank_a         1000        pasant    80337 unit_tilt_sector    tractor
      122  bank_a         1000         peter    88131 unit_tilt_sector     banana
      123  bank_a         1000         peter    88131 unit_tilt_sector      wheat
          co2_footprint_product tilt_sector tilt_subsector isic_4digit
      1                     0.1           D              d        4100
      2                     0.2           D              c        4100
      3                     0.3           C              b        4100
      4                     0.1           D              d        4100
      5                     0.2           D              c        4100
      6                     0.3           C              b        4100
      7                     0.1           D              d        4100
      8                     0.2           D              c        4100
      9                     0.3           C              b        4100
      10                    0.1           D              d        4100
      11                    0.2           D              c        4100
      12                    0.3           C              b        4100
      13                    0.1           D              c        4100
      14                    0.2           D              c        4100
      15                    0.3           C              d        4100
      16                    0.6           D              a        4100
      17                    0.1           D              d        4100
      18                    0.3           C              a        4100
      19                    0.6           D              a        4100
      20                    0.4           A              b        4100
      21                    0.3           C              d        4100
      22                    0.4           C              d        4100
      23                    0.1           D              d        4100
      24                    0.1           D              d        4100
      25                    0.1           A              c        4100
      26                    0.2           D              d        4100
      27                    0.1           A              d        4100
      28                    0.2           B              c        4100
      29                    0.1           D              d        4100
      30                    0.2           D              c        4100
      31                    0.3           C              b        4100
      32                    0.1           D              c        4100
      33                    0.2           D              c        4100
      34                    0.3           C              d        4100
      35                    0.6           D              a        4100
      36                    0.1           D              d        4100
      37                    0.3           C              a        4100
      38                    0.6           D              a        4100
      39                    0.4           A              b        4100
      40                    0.3           C              d        4100
      41                    0.4           C              d        4100
      42                    0.1           D              d        4100
      43                    0.1           D              d        4100
      44                    0.1           A              c        4100
      45                    0.2           D              d        4100
      46                    0.1           A              d        4100
      47                    0.2           B              c        4100
      48                    0.1           D              d        4100
      49                    0.2           D              c        4100
      50                    0.3           C              b        4100
      51                    0.1           D              c        4100
      52                    0.2           D              c        4100
      53                    0.3           C              d        4100
      54                    0.6           D              a        4100
      55                    0.1           D              d        4100
      56                    0.3           C              a        4100
      57                    0.6           D              a        4100
      58                    0.4           A              b        4100
      59                    0.3           C              d        4100
      60                    0.4           C              d        4100
      61                    0.1           D              d        4100
      62                    0.1           D              d        4100
      63                    0.1           A              c        4100
      64                    0.2           D              d        4100
      65                    0.1           A              d        4100
      66                    0.2           B              c        4100
      67                    0.1           D              d        4100
      68                    0.2           D              c        4100
      69                    0.3           C              b        4100
      70                    0.1           D              c        4100
      71                    0.2           D              c        4100
      72                    0.3           C              d        4100
      73                    0.6           D              a        4100
      74                    0.1           D              d        4100
      75                    0.3           C              a        4100
      76                    0.6           D              a        4100
      77                    0.4           A              b        4100
      78                    0.3           C              d        4100
      79                    0.4           C              d        4100
      80                    0.1           D              d        4100
      81                    0.1           D              d        4100
      82                    0.1           A              c        4100
      83                    0.2           D              d        4100
      84                    0.1           A              d        4100
      85                    0.2           B              c        4100
      86                    0.1           D              d        4100
      87                    0.2           D              c        4100
      88                    0.3           C              b        4100
      89                    0.1           D              c        4100
      90                    0.2           D              c        4100
      91                    0.3           C              d        4100
      92                    0.6           D              a        4100
      93                    0.1           D              d        4100
      94                    0.3           C              a        4100
      95                    0.6           D              a        4100
      96                    0.4           A              b        4100
      97                    0.3           C              d        4100
      98                    0.4           C              d        4100
      99                    0.1           D              d        4100
      100                   0.1           D              d        4100
      101                   0.1           A              c        4100
      102                   0.2           D              d        4100
      103                   0.1           A              d        4100
      104                   0.2           B              c        4100
      105                   0.1           D              d        4100
      106                   0.2           D              c        4100
      107                   0.3           C              b        4100
      108                   0.1           D              c        4100
      109                   0.2           D              c        4100
      110                   0.3           C              d        4100
      111                   0.6           D              a        4100
      112                   0.1           D              d        4100
      113                   0.3           C              a        4100
      114                   0.6           D              a        4100
      115                   0.4           A              b        4100
      116                   0.3           C              d        4100
      117                   0.4           C              d        4100
      118                   0.1           D              d        4100
      119                   0.1           D              d        4100
      120                   0.1           A              c        4100
      121                   0.2           D              d        4100
      122                   0.1           A              d        4100
      123                   0.2           B              c        4100
          isic_4digit_name amount_of_distinct_products equal_weight_finance
      1                  d                           3             333.3333
      2                  c                           3             333.3333
      3                  b                           3             333.3333
      4                  d                           3             333.3333
      5                  c                           3             333.3333
      6                  b                           3             333.3333
      7                  d                           3             333.3333
      8                  c                           3             333.3333
      9                  b                           3             333.3333
      10                 d                           3             333.3333
      11                 c                           3             333.3333
      12                 b                           3             333.3333
      13                 c                           3             166.6667
      14                 c                           3             166.6667
      15                 d                           3             166.6667
      16                 a                           3             333.3333
      17                 d                           3             333.3333
      18                 a                           3             333.3333
      19                 a                           2             500.0000
      20                 b                           2             500.0000
      21                 d                           2             500.0000
      22                 d                           2             500.0000
      23                 d                           1            1000.0000
      24                 d                           1             500.0000
      25                 c                           2             500.0000
      26                 d                           2             500.0000
      27                 d                           2             500.0000
      28                 c                           2             500.0000
      29                 d                           3             333.3333
      30                 c                           3             333.3333
      31                 b                           3             333.3333
      32                 c                           3             166.6667
      33                 c                           3             166.6667
      34                 d                           3             166.6667
      35                 a                           3             333.3333
      36                 d                           3             333.3333
      37                 a                           3             333.3333
      38                 a                           2             500.0000
      39                 b                           2             500.0000
      40                 d                           2             500.0000
      41                 d                           2             500.0000
      42                 d                           1            1000.0000
      43                 d                           1             500.0000
      44                 c                           2             500.0000
      45                 d                           2             500.0000
      46                 d                           2             500.0000
      47                 c                           2             500.0000
      48                 d                           3             333.3333
      49                 c                           3             333.3333
      50                 b                           3             333.3333
      51                 c                           3             166.6667
      52                 c                           3             166.6667
      53                 d                           3             166.6667
      54                 a                           3             333.3333
      55                 d                           3             333.3333
      56                 a                           3             333.3333
      57                 a                           2             500.0000
      58                 b                           2             500.0000
      59                 d                           2             500.0000
      60                 d                           2             500.0000
      61                 d                           1            1000.0000
      62                 d                           1             500.0000
      63                 c                           2             500.0000
      64                 d                           2             500.0000
      65                 d                           2             500.0000
      66                 c                           2             500.0000
      67                 d                           3             333.3333
      68                 c                           3             333.3333
      69                 b                           3             333.3333
      70                 c                           3             166.6667
      71                 c                           3             166.6667
      72                 d                           3             166.6667
      73                 a                           3             333.3333
      74                 d                           3             333.3333
      75                 a                           3             333.3333
      76                 a                           2             500.0000
      77                 b                           2             500.0000
      78                 d                           2             500.0000
      79                 d                           2             500.0000
      80                 d                           1            1000.0000
      81                 d                           1             500.0000
      82                 c                           2             500.0000
      83                 d                           2             500.0000
      84                 d                           2             500.0000
      85                 c                           2             500.0000
      86                 d                           3             333.3333
      87                 c                           3             333.3333
      88                 b                           3             333.3333
      89                 c                           3             166.6667
      90                 c                           3             166.6667
      91                 d                           3             166.6667
      92                 a                           3             333.3333
      93                 d                           3             333.3333
      94                 a                           3             333.3333
      95                 a                           2             500.0000
      96                 b                           2             500.0000
      97                 d                           2             500.0000
      98                 d                           2             500.0000
      99                 d                           1            1000.0000
      100                d                           1             500.0000
      101                c                           2             500.0000
      102                d                           2             500.0000
      103                d                           2             500.0000
      104                c                           2             500.0000
      105                d                           3             333.3333
      106                c                           3             333.3333
      107                b                           3             333.3333
      108                c                           3             166.6667
      109                c                           3             166.6667
      110                d                           3             166.6667
      111                a                           3             333.3333
      112                d                           3             333.3333
      113                a                           3             333.3333
      114                a                           2             500.0000
      115                b                           2             500.0000
      116                d                           2             500.0000
      117                d                           2             500.0000
      118                d                           1            1000.0000
      119                d                           1             500.0000
      120                c                           2             500.0000
      121                d                           2             500.0000
      122                d                           2             500.0000
      123                c                           2             500.0000
          worst_case_finance best_case_finance emission_profile profile_ranking
      1                  500                 0             high             0.7
      2                  500                 0             high             0.7
      3                    0              1000           medium             0.4
      4                  500                 0             high             0.7
      5                  500                 0             high             0.7
      6                    0              1000           medium             0.4
      7                  500                 0             high             0.7
      8                  500                 0             high             0.7
      9                    0              1000           medium             0.4
      10                 500                 0             high             0.7
      11                 500                 0             high             0.7
      12                   0              1000           medium             0.4
      13                 250                 0             high             0.7
      14                 250                 0             high             0.7
      15                   0               500           medium             0.4
      16                   0              1000              low             0.1
      17                1000                 0             high             0.7
      18                   0                 0           medium             0.4
      19                   0              1000              low             0.1
      20                1000                 0             high             0.7
      21                   0              1000           medium             0.4
      22                1000                 0             high             0.7
      23                1000              1000             high             0.7
      24                 500               500             high             0.7
      25                   0              1000              low             0.1
      26                1000                 0             high             0.7
      27                 500               500             high             0.7
      28                 500               500             high             0.7
      29                 500                 0             high             0.7
      30                 500                 0             high             0.7
      31                   0              1000           medium             0.4
      32                 250                 0             high             0.7
      33                 250                 0             high             0.7
      34                   0               500           medium             0.4
      35                   0              1000              low             0.1
      36                1000                 0             high             0.7
      37                   0                 0           medium             0.4
      38                   0              1000              low             0.1
      39                1000                 0             high             0.7
      40                   0              1000           medium             0.4
      41                1000                 0             high             0.7
      42                1000              1000             high             0.7
      43                 500               500             high             0.7
      44                   0              1000              low             0.1
      45                1000                 0             high             0.7
      46                 500               500             high             0.7
      47                 500               500             high             0.7
      48                 500                 0             high             0.7
      49                 500                 0             high             0.7
      50                   0              1000           medium             0.4
      51                 250                 0             high             0.7
      52                 250                 0             high             0.7
      53                   0               500           medium             0.4
      54                   0              1000              low             0.1
      55                1000                 0             high             0.7
      56                   0                 0           medium             0.4
      57                   0              1000              low             0.1
      58                1000                 0             high             0.7
      59                   0              1000           medium             0.4
      60                1000                 0             high             0.7
      61                1000              1000             high             0.7
      62                 500               500             high             0.7
      63                   0              1000              low             0.1
      64                1000                 0             high             0.7
      65                 500               500             high             0.7
      66                 500               500             high             0.7
      67                 500                 0             high             0.7
      68                 500                 0             high             0.7
      69                   0              1000           medium             0.4
      70                 250                 0             high             0.7
      71                 250                 0             high             0.7
      72                   0               500           medium             0.4
      73                   0              1000              low             0.1
      74                1000                 0             high             0.7
      75                   0                 0           medium             0.4
      76                   0              1000              low             0.1
      77                1000                 0             high             0.7
      78                   0              1000           medium             0.4
      79                1000                 0             high             0.7
      80                1000              1000             high             0.7
      81                 500               500             high             0.7
      82                   0              1000              low             0.1
      83                1000                 0             high             0.7
      84                 500               500             high             0.7
      85                 500               500             high             0.7
      86                 500                 0             high             0.7
      87                 500                 0             high             0.7
      88                   0              1000           medium             0.4
      89                 250                 0             high             0.7
      90                 250                 0             high             0.7
      91                   0               500           medium             0.4
      92                   0              1000              low             0.1
      93                1000                 0             high             0.7
      94                   0                 0           medium             0.4
      95                   0              1000              low             0.1
      96                1000                 0             high             0.7
      97                   0              1000           medium             0.4
      98                1000                 0             high             0.7
      99                1000              1000             high             0.7
      100                500               500             high             0.7
      101                  0              1000              low             0.1
      102               1000                 0             high             0.7
      103                500               500             high             0.7
      104                500               500             high             0.7
      105                500                 0             high             0.7
      106                500                 0             high             0.7
      107                  0              1000           medium             0.4
      108                250                 0             high             0.7
      109                250                 0             high             0.7
      110                  0               500           medium             0.4
      111                  0              1000              low             0.1
      112               1000                 0             high             0.7
      113                  0                 0           medium             0.4
      114                  0              1000              low             0.1
      115               1000                 0             high             0.7
      116                  0              1000           medium             0.4
      117               1000                 0             high             0.7
      118               1000              1000             high             0.7
      119                500               500             high             0.7
      120                  0              1000              low             0.1
      121               1000                 0             high             0.7
      122                500               500             high             0.7
      123                500               500             high             0.7
          sector_profile scenario year reduction_targets transition_risk_score
      1           medium      IPR 2030               0.3                  0.50
      2           medium      IPR 2030               0.2                  0.45
      3             high      IPR 2030               0.5                  0.45
      4           medium      IPR 2050               0.5                  0.60
      5           medium      IPR 2050               0.5                  0.60
      6             high      IPR 2050               0.6                  0.50
      7           medium      WEO 2030               0.4                  0.55
      8           medium      WEO 2030               0.4                  0.55
      9             high      WEO 2030               0.5                  0.45
      10          medium      WEO 2050               0.6                  0.65
      11          medium      WEO 2050               0.6                  0.65
      12            high      WEO 2050               0.7                  0.55
      13          medium      IPR 2030               0.2                  0.45
      14          medium      IPR 2050               0.2                  0.45
      15            high      IPR 2050               0.3                  0.35
      16             low      IPR 2050               0.2                  0.15
      17          medium      IPR 2050               0.3                  0.50
      18            high      WEO 2030               0.2                  0.30
      19             low      WEO 2030               0.2                  0.15
      20          medium      WEO 2030               0.5                  0.60
      21            high      WEO 2030               0.3                  0.35
      22          medium      WEO 2050               0.3                  0.50
      23          medium      WEO 2050               0.3                  0.50
      24          medium      WEO 2050               0.3                  0.50
      25             low      WEO 2050               0.2                  0.15
      26          medium      IPR 2030               0.3                  0.50
      27          medium      IPR 2030               0.3                  0.50
      28          medium      IPR 2030               0.2                  0.45
      29          medium      IPR 2030               0.3                  0.50
      30          medium      IPR 2030               0.2                  0.45
      31            high      IPR 2030               0.5                  0.45
      32          medium      IPR 2030               0.2                  0.45
      33          medium      IPR 2050               0.2                  0.45
      34            high      IPR 2050               0.3                  0.35
      35             low      IPR 2050               0.2                  0.15
      36          medium      IPR 2050               0.3                  0.50
      37            high      WEO 2030               0.2                  0.30
      38             low      WEO 2030               0.2                  0.15
      39          medium      WEO 2030               0.5                  0.60
      40            high      WEO 2030               0.3                  0.35
      41          medium      WEO 2050               0.3                  0.50
      42          medium      WEO 2050               0.3                  0.50
      43          medium      WEO 2050               0.3                  0.50
      44             low      WEO 2050               0.2                  0.15
      45          medium      IPR 2030               0.3                  0.50
      46          medium      IPR 2030               0.3                  0.50
      47          medium      IPR 2030               0.2                  0.45
      48          medium      IPR 2030               0.3                  0.50
      49          medium      IPR 2030               0.2                  0.45
      50            high      IPR 2030               0.5                  0.45
      51          medium      IPR 2030               0.2                  0.45
      52          medium      IPR 2050               0.2                  0.45
      53            high      IPR 2050               0.3                  0.35
      54             low      IPR 2050               0.2                  0.15
      55          medium      IPR 2050               0.3                  0.50
      56            high      WEO 2030               0.2                  0.30
      57             low      WEO 2030               0.2                  0.15
      58          medium      WEO 2030               0.5                  0.60
      59            high      WEO 2030               0.3                  0.35
      60          medium      WEO 2050               0.3                  0.50
      61          medium      WEO 2050               0.3                  0.50
      62          medium      WEO 2050               0.3                  0.50
      63             low      WEO 2050               0.2                  0.15
      64          medium      IPR 2030               0.3                  0.50
      65          medium      IPR 2030               0.3                  0.50
      66          medium      IPR 2030               0.2                  0.45
      67          medium      IPR 2030               0.3                  0.50
      68          medium      IPR 2030               0.2                  0.45
      69            high      IPR 2030               0.5                  0.45
      70          medium      IPR 2030               0.2                  0.45
      71          medium      IPR 2050               0.2                  0.45
      72            high      IPR 2050               0.3                  0.35
      73             low      IPR 2050               0.2                  0.15
      74          medium      IPR 2050               0.3                  0.50
      75            high      WEO 2030               0.2                  0.30
      76             low      WEO 2030               0.2                  0.15
      77          medium      WEO 2030               0.5                  0.60
      78            high      WEO 2030               0.3                  0.35
      79          medium      WEO 2050               0.3                  0.50
      80          medium      WEO 2050               0.3                  0.50
      81          medium      WEO 2050               0.3                  0.50
      82             low      WEO 2050               0.2                  0.15
      83          medium      IPR 2030               0.3                  0.50
      84          medium      IPR 2030               0.3                  0.50
      85          medium      IPR 2030               0.2                  0.45
      86          medium      IPR 2030               0.3                  0.50
      87          medium      IPR 2030               0.2                  0.45
      88            high      IPR 2030               0.5                  0.45
      89          medium      IPR 2030               0.2                  0.45
      90          medium      IPR 2050               0.2                  0.45
      91            high      IPR 2050               0.3                  0.35
      92             low      IPR 2050               0.2                  0.15
      93          medium      IPR 2050               0.3                  0.50
      94            high      WEO 2030               0.2                  0.30
      95             low      WEO 2030               0.2                  0.15
      96          medium      WEO 2030               0.5                  0.60
      97            high      WEO 2030               0.3                  0.35
      98          medium      WEO 2050               0.3                  0.50
      99          medium      WEO 2050               0.3                  0.50
      100         medium      WEO 2050               0.3                  0.50
      101            low      WEO 2050               0.2                  0.15
      102         medium      IPR 2030               0.3                  0.50
      103         medium      IPR 2030               0.3                  0.50
      104         medium      IPR 2030               0.2                  0.45
      105         medium      IPR 2030               0.3                  0.50
      106         medium      IPR 2030               0.2                  0.45
      107           high      IPR 2030               0.5                  0.45
      108         medium      IPR 2030               0.2                  0.45
      109         medium      IPR 2050               0.2                  0.45
      110           high      IPR 2050               0.3                  0.35
      111            low      IPR 2050               0.2                  0.15
      112         medium      IPR 2050               0.3                  0.50
      113           high      WEO 2030               0.2                  0.30
      114            low      WEO 2030               0.2                  0.15
      115         medium      WEO 2030               0.5                  0.60
      116           high      WEO 2030               0.3                  0.35
      117         medium      WEO 2050               0.3                  0.50
      118         medium      WEO 2050               0.3                  0.50
      119         medium      WEO 2050               0.3                  0.50
      120            low      WEO 2050               0.2                  0.15
      121         medium      IPR 2030               0.3                  0.50
      122         medium      IPR 2030               0.3                  0.50
      123         medium      IPR 2030               0.2                  0.45
          benchmark_transition_risk_score
      1                      all_IPR_2030
      2                      all_IPR_2030
      3                      all_IPR_2030
      4                      all_IPR_2050
      5                      all_IPR_2050
      6                      all_IPR_2050
      7                      all_IPR_2030
      8                      all_IPR_2030
      9                      all_IPR_2030
      10                     all_IPR_2050
      11                     all_IPR_2050
      12                     all_IPR_2050
      13                     all_IPR_2030
      14                     all_IPR_2050
      15                     all_IPR_2050
      16                     all_IPR_2050
      17                     all_IPR_2050
      18                     all_WEO_2030
      19                     all_WEO_2030
      20                     all_WEO_2030
      21                     all_WEO_2030
      22                     all_WEO_2050
      23                     all_WEO_2050
      24                     all_WEO_2050
      25                     all_WEO_2050
      26                     all_IPR_2030
      27                     all_IPR_2030
      28                     all_IPR_2030
      29             isic_4digit_IPR_2030
      30             isic_4digit_IPR_2030
      31             isic_4digit_IPR_2030
      32             isic_4digit_IPR_2030
      33             isic_4digit_IPR_2050
      34             isic_4digit_IPR_2050
      35             isic_4digit_IPR_2050
      36             isic_4digit_IPR_2050
      37             isic_4digit_WEO_2030
      38             isic_4digit_WEO_2030
      39             isic_4digit_WEO_2030
      40             isic_4digit_WEO_2030
      41             isic_4digit_WEO_2050
      42             isic_4digit_WEO_2050
      43             isic_4digit_WEO_2050
      44             isic_4digit_WEO_2050
      45             isic_4digit_IPR_2030
      46             isic_4digit_IPR_2030
      47             isic_4digit_IPR_2030
      48             tilt_sector_IPR_2030
      49             tilt_sector_IPR_2030
      50             tilt_sector_IPR_2030
      51             tilt_sector_IPR_2030
      52             tilt_sector_IPR_2050
      53             tilt_sector_IPR_2050
      54             tilt_sector_IPR_2050
      55             tilt_sector_IPR_2050
      56             tilt_sector_WEO_2030
      57             tilt_sector_WEO_2030
      58             tilt_sector_WEO_2030
      59             tilt_sector_WEO_2030
      60             tilt_sector_WEO_2050
      61             tilt_sector_WEO_2050
      62             tilt_sector_WEO_2050
      63             tilt_sector_WEO_2050
      64             tilt_sector_IPR_2030
      65             tilt_sector_IPR_2030
      66             tilt_sector_IPR_2030
      67                    unit_IPR_2030
      68                    unit_IPR_2030
      69                    unit_IPR_2030
      70                    unit_IPR_2030
      71                    unit_IPR_2050
      72                    unit_IPR_2050
      73                    unit_IPR_2050
      74                    unit_IPR_2050
      75                    unit_WEO_2030
      76                    unit_WEO_2030
      77                    unit_WEO_2030
      78                    unit_WEO_2030
      79                    unit_WEO_2050
      80                    unit_WEO_2050
      81                    unit_WEO_2050
      82                    unit_WEO_2050
      83                    unit_IPR_2030
      84                    unit_IPR_2030
      85                    unit_IPR_2030
      86        unit_isic_4digit_IPR_2030
      87        unit_isic_4digit_IPR_2030
      88        unit_isic_4digit_IPR_2030
      89        unit_isic_4digit_IPR_2030
      90        unit_isic_4digit_IPR_2050
      91        unit_isic_4digit_IPR_2050
      92        unit_isic_4digit_IPR_2050
      93        unit_isic_4digit_IPR_2050
      94        unit_isic_4digit_WEO_2030
      95        unit_isic_4digit_WEO_2030
      96        unit_isic_4digit_WEO_2030
      97        unit_isic_4digit_WEO_2030
      98        unit_isic_4digit_WEO_2050
      99        unit_isic_4digit_WEO_2050
      100       unit_isic_4digit_WEO_2050
      101       unit_isic_4digit_WEO_2050
      102       unit_isic_4digit_IPR_2030
      103       unit_isic_4digit_IPR_2030
      104       unit_isic_4digit_IPR_2030
      105       unit_tilt_sector_IPR_2030
      106       unit_tilt_sector_IPR_2030
      107       unit_tilt_sector_IPR_2030
      108       unit_tilt_sector_IPR_2030
      109       unit_tilt_sector_IPR_2050
      110       unit_tilt_sector_IPR_2050
      111       unit_tilt_sector_IPR_2050
      112       unit_tilt_sector_IPR_2050
      113       unit_tilt_sector_WEO_2030
      114       unit_tilt_sector_WEO_2030
      115       unit_tilt_sector_WEO_2030
      116       unit_tilt_sector_WEO_2030
      117       unit_tilt_sector_WEO_2050
      118       unit_tilt_sector_WEO_2050
      119       unit_tilt_sector_WEO_2050
      120       unit_tilt_sector_WEO_2050
      121       unit_tilt_sector_IPR_2030
      122       unit_tilt_sector_IPR_2030
      123       unit_tilt_sector_IPR_2030

