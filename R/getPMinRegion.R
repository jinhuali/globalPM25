#' get PM2.5 within a city region
#'
#' @description get PM2.5 levels of all the stations within a city region (default \code{cityname} "san jose" and \code{distance} 50 miles). return local time, station location and PM2.5 level. The results are sorted by PM2.5 levels
#' @param cityname character
#' @param distance double
#' @return a tibble
#' @importFrom tibble as_tibble
#' @importFrom dplyr %>% arrange desc
#' @export
#' @examples
#' getPMinRegion("san jose")
#' getPMinRegion("san jose", 200)

getPMinRegion <- function(cityname = "san jose", distance = 50){
  if(distance <= 0){
    stop("range must be greater than zero")
  }

  mycitypm <- getPMbyCityNames(cityname)
  lat <- mycitypm$latitude
  lon <- mycitypm$longitude
  localtime <- mycitypm$localtime
  #localtimezone <- mycitypm$localtimezone
  #UTCtime <- mycitypm$UTCtime
  dlat = distance/68.69/2 #miles
  dlon = distance/(69.17*cos(lat))/2
  dlat = abs(dlat)
  dlon = abs(dlon)
  geobound = c(lat-dlat, lon-dlon, lat+dlat, lon+dlon)

  baseURL = getglobalPM25Options()$baseURL
  atoken = getglobalPM25Options()$token
  mydata <- jsonlite::fromJSON(sprintf("%s/map/bounds/?latlng=%f,%f,%f,%f&token=%s", baseURL, geobound[1], geobound[2], geobound[3], geobound[4], atoken), flatten=TRUE)
  if(mydata$status != "ok"){
    stop(mydata$data)
  }else if(length(mydata$data) == 0){
    stop("Empty data")
  }
  mydata <- mydata$data
  mydata$aqi[mydata$aqi == "-"] = NA
  rslt <- cbind("localtime" = localtime, mydata)
  rslt <- rslt %>% dplyr::select(localtime, lat, lon, aqi) %>% dplyr::arrange(desc(aqi))
  names(rslt)[4] <- "pm25"
  tibble::as_tibble(rslt)
}
