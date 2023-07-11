
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tiltPlot

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/2DegreesInvesting/tiltPlot/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/2DegreesInvesting/tiltPlot/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/2DegreesInvesting/tiltPlot/branch/main/graph/badge.svg)](https://app.codecov.io/gh/2DegreesInvesting/tiltPlot?branch=main)
<!-- badges: end -->

The goal of tiltPlot is to provide plots for the TILT project.

## Example

Let us load the toy data set.

``` r
library(tiltPlot)
```

### 1. Sankey Plot

``` r
toy_data
#> # A tibble: 19 × 12
#>    kg_id  amount_total company_name  wz    amount_of_distinct_products
#>    <chr>         <int> <chr>         <chr>                       <int>
#>  1 bank_a         1000 peter peasant A                               1
#>  2 bank_a         1000 peter         B                               2
#>  3 bank_a         1000 peter         B                               2
#>  4 bank_a         1000 pasant        A                               2
#>  5 bank_a         1000 pasant        A                               2
#>  6 bank_a         1000 mauro         C                               2
#>  7 bank_a         1000 mauro         C                               2
#>  8 bank_a         1000 mirja         D                               2
#>  9 bank_a         1000 mirja         D                               2
#> 10 bank_a         1000 bruno         B                               3
#> 11 bank_a         1000 bruno         B                               3
#> 12 bank_a         1000 bruno         B                               3
#> 13 bank_a         1000 tilman        D                               3
#> 14 bank_a         1000 tilman        D                               3
#> 15 bank_a         1000 tilman        D                               3
#> 16 bank_b          500 peter peasant A                               1
#> 17 bank_b          500 tilman        D                               3
#> 18 bank_b          500 tilman        D                               3
#> 19 bank_b          500 tilman        D                               3
#> # ℹ 7 more variables: pctr_risk_category <chr>, product_name <chr>,
#> #   tilt_sector <chr>, equal_weight_finance <dbl>, worst_case_finance <int>,
#> #   best_case_finance <int>, main_activity <int>
```

``` r
plot_sankey(toy_data, with_company = TRUE, mode = "equal_weight")
```

### 2. XCTR plot for one company

``` r
xctr_toy_data
#> # A tibble: 6 × 3
#>   company_name xctr_risk_category xctr_share
#>   <chr>        <chr>                   <dbl>
#> 1 company_a    high                      0.5
#> 2 company_a    low                       0.5
#> 3 company_a    medium                    0  
#> 4 company_b    high                      0  
#> 5 company_b    medium                    0  
#> 6 company_b    low                       1
```

``` r
plot_xctr_company_level(xctr_toy_data, "company_a")
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />
