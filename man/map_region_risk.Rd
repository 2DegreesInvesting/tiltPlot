% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map_region_risk.R
\name{map_region_risk}
\alias{map_region_risk}
\title{Create a map with the risk color of each region (NUTS3 granularity), without
financial data.}
\usage{
map_region_risk(
  data,
  country_code = c("DE"),
  benchmark = c("all", "isic_4digit", "tilt_sector", "unit", "unit_isic_4digit",
    "unit_tilt_sector"),
  mode = c("equal_weight", "worst_case", "best_case")
)
}
\arguments{
\item{data}{A data frame like \link{without_financial}}

\item{country_code}{Country code (ISO 3166 alpha-2) for which the map will be
plotted.}

\item{benchmark}{The mode of benchmark to plot.
It can be one of "all", "unit" or "tilt_sector", "unit_tilt_sector",
"isic_4digit" or "unit_isic_4digit". If nothing is chosen, "all" is the
default mode.}

\item{mode}{The mode to plot. It can be one of "equal_weight", "worst_case"
or "best_case". If nothing is chosen, "equal_weight" is the default mode.}
}
\value{
A ggplot2 object representing the country data plot.
}
\description{
Create a map with the risk color of each region (NUTS3 granularity), without
financial data.
}
\examples{
# Plot a German with a "unit" benchmark and equal_weight finance
try({
  map_region_risk(without_financial, country_code = "DE", benchmark = "unit")
})
}
