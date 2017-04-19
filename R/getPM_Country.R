#' get real-timePM2.5 level at a country
#'
#' @description Query real-time  PM2.5 levels at a country (default = U.S.)
#' @param countryname a string contains country name 
#' @param countrybound country's geographical boundary 
#' @return a tibble
#' @importFrom tibble tibble
#' @importFrom ggplot2 geom_point ggplot aes scale_color_manual ggtitle
#' @importFrom ggmap ggmap geocode get_googlemap
#' @export
#' @examples
#' \dontrun{getPM_Country()} #require personal token
#' \dontrun{getPM_Country(countryname = 'China', countrybound = c(55, 75, 20, 130))}
#' \dontrun{getPM_Country(countryname = "India", countrybound = c(35, 70, 10, 90))}
#' \dontrun{getPM_Country(countryname = "Africa", countrybound = c(20, 10, -30, 60))}
getPM_Country <- function(countryname = "United States", countrybound = c(50, -130, 25, -65)){
  dat <- getPMinRegion(geobound = countrybound)
  #map <- ggplot2::borders(countryname, colour="gray50", fill="gray50") # create a layer of borders
  entry <- as.numeric(ggmap::geocode(countryname))
  map <- ggmap::ggmap(ggmap::get_googlemap(center = entry, scale = 2, zoom = 4), extent = "normal")
  g <- map
  g <- g + ggplot2::geom_point(ggplot2::aes(x = lon, y = lat, colour = APL, size = pm25), data = dat[complete.cases(c(dat$pm25, dat$APL, dat$lat, dat$lon)),]) + ggplot2::scale_color_manual(values = getglobalPM25Options()$apl_color)
  g <- g + ggplot2::ggtitle(paste('Queried at', Sys.time(), Sys.timezone(), sep = ' '))
  print(g)
  dat
}
