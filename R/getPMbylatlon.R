#' get real-time PM2.5 level near a latitude and longitude
#'
#' @description query real-time PM2.5 level at the station closest to a latitude and longitude. return a tibble containing Pm2.5 level, station location, local and UTC time
#' @param lat latitude
#' @param lon longitude
#' @return tibble
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
#' @importFrom dplyr select
#' @export
#' @examples
#' getPMbylatlon(37.774929, -122.419416)
getPMbylatlon <- function(lat, lon){
  if(missing(lat) || missing(lon)){
    stop("missing argument")
  }

  if(lat < -90 || lat > 90 || lon < -180 || lon > 180){
    stop("input latitude and longitude out of range")
  }

  baseURL = getglobalPM25Options()$baseURL
  atoken = getglobalPM25Options()$token
  mydata <- jsonlite::fromJSON(sprintf("%s/feed/geo:%f;%f/?token=%s", baseURL, lat, lon, atoken), flatten=TRUE)
  rslt <- processPMdata(mydata)
  rslt <- rslt %>% dplyr::select(city, localtime, APL, pm25, lat, lon, localtimezone)
  tibble::as_tibble(rslt)
}
