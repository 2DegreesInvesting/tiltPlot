# NUTS3 to postcodes file
# Source from European Commission: https://gisco-services.ec.europa.eu/tercet/flat-files
nuts_de <- vroom(here("data-raw/nuts_data/nuts_de.tsv"))

colnames(nuts_de) <- c("geo", "postcode")

usethis::use_data(nuts_de, internal = TRUE, overwrite = TRUE)
