#' get PM2.5 level at a city or a vector of cities
#'
#' @description query PM2.5 level at a list of cities (default "san jose"). return a tibble containing Pm2.5 level, station location, local and UTC time. The results are sorted by PM2.5 levels
#' @param citynames a vector of city names to be queryed
#' @return a tibble
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble
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
    rslt <- rbind(rslt, processPMdata(mydata))
  }
  rslt <- rslt %>% dplyr::arrange(desc(pm25))
  tibble::as_tibble(rslt)
}
