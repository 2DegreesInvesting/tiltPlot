#' Apply customizations to a ggplot2 plot
#'
#' Adds specific geoms and themes to the provided plot.
#'
#' @param plot A ggplot2 plot object
#' @return A modified ggplot2 plot object
tweak_xctr_plot <- function(plot) {
  # Perform any plot customization here
  plot +
    geom_col() +
    fill_score_colors() +
    theme_tiltplot()
}
