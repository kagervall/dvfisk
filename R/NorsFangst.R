#####}
# This file contains the functions to access the NorsFangst API.
#####



#' Return counties (län) known in the NORS database
#'
#' @returns
#' A vector of type character containing names of counties (län) known in the NORS database
#' @export
#'
#' @family NorsFangst API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/national-register-of-survey-test-fishing-nors/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' counties <- nors_fangst_lan()
#' counties
nors_fangst_lan <- function() {
  req <- .dvfisk_endpoint("NorsFangst", "lan")
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Get the municipalities (kommun) in Sweden known in the NORS database
#'
#' This function returns municipalities (kommun) in  a county in Sweden.
#'
#' @param lan character string with the name of a county (län) in Sweden
#'
#' @returns
#' A list of municipalities (kommun) in specified county (län).
#' @export
#'
#' @family NorsFangst API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/national-register-of-survey-test-fishing-nors/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' nors_fangst_huvudavrinningsomraden()
#'
nors_fangst_kommuner <- function(lan) {
  if (missing(lan)) {
    stop("parameter lan is required")
  }
  req <- .dvfisk_endpoint("NorsFangst", "kommuner") |>
    httr2::req_url_query(lan = lan)
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
#' @param lan character string with the name of a county (län) in Sweden
#' @param kommun character string with the name of a municipality in county (lan) in Sweden
#' @param vatten character string with the name a lake (vatten) in Sweden
#'
#' @returns
#' A data frame with survey  data. There are 13 columns in the data frame
#' consult NORS-documentation.
#' @export
#'
#' @family NorsFangst API functions
#'
#' @seealso Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/national-register-of-survey-test-fishing-nors/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' # Get all data from municipality "Hylte" in county "Hallands Län".
#' data <- nors_fangst_rapport(lan = "Hallands Län", kommun = "Hylte")
#' head(data)
#' dim(data)
nors_fangst_rapport <- function(lan, kommun = NULL, vatten = NULL) {
   if (missing(lan)) {
     stop("parameter lan is required")
   }
  req <- .dvfisk_endpoint("NorsFangst", "rapport") |>
    httr2::req_url_query(lan = lan)

  # if (!is.null(Lan)) {
  #   req <- req |>
  #     httr2::req_url_query(Lan = Lan)
  # }
  if (!is.null(kommun)) {
    req <- req |>
      httr2::req_url_query(kommun = kommun)
  }
  if (!is.null(vatten)) {
    req <- req |>
      httr2::req_url_query(vatten = vatten)
  }


  body <- .dvfisk_get_body(req)
  return(body)
}

