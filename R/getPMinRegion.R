#' get real-time PM2.5 within a geographic boundary
#'
#' @description get real-time PM2.5 levels of all the stations with a geographical boundary in the format of (a) centroid = c(lat, lon) and distance (default = 50 miles) or (b) geobound = c(lat1, lon1, lat2, lon2). Return local time, station location and PM2.5 level. The results are sorted by PM2.5 levels
#' @param centroid geographical location represented by latitude and longitude
#' @param distance double
#' @param geobound numeric vector of length 4L in the format c(lat1, lon1, lat2, lon2)
#' @return a tibble
#' @importFrom tibble as_tibble
#' @importFrom dplyr %>% arrange desc select
#' @importFrom ggplot2 ggplot aes scale_color_manual geom_point ggtitle
#' @importFrom stats complete.cases
#' @export
#' @examples
#' \dontrun{getPMinRegion(geobound = c(38.164368, -122.85501, 37.203647, -121.431634))} #san francisco bay area
getPMinRegion <- function(centroid, distance = 50, geobound){
  if(!missing(centroid) && distance <= 0){
    stop("range must be greater than zero")
  }
  
  cityname = "NA"
  localtimezone <- NA
  localtime <- NA
  #browser()
  if(!missing(centroid)){
    lat <- centroid[1]
    lon <- centroid[2]
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
    return(data.frame())
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
  g <- g + ggplot2::ggtitle(paste('Queried at', Sys.time(), Sys.timezone(), sep = ' '))
  
  print(g)
  #browser()
  #print(qplot(x = lon, y = lat, colour = APL, size = pm25, data = dat))

  dat
}
