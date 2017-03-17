#' get city PM2.5 level
#'
#' @description query PM2.5 level at a list of cities. return a tibble containing Pm2.5 level, station location, local and UTC time
#' @param citynames a vector of city names to be queryed
#' @return a tibble
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble
#' @export
#' @examples
#' \dontshow{setenvironment()}
#' getPMbyCityNames("newyork")
#' getPMbyCityNames(c("tokyo", "madrid"))
getPMbyCityNames <- function(citynames){
  baseURL = get(".baseURL", envir = cacheEnv)
  atoken = get(".atoken", envir = cacheEnv)
  rslt <- tibble::tibble()
  for(cityname in citynames){
    mydata <- jsonlite::fromJSON(sprintf("%s/feed/%s/?token=%s", baseURL, cityname, atoken), flatten=TRUE)
    rslt <- rbind(rslt, processPMdata(mydata))
  }
  rslt
}
