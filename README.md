
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

``` r
library(ggplot2)
library(tiltPlot)
```

### 1. Sankey Plot

``` r
financial
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
#> # ℹ 7 more variables: xctr_risk_category <chr>, product_name <chr>,
#> #   tilt_sector <chr>, equal_weight_finance <dbl>, worst_case_finance <int>,
#> #   best_case_finance <int>, main_activity <int>
```

Here is the default Sankey Plot. By default the function plots with
companies and uses an “equal_weight” mode.

``` r
fin <- financial
plot_sankey(fin)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

You can also choose to have the plot without the company node.

``` r
plot_sankey(fin, with_company = FALSE)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

Finally, the user can choose different modes to plot the Sankey plot if
financial data is available.

``` r
plot_sankey(fin, with_company = FALSE, mode = "best_case")
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

### 2. XCTR plots without financial data

``` r
xctr_toy_data
#> # A tibble: 6 × 4
#>   company_name xctr_risk_category xctr_share benchmark
#>   <chr>        <chr>                   <dbl> <chr>    
#> 1 company_a    high                      0.5 unit     
#> 2 company_a    low                       0.5 unit     
#> 3 company_a    medium                    0   unit     
#> 4 company_b    high                      0   tilt_sec 
#> 5 company_b    medium                    0   tilt_sec 
#> 6 company_b    low                       1   tilt_sec
```

Plot on a company-level:

``` r
plot_xctr_company(xctr_toy_data, "company_a") +
  # You can customize your plots as usual with ggplot2: https://ggplot2.tidyverse.org/
  labs(title = "Risk distribution of all products on a company level") 
```

<img src="man/figures/README-unnamed-chunk-8-1.png" width="100%" />

Plot on a portfolio-level:

``` r
plot_xctr_portfolio(xctr_toy_data) +
  labs(title = "Risk distribution of all products on a portfolio level")
```

<img src="man/figures/README-unnamed-chunk-9-1.png" width="100%" />
