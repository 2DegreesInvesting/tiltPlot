
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

## Installation

You can install the development version of tiltPlot from GitHub with:

``` r
# install.packages("pak")
pak::pak("2DegreesInvesting/tiltPlot")
```

## Example

``` r
library(ggplot2)
library(dplyr, warn.conflicts = FALSE)
library(tiltPlot)
```

### 1. Sankey Plot with financial data

``` r
financial
#> # A tibble: 114 × 13
#>    bank_id amount_total company_name postcode wz    xctr_risk_category benchmark
#>    <chr>          <int> <chr>           <int> <chr> <chr>              <chr>    
#>  1 bank_b           500 peter peasa…    53773 A     high               all      
#>  2 bank_b           500 peter peasa…    53773 A     high               unit     
#>  3 bank_b           500 peter peasa…    53773 A     medium             tilt_sec 
#>  4 bank_b           500 peter peasa…    53773 A     medium             unit_til…
#>  5 bank_b           500 peter peasa…    53773 A     low                isic_sec 
#>  6 bank_b           500 peter peasa…    53773 A     medium             unit_isi…
#>  7 bank_b           500 tilman          12043 D     low                all      
#>  8 bank_b           500 tilman          12043 D     low                unit     
#>  9 bank_b           500 tilman          12043 D     medium             tilt_sec 
#> 10 bank_b           500 tilman          12043 D     medium             unit_til…
#> # ℹ 104 more rows
#> # ℹ 6 more variables: product_name <chr>, tilt_sector <chr>,
#> #   amount_of_distinct_products <int>, equal_weight_finance <dbl>,
#> #   worst_case_finance <int>, best_case_finance <int>
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

Finally, the user can choose different modes to plot the Sankey plot
with financial data available.

``` r
plot_sankey(fin, with_company = FALSE, mode = "best_case")
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

### 2. XCTR plots with financial data

``` r
financial
#> # A tibble: 114 × 13
#>    bank_id amount_total company_name postcode wz    xctr_risk_category benchmark
#>    <chr>          <int> <chr>           <int> <chr> <chr>              <chr>    
#>  1 bank_b           500 peter peasa…    53773 A     high               all      
#>  2 bank_b           500 peter peasa…    53773 A     high               unit     
#>  3 bank_b           500 peter peasa…    53773 A     medium             tilt_sec 
#>  4 bank_b           500 peter peasa…    53773 A     medium             unit_til…
#>  5 bank_b           500 peter peasa…    53773 A     low                isic_sec 
#>  6 bank_b           500 peter peasa…    53773 A     medium             unit_isi…
#>  7 bank_b           500 tilman          12043 D     low                all      
#>  8 bank_b           500 tilman          12043 D     low                unit     
#>  9 bank_b           500 tilman          12043 D     medium             tilt_sec 
#> 10 bank_b           500 tilman          12043 D     medium             unit_til…
#> # ℹ 104 more rows
#> # ℹ 6 more variables: product_name <chr>, tilt_sector <chr>,
#> #   amount_of_distinct_products <int>, equal_weight_finance <dbl>,
#> #   worst_case_finance <int>, best_case_finance <int>
```

On a company level:

``` r
fin <- financial

plot_xctr_financial(fin, "peter", mode = "worst_case") +
  labs(title = "Risk distribution of all products on a company level, on a financial weight")
```

<img src="man/figures/README-unnamed-chunk-8-1.png" width="100%" />

On a portfolio level:

``` r
plot_xctr_financial(fin, mode = "worst_case") +
  labs(title = "Risk distribution of all products on a portfolio level, on a financial weight")
```

<img src="man/figures/README-unnamed-chunk-9-1.png" width="100%" />

### 3. XCTR plots without financial data

``` r
without_financial
#> # A tibble: 58 × 5
#>    company_name  xctr_risk_category benchmark     product_name tilt_sector
#>    <chr>         <chr>              <chr>         <chr>        <chr>      
#>  1 peter peasant high               all           car          D          
#>  2 peter peasant high               unit          car          D          
#>  3 peter peasant medium             tilt_sec      car          D          
#>  4 peter peasant medium             unit_tilt_sec car          D          
#>  5 peter peasant low                isic_sec      car          D          
#>  6 peter peasant low                unit_isic_sec car          D          
#>  7 peter         high               all           banana       A          
#>  8 peter         high               unit          banana       A          
#>  9 peter         medium             tilt_sec      banana       A          
#> 10 peter         medium             unit_tilt_sec banana       A          
#> # ℹ 48 more rows
```

Plot on a company level. The user can choose any number of benchmark to
be plotted. If the benchmarks argument is not given to the function, the
function will plot all the benchmarks.

``` r
no_fin <- without_financial

benchmarks = c("all", "unit", "isic_sec")

no_fin |>
  filter(company_name == "peter") |>
  bar_plot_xctr(benchmarks) +
  labs(title = "Emission profile of all products on a company level")
```

<img src="man/figures/README-unnamed-chunk-11-1.png" width="100%" />

Plot on a portfolio level.

``` r
bar_plot_xctr(no_fin, benchmarks) +
  labs(title = "Emission profile of all products on a portfolio level")
```

<img src="man/figures/README-unnamed-chunk-12-1.png" width="100%" />

### 4. Create a German map with risk categories color gradient

``` r
map_region_risk(financial, "DE", benchmark = "unit_isic_sec") +
  labs(title = "German map of high, medium and low propotion of the companies
  that are found in one region.
  © EuroGeographics for the administrative boundaries ")
#> Object cached at /tmp/Rtmpq9D2bJ/eurostat/sf10320163035.RData
#> Reading cache file /tmp/Rtmpq9D2bJ/eurostat/sf10320163035.RData
#> sf at resolution 1: 10  from year  2016  read from cache file:  /tmp/Rtmpq9D2bJ/eurostat/sf10320163035.RData
```

<img src="man/figures/README-unnamed-chunk-13-1.png" width="100%" />
