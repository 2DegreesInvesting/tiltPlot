
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
#> # A tibble: 4 × 6
#>   bank  amount company_name amount_of_distinct_pro…¹ pctr_risk_category tilt_sec
#>   <chr>  <dbl> <chr>                           <dbl> <chr>              <chr>   
#> 1 A          5 Peter                               2 low                sector_a
#> 2 A          5 Peter                               2 high               sector_b
#> 3 B         10 Mario                               1 medium             sector_c
#> 4 C          8 Mario                               1 low                sector_c
#> # ℹ abbreviated name: ¹​amount_of_distinct_products
```

``` r
plot_sankey(toy_data, with_company = TRUE)
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
