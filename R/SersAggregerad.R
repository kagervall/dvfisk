#####}
# This file contains the functions to access the SersAggregerad API.
#####



#' Return counties (län) known in the SERS database
#'
#' @returns
#' A vector of type character containing names of counties (län) known in the SERS database
#' @export
#'
#' @family SersAggregerad API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-testfishing-in-streams/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' counties <- sers_aggregerad_lan()
#' counties
sers_aggregerad_lan <- function() {
  req <- .dvfisk_endpoint("SersAggregerad", "lan")
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
#' @family Sersaggregerad API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-testfishing-in-streams/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' huvudavrinningsomraden <- sers_aggregerad_huvudavrinningsomraden()
#' head(huvudavrinningsomraden)
#'
sers_aggregerad_huvudavrinningsomraden <- function() {
  req <- .dvfisk_endpoint("SersAggregerad", "huvudavrinningsomraden")
  #  resp <- httr2::req_perform(req)
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Get electrofishing data from the SERS API
#'
#' This function returns electrofishing data from the SERS API. You can filter the data by
#' county (lan), municipality (kommun), main drainage area (haroNr). The function
#' does not check if the parameters are valid and it is possible to give combinations
#' that does not make sense, e.g. a `haroNr` and `Lan` that does not intersect.
#' It is also possible send requests that return a lot of data, so be careful.
#'
#' @param Lan character string with the name of a county (län) in Sweden
#' @param haroNr integer with the main drainage area (huvudavrinningsområde) number
#' @param Vattendrag character string with the name a river (vattendrag) in Sweden
#'
#' @returns
#' A data frame with the electrofishing data. There are 30 columns in the data frame
#' consult SERS-documentation.
#' @export
#'
#' @family SersAggregerad API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-testfishing-in-streams/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' # Get all data from the main drainage area 24000 (Rickleån).
#' data <- sers_aggregerad_rapport(haroNr = 24000)
#' head(data)
#' dim(data)
sers_aggregerad_rapport <- function(Lan = NULL, haroNr = NULL, Vattendrag = NULL) {
  req <- .dvfisk_endpoint("SersAggregerad", "rapport")
  # if (is.null(lan) & is.null(kommun) & is.null(haroNr) &
  #     is.null(startdatum) & is.null(slutdatum)) {
  #   stop("You must provide at least one of the following parameters: lan, kommun, haroNr, Vattendrag")
  # }

  if (!is.null(Lan)) {
    req <- req |>
      httr2::req_url_query(Lan = Lan)
  }
  if (!is.null(haroNr)) {
    req <- req |>
      httr2::req_url_query(haroNr = haroNr)
  }
  if (!is.null(Vattendrag)) {
    req <- req |>
      httr2::req_url_query(Vattendrag = Vattendrag)
  }


  body <- .dvfisk_get_body(req)
  return(body)
}

