# NUTS3 to postcodes file
# Source from European Commission: https://gisco-services.ec.europa.eu/tercet/flat-files
library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
devtools::load_all()

set.seed(111)
options(readr.show_col_types = FALSE)

assign_NL_to_NUTS <- function(data) {
  data |>
    mutate(count = n(), .by = c("CODE")) |>
    mutate(NUTS3 = ifelse(count > 1, "NL", .data$NUTS3)) |>
    select(-c("count")) |>
    distinct()
}

remove_quotes <- function(data) {
  data$CODE <- gsub("'", "", data$CODE)
  data$NUTS3 <- gsub("'", "", data$NUTS3)
  return(data)
}

nl_mapper <- "data-raw/NUTS_postcode/pc2024_NL_NUTS-2024_v2.0.csv" |>
  read_csv(show_col_types = FALSE) |>
  remove_quotes() |>
  assign_NL_to_NUTS()

# Ensure that each postcode has only 1 unique NUTS3
check_nl_mapper <- mutate(nl_mapper, count = n(), .by = c("CODE"))
stopifnot(nrow(filter(check_nl_mapper, count > 1)) == 0.0)

de_mapper <- "data-raw/NUTS_postcode/pc2024_DE_NUTS-2024_v1.0.csv" |>
  read_delim(show_col_types = FALSE, delim = ";") |>
  remove_quotes()

at_mapper <- "data-raw/NUTS_postcode/pc2024_AT_NUTS-2024_v1.0.csv" |>
  read_delim(show_col_types = FALSE, delim = ";") |>
  remove_quotes()

es_mapper <- "data-raw/NUTS_postcode/pc2024_ES_NUTS-2024_v1.0.csv" |>
  read_delim(show_col_types = FALSE, delim = ";") |>
  remove_quotes()

fr_mapper <- "data-raw/NUTS_postcode/pc2024_FR_NUTS-2024_v1.0.csv" |>
  read_delim(show_col_types = FALSE, delim = ";") |>
  remove_quotes()

nuts_all <- rbind(nl_mapper, de_mapper, at_mapper, es_mapper, fr_mapper) |>
  rename("geo" = NUTS3, "postcode" = CODE) |>

usethis::use_data(nuts_all, internal = TRUE, overwrite = TRUE)
