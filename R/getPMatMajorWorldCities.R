#' get real-time PM2.5 level at major world cities
#'
#' @description Query real-time PM2.5 levels measured by US EPA's AQI (Air Quality Index) and APL (Air Pollution Level) at a list of major world cities. Return a tibble containing PM2.5 level, obervation station location, and local time. The results are sorted by PM2.5 AQI value and plot on world map
#' @return a tibble
#' @importFrom ggplot2 borders geom_point ggplot aes
#' @importFrom stats na.omit
#' @export
#' @examples
#' getPMatMajorWorldCities()

getPMatMajorWorldCities <- function(){
  dat <- getPMbyCityNames(getglobalPM25Options()$worldcities)
  mapWorld <- ggplot2::borders("world", colour="gray50", fill="gray50") # create a layer of borders
  g <- ggplot2::ggplot(aes(x = lon, y = lat, colour = APL, size = pm25), data = na.omit(dat)) +   mapWorld
  g <- g + ggplot2::geom_point()
  #browser()
  print(g)
  dat
}
