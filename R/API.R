library(httr2)
library(jsonlite)

# Get the data
sers_data_vix_rapport <- function(
    haroNr, startyear, endyear,
    cols = c("harO_NR", "huvudavrinningsområde", "vattendrag", "fiskedatum", "lokal",
             "xkoorlok", "ykoorlok",  "wgS84_Dec_N", "wgS84_Dec_E", "lax0", "lax",
             "öring0", "öring", "hoh", "syfte")) {
  url <- "https://dvfisk.slu.se/api/V1/sers/data-vix/rapport"
  
  req <- request(url) |>
    req_url_query(haroNr = haroNr,
                  startdatum = sprintf("%s-01-01", startyear),
                  slutdatum = sprintf("%s-12-31", endyear))
  resp <- httr2::req_perform(req)
  body <- httr2::resp_body_json(resp, simplifyVector = TRUE) |>
    dplyr::select(all_of(cols))
  return(body)
}


req <- httr2::request(url) |>
  httr2::req_url_query(haroNr = 24000, startdatum = "2021-01-01", slutdatum = "2021-12-31")


body <- httr2::resp_body_json(resp, simplifyVector = TRUE)
