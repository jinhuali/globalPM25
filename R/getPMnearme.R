#' get real-time PM2.5 level near you
#'
#' @description get real-time PM2.5 level at a station that closest to you (based on your computer ip address)
#' @return a tibble containing location, time and PM2.5 level
#' @importFrom ggplot2 borders ggplot aes geom_point scale_color_manual ggtitle
#' @importFrom stats complete.cases
#' @export
#' @examples
#' \dontrun{getPMnearme()} #require personal token
getPMnearme <- function(){
  dat <- getPMbyCityNames("here")
  dat$APL <- factor(dat$APL, levels = getglobalPM25Options()$apl_description)
  mapWorld <- ggplot2::borders("world", colour="gray50", fill="gray50") # create a layer of borders
  g <- ggplot2::ggplot(ggplot2::aes(x = lon, y = lat, colour = APL, size = pm25), data = dat[complete.cases(c(dat$lat)),]) +   mapWorld
  g <- g + ggplot2::geom_point() + ggplot2::scale_color_manual(values=getglobalPM25Options()$apl_color)
  g <- g + ggplot2::ggtitle(paste('Query at', Sys.time(), Sys.timezone(), sep = ' '))
  
  print(g)
  dat
}
