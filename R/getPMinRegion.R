#' get PM2.5 within a city region
#'
#' @description get PM2.5 levels of all the stations within a city region (default distance 50 miles). return local time, station location and PM2.5 level
#' @param cityname character
#' @param d distance
#' @return a tibble
#' @importFrom tibble as_tibble
#' @export
#' @examples
#' \dontshow{setenvironment()}
#' getPMinRegion("newyork")
#' getPMinRegion("newyork", 200)

getPMinRegion <- function(cityname, d = 50){
  mycitypm <- getPMbyCityNames(cityname)
  lat <- mycitypm$latitude
  lon <- mycitypm$longitude
  localtime <- mycitypm$localtime
  #localtimezone <- mycitypm$localtimezone
  #UTCtime <- mycitypm$UTCtime
  dlat = d/68.69/2 #miles
  dlon = d/(69.17*cos(lat))/2
  dlat = abs(dlat)
  dlon = abs(dlon)
  geobound = c(lat-dlat, lon-dlon, lat+dlat, lon+dlon)

  baseURL = get(".baseURL", envir = cacheEnv)
  atoken = get(".atoken", envir = cacheEnv)
  mydata <- jsonlite::fromJSON(sprintf("%s/map/bounds/?latlng=%f,%f,%f,%f&token=%s", baseURL, geobound[1], geobound[2], geobound[3], geobound[4], atoken), flatten=TRUE)
  if(mydata$status != "ok"){
    stop(mydata$data)
  }
  mydata <- mydata$data
  mydata$aqi[mydata$aqi == "-"] = NA
  tibble::as_tibble(cbind("localtime" = localtime, mydata[,c("lat", "lon", "aqi")]))
}
