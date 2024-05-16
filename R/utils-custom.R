#' TiltPlot theme for the graphs
#'
#' @return An object of class "theme", "gg".
#' @export
#'
#' @examples
#' library(ggplot2, warn.conflicts = FALSE)
#'
#' ggplot(mtcars) +
#'   geom_histogram(aes(mpg), bins = 10) +
#'   theme_tiltplot()
theme_tiltplot <- function() {
  theme_classic() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 16, family = tilt_headline_font()),
      strip.text = element_text(family = tilt_text_font()),
      axis.title = element_text(size = 10, family = tilt_text_font()),
      axis.text = element_text(size = 10, family = tilt_text_font()),
      legend.title = element_text(size = 12, family = tilt_text_font()),
      legend.text = element_text(size = 10, family = tilt_text_font()),
      legend.position = "bottom",
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
      panel.spacing.y = unit(0.5, "lines")
    )
}

tilt_text_font <- function() "Roboto"

tilt_headline_font <- function() "Roboto Condensed"

high_hex <- function() "#e3693b"
medium_hex <- function() "#f6cb4e"
low_hex <- function() "#b3d15d"

score_colors <- function(...) c("low" = low_hex(), "medium" = medium_hex(), "high" = high_hex())

fill_score_colors <- function() scale_fill_manual(values = score_colors())

hex_to_rgb <- function(hex) {
  rgb <- col2rgb(hex)
  rgb_dec <- rgb / 255
  rgb_dec
}

width_bar <- function() 0.5

value_shape_triangle <- function() 17

value_shape_pentagon <- function() 18

# TODO: change from "label" to "legend"
label_bank <- function() "bank"
label_company <- function() "company"
label_emission_profile <- function() "emission profile"
label_risk_categories <- function() "risk categories"
label_tilt_sector <- function() "tilt sector"
transition_risk_legend <- function() "transition risk score"
emission_profile_legend <- function() "emission rank"

format_label <- toTitleCase
