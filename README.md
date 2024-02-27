
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
#> # A tibble: 114 × 15
#>    bank_id amount_total company_name postcode emission_profile benchmark
#>    <chr>          <int> <chr>           <int> <chr>            <chr>    
#>  1 bank_a          1000 tilman          12043 high             all      
#>  2 bank_a          1000 tilman          12043 high             all      
#>  3 bank_a          1000 tilman          12043 medium           all      
#>  4 bank_b           500 tilman          12043 high             all      
#>  5 bank_b           500 tilman          12043 high             all      
#>  6 bank_b           500 tilman          12043 medium           all      
#>  7 bank_a          1000 bruno           27568 low              all      
#>  8 bank_a          1000 bruno           27568 high             all      
#>  9 bank_a          1000 bruno           27568 medium           all      
#> 10 bank_a          1000 mirja           34117 low              all      
#> # ℹ 104 more rows
#> # ℹ 9 more variables: ep_product <chr>, tilt_sector <chr>,
#> #   tilt_subsector <chr>, isic_4digit <chr>, isic_4digit_name <chr>,
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

### 2. Emission risk plots with financial data

``` r
financial
#> # A tibble: 114 × 15
#>    bank_id amount_total company_name postcode emission_profile benchmark
#>    <chr>          <int> <chr>           <int> <chr>            <chr>    
#>  1 bank_a          1000 tilman          12043 high             all      
#>  2 bank_a          1000 tilman          12043 high             all      
#>  3 bank_a          1000 tilman          12043 medium           all      
#>  4 bank_b           500 tilman          12043 high             all      
#>  5 bank_b           500 tilman          12043 high             all      
#>  6 bank_b           500 tilman          12043 medium           all      
#>  7 bank_a          1000 bruno           27568 low              all      
#>  8 bank_a          1000 bruno           27568 high             all      
#>  9 bank_a          1000 bruno           27568 medium           all      
#> 10 bank_a          1000 mirja           34117 low              all      
#> # ℹ 104 more rows
#> # ℹ 9 more variables: ep_product <chr>, tilt_sector <chr>,
#> #   tilt_subsector <chr>, isic_4digit <chr>, isic_4digit_name <chr>,
#> #   amount_of_distinct_products <int>, equal_weight_finance <dbl>,
#> #   worst_case_finance <int>, best_case_finance <int>
```

On a company level:

``` r
fin <- financial

benchmarks <- c("all", "unit")

fin |> 
  filter(company_name == "tilman") |> 
  bar_plot_emission_profile_financial(benchmarks, mode = "equal_weight") +
  labs(title = "Risk distribution of all products on a company level, on a equal 
       weight financial mode")
```

<img src="man/figures/README-unnamed-chunk-8-1.png" width="100%" />

On a portfolio level:

``` r
bar_plot_emission_profile_financial(fin, benchmarks, mode = "equal_weight") +
  labs(title = "Risk distribution of all products on a portfolio level, on a equal 
       weight financial mode")
```

<img src="man/figures/README-unnamed-chunk-9-1.png" width="100%" />

### 3. Emission profile plots without financial data

``` r
without_financial
#> # A tibble: 114 × 12
#>    company_name postcode emission_profile benchmark ep_product tilt_sector
#>    <chr>           <int> <chr>            <chr>     <chr>      <chr>      
#>  1 bruno           27568 high             all       car        D          
#>  2 bruno           27568 high             all       steel      C          
#>  3 bruno           27568 medium           all       wheat      B          
#>  4 mauro           39221 high             all       steel      C          
#>  5 mauro           39221 high             all       machine    C          
#>  6 mirja           34117 high             all       tractor    D          
#>  7 mirja           34117 high             all       cattle     A          
#>  8 pasant          80337 high             all       tractor    D          
#>  9 pasant          80337 low              all       apple      A          
#> 10 peter           88131 high             all       banana     A          
#> # ℹ 104 more rows
#> # ℹ 6 more variables: tilt_subsector <chr>, isic_4digit <chr>,
#> #   isic_4digit_name <chr>, equal_weight <dbl>, worst_case <dbl>,
#> #   best_case <dbl>
```

Plot on a company level. The user can choose any number of benchmark to
be plotted. If the benchmarks argument is not given to the function, the
function will plot all the benchmarks.

``` r
no_fin <- without_financial

benchmarks <- c("all", "isic_4digit", "unit")

no_fin |>
  filter(company_name == "peter") |>
  bar_plot_emission_profile(benchmarks) +
  labs(title = "Emission profile of all products on a company level")
```

<img src="man/figures/README-unnamed-chunk-11-1.png" width="100%" />

Plot on a portfolio level.

``` r
bar_plot_emission_profile(no_fin, benchmarks) +
  labs(title = "Emission profile of all products on a portfolio level")
```

<img src="man/figures/README-unnamed-chunk-12-1.png" width="100%" />

### 4. Create a German map with risk categories color gradient, without financial

Different modes can be chosen: “equal_weight”, “worst_case” and
“best_case”. If nothing is chosen, equal_weight the default mode.

``` r
no_fin <- without_financial

map_region_risk(no_fin, "DE", benchmark = "tilt_sector", mode = "worst_case") +
  labs(title = "German map of high, medium and low proportions of the companies
  that are found in one region.
  © EuroGeographics for the administrative boundaries ")
#> Extracting data using giscoR package, please report issues on https://github.com/rOpenGov/giscoR/issues
```

<img src="man/figures/README-unnamed-chunk-13-1.png" width="100%" />
