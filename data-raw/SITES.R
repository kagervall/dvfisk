utils::download.file(
  "https://www.slu.se/globalassets/ew/org/inst/aqua/externwebb/databaser/elprovfiskedatabasen/lista-elfiskelokaler-svenskt-elfiskeregister-220503.xlsx",
  destfile = "data-raw/sites.xlsx")
sites <- readxl::read_excel("data-raw/sites.xlsx", sheet = "Lokaluppgifter Elfiskelokaler")
sites_sf <- sf::st_as_sf(sites, coords = c("DDLONG","DDLAT"), crs = 4326)

sites_documentation <- readxl::read_excel("data-raw/sites.xlsx",
                                          sheet = "Information",
                                          skip = 5)
