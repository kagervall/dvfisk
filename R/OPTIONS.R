##
## This file contains code needed to provide default options for the package.
##

# Variable, global to package's namespace.
# This function is not exported to user space and does not need to be documented.
OPTIONS <- settings::options_manager(
  base_url = "https://dvfisk.slu.se/api/V1/sers/data-vix")



# User function that gets exported:

#' Set or get options for the `sersapi` package
#'
#' @param ... Option names to retrieve option values or \code{[key]=[value]} pairs to set options.
#'
#' @section Supported options:
#' Supported keys:
#' \itemize{
#'  \item{\code{base_url} Base URL for the API (Default: "https://dvfisk.slu.se/api/V1/sers/data-vix")}
#' }
#'
#' @examples
#' # Show default
#' sersapi_options()
#'
#' sersapi_options(base_url = "https://testing.slu.se/api/V1/sers/data-vix") # Change another server
#' sersapi_options()$base_url # Show the new value
#' settings::reset(sersapi_options) # Reset to defaults
#'
#' @export
sersapi_options <- function(...){
  # protect against the use of reserved words.
  settings::stop_if_reserved(...)
  OPTIONS(...)
}
