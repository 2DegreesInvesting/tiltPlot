default_financial <- function(bank_id = "a",
                              amount_total = 10,
                              company_name = "b",
                              emission_profile = "medium",
                              benchmark = "all",
                              profile_ranking = 0.1,
                              transition_risk_score = 0.1,
                              equal_weight_finance = 10,
                              worst_case_finance = 10,
                              best_case_finance = 10) {
  tibble(
    bank_id = bank_id,
    amount_total = amount_total,
    company_name = company_name,
    emission_profile = emission_profile,
    benchmark = benchmark,
    profile_ranking = profile_ranking,
    transition_risk_score = transition_risk_score,
    equal_weight_finance = equal_weight_finance,
    worst_case_finance = worst_case_finance,
    best_case_finance = best_case_finance
  )
}

default_without_financial <- function(company_name = "a",
                                      emission_profile = "medium",
                                      benchmark = "all",
                                      equal_weight = 0.1,
                                      worst_case = 0.1,
                                      best_case = 0.1) {
  tibble(
    company_name = company_name,
    emission_profile = emission_profile,
    benchmark = benchmark,
    equal_weight = equal_weight,
    worst_case = worst_case,
    best_case = best_case
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
example_financial <- tiltIndicator::example_data_factory(default_financial())


#' Construct example without financial data
#'
#' @param ... Passed to [tibble()].
#'
#' @return A [tibble()]
#' @keywords internal
#' @family example datasets
#' @export
#'
#' @examples
#' example_without_financial()
#'
#' #' # Add columns
#' example_without_financial(new = 1)
example_without_financial <- tiltIndicator::example_data_factory(default_without_financial())
