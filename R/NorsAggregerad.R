#####}
# This file contains the functions to access the NorsAggregerad API.
#####



#' Return counties (län) known in the NORS database
#'
#' @returns
#' A vector of type character containing names of counties (län) known in the NORS database
#' @export
#'
#' @family NorsAggregerad API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/national-register-of-survey-test-fishing-nors/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' counties <- nors_aggregerad_lan()
#' counties
nors_aggregerad_lan <- function() {
  req <- .dvfisk_endpoint("NorsAggregerad", "lan")
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Get the main drainage areas (huvudavrinningsområden) in Sweden known in the NORS database
#'
#' This function returns the main drainage areas (huvudavrinningsområden) in Sweden.
#'
#' @returns
#' A data frame with columns `haroNr` and `huvudavrinningsomrade` with the main
#' drainage areas (huvudavrinningsområden) in Sweden
#' @export
#'
#' @family NorsAggregerad API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/national-register-of-survey-test-fishing-nors/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' huvudavrinningsomraden <- nors_aggregerad_huvudavrinningsomraden()
#' head(huvudavrinningsomraden)
#'
nors_aggregerad_huvudavrinningsomraden <- function() {
  req <- .dvfisk_endpoint("NorsAggregerad", "huvudavrinningsomraden")
  #  resp <- httr2::req_perform(req)
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Get aggregated data from the Nors API
#'
#' This function returns electrofishing data from the Nors API. You can filter the data by
#' county (Lan), main drainage area (HaroNr) or lake (Sjo). The function
#' does not check if the parameters are valid and it is possible to give combinations
#' that does not make sense, e.g. a `haroNr` and `Lan` that does not intersect.
#' It is also possible send requests that return a lot of data, so be careful.
#'
#' @param Lan character string with the name of a county (län) in Sweden
#' @param HaroNr integer with the main drainage area (huvudavrinningsområde) number
#' @param Sjo character string with the name a lake (sjö) in Sweden
#'
#' @returns
#' A data frame with the electrofishing data. There are 44 columns in the data frame
#' consult Nors-documentation.
#' @export
#'
#' @family NorsAggregerad API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/national-register-of-survey-test-fishing-nors/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' # Get all data from the main drainage area 24000 (Rickleån).
#' data <- nors_aggregerad_rapport(HaroNr = 24000)
#' head(data)
#' dim(data)
nors_aggregerad_rapport <- function(Lan = NULL, HaroNr = NULL, Sjo = NULL) {
  req <- .dvfisk_endpoint("NorsAggregerad", "rapport")
  # if (is.null(lan) & is.null(kommun) & is.null(haroNr) &
  #     is.null(startdatum) & is.null(slutdatum)) {
  #   stop("You must provide at least one of the following parameters: lan, kommun, haroNr, Vattendrag")
  # }

  if (!is.null(Lan)) {
    req <- req |>
      httr2::req_url_query(Lan = Lan)
  }
  if (!is.null(HaroNr)) {
    req <- req |>
      httr2::req_url_query(HaroNr = HaroNr)
  }
  if (!is.null(Sjo)) {
    req <- req |>
      httr2::req_url_query(Sjo = Sjo)
  }


  body <- .dvfisk_get_body(req)
  return(body)
}

