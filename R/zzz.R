.onLoad <- function(libname, pkgname) {
  font_add_google(tilt_text_font(), tilt_text_font())
  font_add_google(tilt_headline_font(), tilt_headline_font())
  font_add_google(fallback_font(), fallback_font())

  showtext_auto()
}
