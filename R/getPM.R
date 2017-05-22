#' get all real-time PM2.5 data near any location  
#'
#' @description Query real-time  PM2.5 levels near any location with a radius. 
#' @param locationname a string contains location name 
#' @param radius miles (default = 20)
#' @param zoomlevel map zoom level (default = 12)
#' @return a tibble
#' @importFrom tibble tibble
#' @importFrom ggplot2 geom_point ggplot aes scale_color_manual ggtitle
#' @importFrom ggmap ggmap geocode get_googlemap
#' @export
#' @examples
#' \dontrun{getPM()} #require personal token
#' \dontrun{getPM(locationname = 'forbidden city')}
getPM <- function(locationname = 'New York', radius = 10,  zoomlevel = 11){
  #map <- ggplot2::borders(countryname, colour="gray50", fill="gray50") # create a layer of borders
  entry <- as.numeric(ggmap::geocode(locationname)) # longitude and latitude
  dat <- getPMinRegion(centroid = c(entry[2], entry[1]), distance = radius)
  if(nrow(dat) > 0){
    map <- ggmap::ggmap(ggmap::get_googlemap(center = entry, zoom = zoomlevel), extent = "normal")
    g <- map
    g <- g + ggplot2::geom_point(ggplot2::aes(x = lon, y = lat, colour = APL, size = pm25), data = dat[complete.cases(c(dat$pm25, dat$APL, dat$lat, dat$lon)),]) + ggplot2::scale_color_manual(values = getglobalPM25Options()$apl_color[sort(unique(dat$APL))])
    g <- g + ggplot2::ggtitle(paste('Queried at', Sys.time(), Sys.timezone(), sep = ' '))
    print(g)
  }
  dat
}
