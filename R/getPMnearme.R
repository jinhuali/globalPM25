#' get real-time PM2.5 level near you
#'
#' @description get real-time PM2.5 level at a station that closest to you (based on your computer ip address)
#' @return a tibble containing location, time and PM2.5 level
#' @export
#' @examples
#' \dontrun{getPMnearme()} #require personal token
getPMnearme <- function(){
  getPMbyCityNames("here")
}
