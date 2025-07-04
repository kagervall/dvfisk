#####
# This file contains internal functions for package dvfisk.
#####


#' Internal function to get the base request for the SersVix API
#'
#' @param what one of SersVix and SersIndivid
#' @param endpoint name of the endpoint (must be defined for the API named by `what`)
#'
#' @returns
#' A httr2 request object
#'
#' @keywords internal
.dvfisk_endpoint <-function(what, endpoint) {
  known_apis <- c("KulFangst", "KulIndivid", "KulLangd",
                  "NorsAggregerad", "NorsFangst", "NorsIndivid",
                  "SersVix", "SersAggregerad")
  if (!what %in% known_apis) {
    stop("Internal error in package dvfisk 'what' parameter. Must be one of: ", paste(known_apis, collapse = ", "))
  }
  url_opt <- paste0(what, "_url")
  api_url <- dvfisk_options()[[url_opt]]

  endpoint_opt <- paste0(what, "_endpoints")
  endpoints <- dvfisk_options()[[endpoint_opt]]
  if (!endpoint %in% endpoints) {
    stop("Internal error in package dvfisk 'endpoint' parameter. Must be one of: ", paste(endpoints, collapse = ", "))
  }
  url <- paste0(api_url, "/", endpoint)
  req <- httr2::request(url)
  return(req)
}

#' Internal function that returns the body of a request
#'
#' @param req A httr2 request object
#'
#' @returns a data.frame with the body of the request
#' @keywords internal
#'
.dvfisk_get_body <- function(req) {
  resp <- httr2::req_perform(req)
#  if (requireNamespace("jsonlite", quietly = TRUE)) {
    body <- httr2::resp_body_json(resp, simplifyVector = TRUE)
#  } else {
#    body <- NULL
#  }
  return(body)
}
