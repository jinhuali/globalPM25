##
## Global variable for package
##

globalPM25.options <- list(token = "c37e84c905b04779aadbd46685abebbc9089b243", baseURL = "http://api.waqi.info")

#' Reset the global package variable \code{globalPM25.options}
#'
#' @return the default options
#' @importFrom utils assignInMyNamespace
#' @export
#' @examples
#' \dontrun{
#'   resetOptions()
#' }
#'
resetOptions <- function() {
    assignInMyNamespace("globalPM25.options", list(token = "c37e84c905b04779aadbd46685abebbc9089b243", baseURL = "http://api.waqi.info"))
    globalPM25.options
}

#' Set the token
#'
#' @param token the value to assign
#' @return the changed options
#' @importFrom utils assignInMyNamespace
#' @export
#' @examples
#' \dontrun{
#'   settoken("demo")
#' }
#'
settoken <- function(token) {
    globalPM25.options <- getglobalPM25Options()
    globalPM25.options$token <- token
    assignInMyNamespace("globalPM25.options", globalPM25.options)
    globalPM25.options
}


#' Return package options
#'
#' @return package options
#' @export
#' @examples
#' \dontrun{
#'   getglobalPM25Options()
#' }
#'
getglobalPM25Options <- function() {
   globalPM25.options
}


