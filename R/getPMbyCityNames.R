#' get city PM2.5 level
#'
#' @description get PM2.5 level at a list of cities
#' @param citynames a vector of city names to be queryed
#' @return data frame containing location, time and PM2.5 level
#' @importFrom jsonlite fromJSON
#' @export
#' @examples
#' \dontshow{setenvironment()}
#' getPMbyCityNames("newyork")
getPMbyCityNames <- function(citynames){
  baseURL = get(".baseURL", envir = cacheEnv)
  atoken = get(".atoken", envir = cacheEnv)
  mydata <- jsonlite::fromJSON(sprintf("%s/feed/%s/?token=%s", baseURL, citynames, atoken), flatten=TRUE)
  if(mydata$status != "ok"){
    stop(mydata$data)
  }

  mycityfullname <- mydata$data$city$name
  mygeo <- mydata$data$city$geo
  mylat <- as.numeric(mygeo[1])
  mylon <- as.numeric(mygeo[2])
  mypm25 <- mydata$data$iaqi$pm25$v
  mytime <- as.character(mydata$data$time$s)
  mytz <- mydata$data$time$tz
  mytz <- paste0(substr(mytz, 1,3), substr(mytz, 5, 6))
  myUTCtime <- strptime(paste0(mytime, mytz, sep=" "), format="%Y-%m-%d %H:%M:%S %z", tz = "UTC")
  rslt <- data.frame(city = mycityfullname, latitude = mylat, longitude = mylon, pm25 = mypm25, localtime = mytime, localtimezone = mytz, UTCtime = as.character(myUTCtime), stringsAsFactors = FALSE)
}
