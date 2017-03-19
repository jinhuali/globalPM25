##
## Global variable for package
##

globalPM25.options <- list(token = "c37e84c905b04779aadbd46685abebbc9089b243",
                           baseURL = "http://api.waqi.info",
                           apl_description = c("Good", "Moderate", "Unhealthy for sensitive groups", "Unhealthy", "Very Unhealthy", "Hazardous"),
                           worldcities = c('mumbai', 'tokyo', 'seoul', 'delhi', 'jakarta', 'paris', 'moscow', 'mexico city', 'san jose',
                                            'Shanghai', 'beijing', 'hongkong', 'istanbul', 'london', 'taipei', 'bangkok', 'chicago', 'newyork',
                                            'manila', 'buenos aires', 'seattle', 'dubai', 'sydney', 'melbourne',
                                            'singapore', 'madrid', 'bangalore', 'chennai', 'kolkata', 'osaka', 'bangalore',
                                            'kuala lumpur', 'milan', 'berlin', 'Tel Aviv', 'lisbon', 'Vancouver', 'toronto', 'Munich',
                                            'Copenhagen'))

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
    assignInMyNamespace("globalPM25.options", list(token = "c37e84c905b04779aadbd46685abebbc9089b243",
                                                   baseURL = "http://api.waqi.info",
                                                   apl_description = c("Good", "Moderate", "Unhealthy for sensitive groups", "Unhealthy", "Very Unhealthy", "Hazardous"),
                                                   worldcities = c('mumbai', 'tokyo', 'seoul', 'delhi', 'jakarta', 'paris', 'moscow', 'mexico city', 'san jose',
                                                                    'Shanghai', 'beijing', 'hongkong', 'istanbul', 'london', 'taipei', 'bangkok', 'chicago', 'newyork',
                                                                    'manila', 'buenos aires', 'seattle', 'dubai', 'sydney', 'melbourne',
                                                                    'singapore', 'madrid', 'bangalore', 'chennai', 'kolkata', 'osaka', 'bangalore',
                                                                    'kuala lumpur', 'milan', 'berlin', 'Tel Aviv', 'lisbon', 'Vancouver', 'toronto', 'Munich',
                                                                    'Copenhagen')))

    globalPM25.options
}

#' Set the token
#'
#' @description request your peronal token from \url{http://aqicn.org/data-platform/token/#/}
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


#' Set the root url
#'
#' @param baseurl the value to assign
#' @return the changed options
#' @importFrom utils assignInMyNamespace
#' @examples
#' \dontrun{
#'   setbaseurl("http://api.waqi.info")
#' }
#' @keywords internal
#'
setbaseurl <- function(baseurl) {
  globalPM25.options <- getglobalPM25Options()
  globalPM25.options$baseurl <- baseurl
  assignInMyNamespace("globalPM25.options", globalPM25.options)
  globalPM25.options
}

#' Set the city names to be queryed
#'
#' @param citynames character vector of city names
#' @return the changed options
#' @importFrom utils assignInMyNamespace
#' @examples
#' \dontrun{
#'   setworldcities(c("tokyo", "beijing"))
#' }

setworldcities <- function(citynames) {
  globalPM25.options <- getglobalPM25Options()
  globalPM25.options$worldcities <- citynames
  assignInMyNamespace("globalPM25.options", globalPM25.options)
  globalPM25.options
}


