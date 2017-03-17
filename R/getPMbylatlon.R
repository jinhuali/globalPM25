#' get PM2.5 level near a latitude and longitude
#'
#' @description query PM2.5 level at the station closest to a latitude and longitude. return a tibble containing Pm2.5 level, station location, local and UTC time
#' @param lat latitude
#' @param lon longitude
#' @return tibble
#' @importFrom jsonlite fromJSON
#' @export
#' @examples
#' \dontshow{setenvironment()}
#' getPMbylatlon(37.774929, -122.419416)
getPMbylatlon <- function(lat, lon){
  baseURL = get(".baseURL", envir = cacheEnv)
  atoken = get(".atoken", envir = cacheEnv)
  mydata <- jsonlite::fromJSON(sprintf("%s/feed/geo:%f;%f/?token=%s", baseURL, lat, lon, atoken), flatten=TRUE)
  processPMdata(mydata)
}
