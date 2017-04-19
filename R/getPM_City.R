#' get real-timePM2.5 level at a city
#'
#' @description Query real-time  PM2.5 levels at a city  (default = San Francisco)
#' @param cityname a string contains country name 
#' @param radius miles (default = 50)
#' @param zoomlevel map zoom level (default = 10)
#' @return a tibble
#' @importFrom tibble tibble
#' @importFrom ggplot2 geom_point ggplot aes scale_color_manual ggtitle
#' @importFrom ggmap ggmap geocode get_googlemap
#' @export
#' @examples
#' \dontrun{getPM_City()} #require personal token
#' \dontrun{getPM_City(cityname = 'Beijing', radius = 50, zoomlevel = 10)}
getPM_City <- function(cityname = 'New York', radius = 50,  zoomlevel = 10){
  dat <- getPMinRegion(cityname = cityname, distance = radius)
  #map <- ggplot2::borders(countryname, colour="gray50", fill="gray50") # create a layer of borders
  entry <- as.numeric(ggmap::geocode(cityname))
  map <- ggmap::ggmap(ggmap::get_googlemap(center = entry, zoom = zoomlevel), extent = "normal")
  g <- map
  g <- g + ggplot2::geom_point(ggplot2::aes(x = lon, y = lat, colour = APL, size = pm25), data = dat[complete.cases(c(dat$pm25, dat$APL, dat$lat, dat$lon)),]) + ggplot2::scale_color_manual(values = getglobalPM25Options()$apl_color)
  g <- g + ggplot2::ggtitle(paste('Queried at', Sys.time(), Sys.timezone(), sep = ' '))
  print(g)
  dat
}
