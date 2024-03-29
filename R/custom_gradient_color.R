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
custom_gradient_color <- function(high, medium, low) {
  # define RGB values for "high," "medium," and "low"
  high_color <- red <- c(1, 0, 0)
  medium_color <- orange <- c(1, 0.5, 0)
  low_color <- green <- c(0, 1, 0)

  # interpolate the colors based on proportions : 1 is highest intensity
  final_color <- high_color * high + medium_color * medium + low_color * low

  final_color <- do.call(rgb, as.list(final_color))

  return(final_color)
}
