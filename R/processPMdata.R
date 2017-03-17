#' process json data
#'
#' @description process json data from \url{aqicn.org} API
#' @param mydata a list
#' @return a tibble
#' @importFrom tibble tibble
#' @keywords internal
processPMdata <- function(mydata){
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
  tibble::tibble(city = mycityfullname, latitude = mylat, longitude = mylon, pm25 = mypm25, localtime = mytime, localtimezone = mytz, UTCtime = as.character(myUTCtime))
}
