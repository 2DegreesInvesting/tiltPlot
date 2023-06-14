
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

``` r
toy_data
#> # A tibble: 2 × 5
#>   bank  amount amount_of_disctinct_products PCTR_risk_category tilt_sec
#>   <chr>  <dbl>                        <dbl> <chr>              <chr>   
#> 1 A          1                            2 low                sector_a
#> 2 B          2                            2 high               sector_b
```

``` r
plot_sankey(toy_data)
```
