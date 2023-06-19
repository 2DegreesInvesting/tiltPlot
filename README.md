
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
#> # A tibble: 4 × 5
#>   bank  amount amount_of_disctinct_products pctr_risk_category tilt_sec
#>   <chr>  <dbl>                        <dbl> <chr>              <chr>   
#> 1 A          5                            1 low                sector_a
#> 2 A          5                            1 low                sector_b
#> 3 B          2                            2 medium             sector_a
#> 4 B         10                            2 high               sector_b
```

``` r
plot_sankey(toy_data)
```
