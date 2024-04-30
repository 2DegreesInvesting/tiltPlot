#' Construct example financial data
#'
#' @param ... Passed to [tibble()].
#'
#' @return A [tibble()]
#' @keywords internal
#' @export
#'
#' @examples
#' example_financial()
example_financial <- function(bank_id = "a",
                              amount_total = 10,
                              company_name = "b",
                              emission_profile = "medium",
                              benchmark = "c",
                              equal_weight_finance = 10,
                              worst_case_finance = 10,
                              best_case_finance = 10,
                              ...) {
  tibble::tibble(
    bank_id = bank_id,
    amount_total = amount_total,
    company_name = company_name,
    emission_profile = emission_profile,
    benchmark = benchmark,
    equal_weight_finance = equal_weight_finance,
    worst_case_finance = worst_case_finance,
    best_case_finance = best_case_finance,
    ...
  )
}
