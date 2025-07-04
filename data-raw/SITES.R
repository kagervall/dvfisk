#####
## Generate sers_sites data for SERS from an Excel file provided by SLU.
## Also generate documentation from the same file.
#####
#sites_url <- "https://www.slu.se/globalassets/ew/org/inst/aqua/externwebb/databaser/elprovfiskedatabasen/lista-elfiskelokaler-svenskt-elfiskeregister-220503.xlsx"
#sites_tmp <- tempfile(fileext = ".xlsx")
#sites_tmp <- "data-raw/sites-dl.xlsx"
sites_tmp <- "data-raw/lista-elfiskelokaler-svenskt-elfiskeregister-220503.xlsx"
#utils::download.file(url = sites_url, destfile = sites_tmp)
sers_sites <- readxl::read_excel(path = sites_tmp, sheet = "Lokaluppgifter Elfiskelokaler")
names(sers_sites) <- tolower(names(sers_sites))
sites_documentation <- readxl::read_excel(path = sites_tmp,
                                          sheet = "Information",
                                          skip = 5)
sites_documentation$Rubrik <- tolower(sites_documentation$Rubrik)


sers_sites_sf <- sf::st_as_sf(sers_sites[c("xkoorlok", "ykoorlok", "ddlong","ddlat")],
                         coords = c("ddlong","ddlat"), crs = 4326)
usethis::use_data(sers_sites, overwrite = TRUE)
usethis::use_data(sers_sites_sf, overwrite = TRUE)
## Create documentation
sites_doc <- "R/SITES_documentation.R"
cat("# Generated by data-raw/SITES.R. DO NOT EDIT!!
#' dvfisk::sers_sites A data frame with information about electrofishing sites in SERS
#'
#' @description
#' Data from the Swedish Electrofishing Register (SERS) containing information about electrofishing sites.
#' The documentation is based on the Excel file provided by SLU and avaliable in Swedish only.
#'
#' Data frame `dvfisk::sers_sites` is a list of sites defined in SERS  with 23
#' variables described below.
#'
#' `dvfisk::sers_sites_sf` is a simple feature points object for the sites in `dvfisk::sers_sites`
#' use `dplyr::left_join(sers_sites, sers_sites_sf, by = dplyr::join_by(XKOORLOK, YKOORLOK))`
#' to join the data frames. You might want to use `library(sf)` in your script to
#' work with the simple feature object.
#'
#' @format Columns in `dvfisk::sers_sites` are:
#' \\describe{
", file = sites_doc)

cat(paste0("#'   \\item{", sites_documentation$Rubrik, "}{", sites_documentation$Beskrivning, "}"),
    file = sites_doc, sep = "\n", append = TRUE)

cat("#' }
#' @source
#'    Swedish Electrofishing Register (SERS)
#'    \\url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-testfishing-in-streams/}
\"sers_sites\"
#'
#' @family Datasets
#' @rdname sers_sites
\"sers_sites_sf\"
",  file = sites_doc, append = TRUE)
devtools::document()
