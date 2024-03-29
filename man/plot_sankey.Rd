% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_sankey.R
\name{plot_sankey}
\alias{plot_sankey}
\title{Create a sankey plot with financial data}
\usage{
plot_sankey(
  data,
  with_company = TRUE,
  mode = c("equal_weight", "worst_case", "best_case")
)
}
\arguments{
\item{data}{A data frame like \link{financial}.}

\item{with_company}{Logical. If TRUE, will plot a node with the company name.
If FALSE, will plot without the company name node.}

\item{mode}{String. Several modes can be chosen by the user :
\itemize{
\item "equal_weight" means to divide the amount of the loan by the number of
products of the company.
\item "worst_case" means to weigh the loan as such that we assume that all money
goes into the highest risk product. If there are two or more products associated
with the same highest risk, we assume equal weights again.
\item "best_case" - similar to the worst-case scenario but just with the
lowest-risk category.
}}
}
\value{
A sankey plot of class \link{ggalluvial}.
}
\description{
Create a sankey plot with financial data
}
\examples{
# Plot with equal weight and with company name
plot_sankey(financial)

# Plot with best_case weight
plot_sankey(financial, mode = "best_case")
}
