#' get real-time PM2.5 within a city region or within a geographic boundary
#'
#' @description get real-time PM2.5 levels of all the stations within a city region (default \code{distance} 50 miles) or geographical bound in the format c(lat1, lon1, lat2, lon2). Return local time, station location and PM2.5 level. The results are sorted by PM2.5 levels
#' @param cityname character
#' @param distance double
#' @param geobound numeric vector of length 4L in the format c(lat1, lon1, lat2, lon2)
#' @return a tibble
#' @importFrom tibble as_tibble
#' @importFrom dplyr %>% arrange desc select
#' @importFrom ggplot2 ggplot aes scale_color_manual geom_point
#' @importFrom stats complete.cases
#' @export
#' @examples
#' \dontrun{getPMinRegion("beijing")} #require personal token
#' \dontrun{getPMinRegion("beijing", 200)}
#' \dontrun{getPMinRegion(geobound = c(38.164368, -122.85501, 37.203647, -121.431634))} #san francisco bay area
getPMinRegion <- function(cityname, distance = 50, geobound = NULL){
  if(!missing(cityname) && distance <= 0){
    stop("range must be greater than zero")
  }

  localtimezone <- NA
  localtime <- NA
  if(!missing(cityname)){
    mycitypm <- getPMbyCityNames(cityname)
    lat <- mycitypm$lat
    lon <- mycitypm$lon
    localtime <- as.character(mycitypm$localtime)
    localtimezone <- as.character(mycitypm$localtimezone)
    #UTCtime <- mycitypm$UTCtime
    dlat = distance/68.69/2 #miles
    dlon = distance/(69.17*cos(lat))/2
    dlat = abs(dlat)
    dlon = abs(dlon)
    geobound = c(lat-dlat, lon-dlon, lat+dlat, lon+dlon)
  }else if(!missing(geobound)){
    if(length(geobound) != 4){
      stop("incorrect geobound input")
    }
    geobound = c(min(geobound[1], geobound[3]), min(geobound[2], geobound[4]), max(geobound[1], geobound[3]), max(geobound[2], geobound[4]))
    cityname = "NA"
    distance = 0
  }else{
    stop("missing argument")
  }
  baseURL = getglobalPM25Options()$baseURL
  atoken = getglobalPM25Options()$token
  mydata <- jsonlite::fromJSON(sprintf("%s/map/bounds/?latlng=%f,%f,%f,%f&token=%s", baseURL, geobound[1], geobound[2], geobound[3], geobound[4], atoken), flatten=TRUE)
  if(mydata$status != "ok"){
    stop(mydata$data)
  }else if(length(mydata$data) == 0L){
    stop("Empty data")
  }

  #browser()
  mydata <- mydata$data
  mydata$aqi[mydata$aqi == "-"] = NA
  rslt <- list()
  rslt <- cbind("localtime" = localtime, mydata)
  rslt <- cbind("localtimezone" = localtimezone, rslt)
  rslt <- cbind("city" = paste(cityname, distance, sep = "-"), rslt)
  #browser()
  
  rslt <- rslt %>% dplyr::select(uid, city, localtime, lat, lon, aqi, localtimezone)
  names(rslt)[6] <- "pm25"
  names(rslt)[1] <- "stationid"
  rslt$pm25 <- as.numeric(rslt$pm25)
  rslt$stationid <- as.numeric(rslt$stationid)
  apldesc <- getglobalPM25Options()$apl_description
  #browser()
  rslt <- rslt[complete.cases(rslt$pm25), ]
  apl <- sapply(rslt$pm25, function(x) if(is.na(x)) x else if(x>300L) apldesc[6L] else if(x>200L) apldesc[5L] else if(x>150L) apldesc[4L] else if(x>100L) apldesc[3L] else if(x>50) apldesc[2L]  else apldesc[1L])
  apl <- factor(apl, levels = apldesc)
  rslt <- cbind(rslt, APL = apl)
  rslt <- rslt %>%
    dplyr::select(stationid, city, localtime, APL, pm25, lat, lon, localtimezone) %>%
    dplyr::arrange(desc(pm25))
  dat <- tibble::as_tibble(rslt)

  #browser()
  g <- ggplot2::ggplot(ggplot2::aes(x = lon, y = lat, size = pm25, colour = APL), data = dat)
  g <- g + ggplot2::geom_point() + ggplot2::scale_color_manual(values=getglobalPM25Options()$apl_color)
  print(g)
  #browser()
  #print(qplot(x = lon, y = lat, colour = APL, size = pm25, data = dat))

  dat
}
