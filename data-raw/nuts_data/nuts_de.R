# NUTS3 to zip file
# Source from European Commission: https://gisco-services.ec.europa.eu/tercet/flat-files
nuts_de <- read_csv2(
  here("data-raw/nuts_data/nuts_de.csv"),
  col_types = cols(
    NUTS3 = col_character(), # Specify the data type for the "geo" column
    CODE = col_integer() # Specify the data type for the "postcode" column
  ),
  quote = "'"
)

colnames(nuts_de) <- c("geo", "postcode")

usethis::use_data(nuts_de, internal = TRUE, overwrite = TRUE)
