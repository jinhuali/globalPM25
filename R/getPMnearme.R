#' get PM2.5 level near you
#'
#' @description get PM2.5 level at a station that closest to you (based on your computer ip address)
#' @return data frame containing location, time and PM2.5 level
#' @export
#' @examples
#' \dontshow{setenvironment()}
#' getPMnearme()
getPMnearme <- function(){
  getPMbyCityNames("here")
}