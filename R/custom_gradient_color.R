#' Custom Gradient Color
#'
#' This function generates a custom gradient color based on the input values for
#' "high," "medium," and "low.
#'
#' @param high A numeric value representing the intensity of the "high" color
#' (0 to 1).
#' @param medium A numeric value representing the intensity of the "medium"
#' color (0 to 1).
#' @param low A numeric value representing the intensity of the "low" color
#' (0 to 1).
#'
#' @return A character string representing the combined RGB color code.
#' @noRd
#'
#' @examples
#' custom_gradient_color(1, 0.5, 0.2)
custom_gradient_color <- function(risk_score_high = 1, risk_score_medium = 1, risk_score_low = 1) {
  # define RGB values for "high," "medium," and "low"
  high_color <- red <- hex_to_rgb(high_hex())
  medium_color <- orange <- hex_to_rgb(medium_hex())
  low_color <- green <- hex_to_rgb(low_hex())

  # interpolate the colors based on proportions : 1 is highest intensity
  final_color <- high_color * risk_score_high + medium_color * risk_score_medium + low_color * risk_score_low

  final_color <- do.call(rgb, as.list(final_color))

  return(final_color)
}
