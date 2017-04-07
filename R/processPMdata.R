#' process json data
#'
#' @description process json data from \url{http://www.aqicn.org} 
#' @param mydata a list
#' @return a tibble
#' @importFrom tibble tibble
#' @keywords internal
processPMdata <- function(mydata){
  if(mydata$status != "ok"){
    stop(mydata$data)
  }

  if(is.null(mydata$data)){
    message("empty data")
    return(NA)
  }

  #browser()
  mylat <- NA
  mylon <-NA
  mycityfullname <- mydata$data$city$name
  if("geo" %in% names(mydata$data$city) && !is.null(mydata$data$city$geo)){
    mygeo <- mydata$data$city$geo
    mylat <- as.numeric(mygeo[1])
    mylon <- as.numeric(mygeo[2])
    if(mylat < -90 || mylat > 90 || mylon < -180 || mylon > 180){
      message("latitude and longitude out of range. this may be a server side error. swap latitude and longitude to try again")
      tmp = mylat
      mylat = mylon
      mylon = tmp
    }
  }

  mypm25 <- NA
  apl <- NA
  if('pm25' %in% names(mydata$data$iaqi)){
    mypm25 <- as.numeric(mydata$data$iaqi$pm25$v)
    apldesc <- getglobalPM25Options()$apl_description
    apl <- if(mypm25>300L) apldesc[6L] else if(mypm25>200L) apldesc[5L] else if(mypm25>150L) apldesc[4L] else if(mypm25>100L) apldesc[3L] else if(mypm25>50) apldesc[2L]  else apldesc[1L]
  }

  myid <- as.numeric(mydata$data$idx)
  mytime <- as.character(mydata$data$time$s)
  mytz <- mydata$data$time$tz
  mytz <- paste0(substr(mytz, 1,3), substr(mytz, 5, 6))
  myUTCtime <- strptime(paste0(mytime, mytz, sep=" "), format="%Y-%m-%d %H:%M:%S %z", tz = "UTC")

  tibble::tibble(stationid = myid, city = mycityfullname, lat = mylat, lon = mylon, pm25 = mypm25, APL = apl, localtime = mytime, localtimezone = mytz, UTCtime = as.character(myUTCtime))
}
