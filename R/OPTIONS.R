##
## This file contains code needed to provide default options for the package.
##

# Variable, global to package's namespace.
# This function is not exported to user space and does not need to be documented.
OPTIONS <- settings::options_manager(
  SersVix_url = "https://dvfisk.slu.se/api/V1/sers/data-vix")



# User function that gets exported:

#' Set or get options for the `dvfisk` package
#'
#' @param ... Option names to retrieve option values or \code{[key]=[value]} pairs to set options.
#'
#' @section Supported options:
#' Supported keys:
#' \itemize{
#'  \item{\code{SersVix_url} Base URL for the API (Default: "https://dvfisk.slu.se/api/V1/sers/data-vix")}
#' }
#'
#' @examples
#' # Show default
#' dvfisk_options()
#'
#' dvfisk_options(SersVix_url = "https://testing.slu.se/api/V1/sers/data-vix") # Change another server
#' dvfisk_options()$SersVix_url # Show the new value
#' settings::reset(dvfisk_options) # Reset to defaults
#'
#' @export
dvfisk_options <- function(...){
  # protect against the use of reserved words.
  settings::stop_if_reserved(...)
  OPTIONS(...)
}
