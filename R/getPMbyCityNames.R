#' get real-timePM2.5 level at a city or a vector of cities
#'
#' @description Query real-time  PM2.5 levels measured by US EPA's AQI (Air Quality Index) and APL (Air Pollution Level) at a list of cities (default "san jose"). Return a tibble containing PM2.5 level, obervation station location, and local time. The results are sorted by PM2.5 AQI
#' @param citynames a vector of city names to be queryed
#' @return a tibble
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble
#' @importFrom dplyr select arrange
#' @importFrom stats na.omit reorder
#' @importFrom ggplot2 geom_bar ggplot aes coord_flip
#' @export
#' @examples
#' getPMbyCityNames("san jose")
#' getPMbyCityNames(c("tokyo", "madrid"))
getPMbyCityNames <- function(citynames = "san jose"){
  baseURL = getglobalPM25Options()$baseURL
  atoken = getglobalPM25Options()$token

  rslt <- list()
  for(cityname in citynames){
    mydata <- jsonlite::fromJSON(sprintf("%s/feed/%s/?token=%s", baseURL, cityname, atoken), flatten=TRUE)
    arslt <- processPMdata(mydata)
    print(sprintf("The air qaulity level at %s is %s", arslt$city, arslt$APL))
    rslt <- rbind(rslt, arslt)
  }

  rslt <- rslt %>%
    dplyr::select(stationid, city, localtime, APL, pm25, lat, lon, localtimezone) %>%
    dplyr::arrange(desc(pm25))
  dat <- tibble::as_tibble(rslt)

  if(length(citynames) > 1){
    g <- ggplot(aes(x = reorder(city, pm25), y = pm25), data = na.omit(dat)) +
      geom_bar(stat = "identity", color = "#E69F00", fill = "#E69F00") +
      coord_flip()
    print(g)
  }

  dat
}
