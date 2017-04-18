#' plot sample pm2.5 data form \code{usdat} and \code{\link{worlddat}}
#'
#' @description plot sample pm2.5 data from stations in US and a list of selected big cities in the world
#' @param pauseplot boolean option to pause between plots
#' @importFrom ggplot2 ggtitle ggplot borders geom_point aes scale_color_manual scale_fill_manual
#' @importFrom graphics par
#' @importFrom stats na.omit 
#' @export
#' @examples
#' plotPMdat()
plotPMdat <- function(pauseplot = TRUE){
  par(ask=pauseplot)

  aplcolor = getglobalPM25Options()$apl_color
  apldesc = getglobalPM25Options()$apl_description
  #data(worlddat)
  worlddat$APL <- factor(worlddat$APL, levels = apldesc)
  mapWorld <- ggplot2::borders("world", colour="gray50", fill="gray50") # create a layer of borders
  g <- ggplot2::ggplot(ggplot2::aes(x = lon, y = lat, colour = APL, size = pm25), data = na.omit(worlddat)) +   mapWorld
  g <- g + ggplot2::geom_point() + ggplot2::scale_color_manual(values = aplcolor)
  g <- g + ggplot2::ggtitle("PM2.5 data collected from stations at a list of selected cities worldwide; \n the data are sampled at 4pm PST, March 19, 2017")
  print(g)


  g <- ggplot2::ggplot(ggplot2::aes(x = reorder(city, pm25), y = pm25, fill=APL), data = na.omit(worlddat)) +
    ggplot2::geom_bar(stat = "identity") + ggplot2::scale_fill_manual(values = aplcolor) +
    ggplot2::coord_flip()
  g <- g + ggplot2::ggtitle("PM2.5 data collected from stations at a list of selected cities worldwide; \n the data are sampled at 4pm PST, March 19, 2017")
  print(g)

  #data(usdat)
  mapUS <- ggplot2::borders("usa", colour="gray50", fill="gray50") # create a layer of borders
  usdat$APL = factor(usdat$APL, levels = apldesc) 
  g <- ggplot2::ggplot(ggplot2::aes(x = lon, y = lat, colour = APL, size = pm25), data = usdat[complete.cases(c(usdat$pm25, usdat$APL, usdat$lat, usdat$lon)),]) +   mapUS
  g <- g + ggplot2::geom_point() + ggplot2::scale_color_manual(values = aplcolor)
  g <- g + ggplot2::ggtitle("PM2.5 data collected from stations at continental USA; \n the data are sampled at 4pm PST, March 19, 2017")
  print(g)
  par(ask=FALSE)
}
