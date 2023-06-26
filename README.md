
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tiltPlot

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
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
