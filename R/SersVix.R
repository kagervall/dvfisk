#####}
# This file contains the functions to access the SersVix API.
#####


#' Return counties (län) known in the SERS database
#'
#' @returns
#' A vector of type character containing names of counties (län) known in the SERS database
#' @export
#'
#' @family SersVix API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-testfishing-in-streams/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' counties <- sers_vix_lan()
#' counties
sers_vix_lan <- function() {
  req <- .dvfisk_endpoint("SersVix", "lan")
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Get the municipalities (kommuner) in a county (län)
#'
#' This function returns the municipalities (kommuner) in a county (län) in Sweden.
#' The parameter `lan` must be a valid county (län) in Sweden.
#'
#' @param lan A character string with the name of a county (län) in Sweden
#'
#'
#' @returns
#' A vector of type character containing names of municipalities (kommuner) in the county (län)
#' @export
#'
#' @family SersVix API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-testfishing-in-streams/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' kommuner <- sers_vix_kommuner("Västra Götaland")
#' kommuner
sers_vix_kommuner <- function(lan) {
  req <- .dvfisk_endpoint("SersVix", "kommuner") |>
      httr2::req_url_query(lan = lan)
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Get the main drainage areas (huvudavrinningsområden) in Sweden known in the SERS database
#'
#' This function returns the main drainage areas (huvudavrinningsområden) in Sweden.
#'
#' @returns
#' A data frame with columns `haroNr` and `huvudavrinningsomrade` with the main
#' drainage areas (huvudavrinningsområden) in Sweden
#' @export
#'
#' @family SersVix API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-testfishing-in-streams/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' huvudavrinningsomraden <- sers_vix_huvudavrinningsomraden()
#' head(huvudavrinningsomraden)
#'
sers_vix_huvudavrinningsomraden <- function() {
  req <- .dvfisk_endpoint("SersVix", "huvudavrinningsomraden")
#  resp <- httr2::req_perform(req)
  body <- .dvfisk_get_body(req)
  return(body)
}


#' Get electrofishing data from the SERS API
#'
#' This function returns electrofishing data from the SERS API. You can filter the data by
#' county (lan), municipality (kommun), main drainage area (haroNr), start date (startdatum)
#' and end date (slutdatum). You must provide at least one of the parameters. The function
#' does not check if the parameters are valid and it is possible to give combinations
#' that does not make sense, e.g. a `haroNr` and `lan` that does not intersect.
#' It is also possible send requests that return a lot of data, so be careful.
#'
#' @param lan character string with the name of a county (län) in Sweden
#' @param kommun character string with the name of a municipality (kommun) in Sweden
#' @param haroNr integer with the main drainage area (huvudavrinningsområde) number
#' @param startdatum character string with the start date in the format "YYYY-MM-DD"
#' @param slutdatum character string with the end date in the format "YYYY-MM-DD"
#'
#' @returns
#' A data frame with the electrofishing data. There are 244 columns in the data frame
#' consult SERS-documentation.
#' @export
#'
#' @family SersVix API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-testfishing-in-streams/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' # Get all data from the main drainage area 86000 (Mörrumsån) in 2021
#' data <- sers_vix_rapport(haroNr = 86000, startdatum = "2021-01-01", slutdatum = "2021-12-31")
#' head(data)
#' dim(data)
sers_vix_rapport <- function(lan = NULL, kommun = NULL, haroNr = NULL,
                                  startdatum = NULL, slutdatum = NULL) {
  req <- .dvfisk_endpoint("SersVix", "rapport")
  if (is.null(lan) & is.null(kommun) & is.null(haroNr) &
      is.null(startdatum) & is.null(slutdatum)) {
    stop("You must provide at least one of the following parameters: lan, kommun, haroNr, startdatum, slutdatum")
  }

  if (!is.null(lan)) {
    req <- req |>
      httr2::req_url_query(lan = lan)
  }
  if (!is.null(kommun)) {
    req <- req |>
      httr2::req_url_query(kommun = kommun)
  }
  if (!is.null(haroNr)) {
    req <- req |>
      httr2::req_url_query(haroNr = haroNr)
  }
  if (!is.null(startdatum)) {
    req <- req |>
      httr2::req_url_query(startdatum = startdatum)
  }
  if (!is.null(slutdatum)) {
    req <- req |>
      httr2::req_url_query(slutdatum = slutdatum)
  }

  body <- .dvfisk_get_body(req)
  return(body)
}

