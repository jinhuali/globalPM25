#' get real-time PM2.5 level at major world cities
#'
#' @description Query real-time PM2.5 levels measured by US EPA's AQI (Air Quality Index) and APL (Air Pollution Level) at a list of major world cities. Return a tibble containing PM2.5 level, obervation station location, and local time. The results are sorted by PM2.5 AQI value
#' @return a tibble
#' @export
#' @examples
#' getPMatMajorWorldCities()

getPMatMajorWorldCities <- function(){
  getPMbyCityNames(getglobalPM25Options()$worldcities)
}
