#####
# This file contains the functions to access the KulIndivid API.
#####


#' Return counties (län) known in the KUL database
#'
#' @returns
#' A vector of type character containing names of counties (län) known in the KUL database
#' @export
#'
#' @family KulIndivid API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-coastal-fish-kul/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' counties <- kul_individ_lan()
#' counties
kul_individ_lan <- function() {
  req <- .dvfisk_endpoint("KulIndivid", "lan")
  body <- .dvfisk_get_body(req)
  return(body)
}


#' Return sites (lokaler) in a county known in the KUL database
#'
#' @param lan character, name of the county (län) to get sites (lokaler) for
#'
#' @returns
#' A data.frame with columns `id` and `name` the sites (lokaler) in the county (län)
#' @export
#'
#' @family KulIndivid API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-coastal-fish-kul/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' kul_individ_lokaler("Blekinge län")
#
kul_individ_lokaler <- function(lan) {
  req <- .dvfisk_endpoint("KulIndivid", "lokaler") |>
    httr2::req_url_query(lan = lan)
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Return the types of surveys available for the site specified by `lan` and `lokalId`
#'
#' @param lan character, name of the county (län) where  site (lokalId) is located
#' @param lokalId integer, id of the site (lokalId) to get types of surveys for
#'
#' @returns
#' A vector of characters with the types of surveys available for the site (lokalId)
#' @export
#'
#' @family KulIndivid API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-coastal-fish-kul/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' kul_individ_fisken("Blekinge län", 204)
#'
kul_individ_fisken <- function(lan, lokalId) {
  req <- .dvfisk_endpoint("KulIndivid", "fisken") |>
    httr2::req_url_query(lan = lan, lokalId = lokalId)
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Return the years when survey data available for the site specified by `lan`, `lokalId` and `fiske`
#'
#' @param lan character, name of the county (län) where  site (lokalId) is located
#' @param lokalId character, id of the site (lokalId) to get years for
#' @param fiske character, type of survey (fiske) to get years for
#'
#' @returns
#' A vector of integers with the years when survey data available for the site (lokalId)
#' @export
#'
#' @family KulIndivid API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-coastal-fish-kul/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' kul_individ_ar("Blekinge län", 204, "Gåsöfjärden inventering")
#'
kul_individ_ar <- function(lan, lokalId, fiske) {
  req <- .dvfisk_endpoint("KulIndivid", "ar") |>
    httr2::req_url_query(lan = lan, lokalId = lokalId, fiske = fiske)
  body <- .dvfisk_get_body(req)
  return(body)
}

#' Return the survey data for the site specified by `lan`, `lokalId`, `fiske` and `ar`
#'
#' @param lan character, name of the county (län) where  site (lokalId) is located
#' @param lokalId character, id of the site (lokalId) to get data for
#' @param fiske character, type of survey (fiske) to get data for
#' @param ar integer, one or several year (ar) to get data for
#'
#' @returns
#' A data.frame (22 columns) with the survey data for the site (lokalId)
#' @export
#'
#' @family KulIndivid API functions
#'
#' @seealso Description of
#'  \url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-coastal-fish-kul/},
#'  description of API \url{https://dvfisk.slu.se/swagger/index.html}
#'
#' @examples
#' # This example will access the Internet to get the data and will not work offline
#' results <- kul_individ_rapport("Blekinge län", 204, "Gåsöfjärden inventering", ar = 2019)
#' dim(results)
kul_individ_rapport <- function(lan, lokalId, fiske, ar) {
  req <- .dvfisk_endpoint("KulIndivid", "rapport") |>
    httr2::req_url_query(lan = lan, lokalId = lokalId,
                         fiske = fiske, ar = ar, .multi = "explode")
  body <- .dvfisk_get_body(req)
  return(body)
}
