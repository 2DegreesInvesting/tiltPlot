# https://github.com/2DegreesInvesting/tiltIndicator/blob/main/R/example_dictionary.R#L128
example_data_factory <- function(data) {
  force(data)

  function(...) {
    new <- tibble(...)
    old <- as.list(data)
    add <- setdiff(names(old), names(new))
    as_tibble(append(new, old[add]))
  }
}

default_financial <- function(bank_id = "a",
                            amount_total = 10,
                            company_name = "b",
                            emission_profile = "medium",
                            benchmark = "c",
                            equal_weight_finance = 10,
                            worst_case_finance = 10,
                            best_case_finance = 10) {
  tibble(
    bank_id = bank_id,
    amount_total = amount_total,
    company_name = company_name,
    emission_profile = emission_profile,
    benchmark = benchmark,
    equal_weight_finance = equal_weight_finance,
    worst_case_finance = worst_case_finance,
    best_case_finance = best_case_finance
  )
}

#' Construct example financial data
#'
#' @param ... Passed to [tibble()].
#'
#' @return A [tibble()]
#' @keywords internal
#' @family example datasets
#' @export
#'
#' @examples
#' example_financial()
#'
#' # Add rows
#' example_financial(bank_id = 1:2)
#'
#' # Add columns
#' example_financial(new = 1)
#'
#' # Remove columns
#' example_financial(bank_id = NULL)
#'
#' # Pass column names stored in vectors
#' id <- "bank_id"
#' example_financial(!!id := "c")
example_financial <- example_data_factory(default_financial())


