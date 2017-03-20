#' plot sample pm2.5 data form \code{usdat} and \code{\link{worlddat}}
#'
#' @description plot sample pm2.5 data from stations in US and a list of selected big cities in the world
#' @importFrom ggplot2 ggtitle ggplot borders geom_point aes
#' @importFrom graphics par
#' @export
#' @examples
#' plotPMdat()
plotPMdat <- function(){
  par(ask=TRUE)

  #data(worlddat)
  mapWorld <- borders("world", colour="gray50", fill="gray50") # create a layer of borders
  g <- ggplot(aes(x = lon, y = lat, colour = APL, size = pm25), data = na.omit(worlddat)) +   mapWorld
  g <- g + geom_point()
  g <- g + ggtitle("PM2.5 data collected from stations at a list of selected cities worldwide; \n the data are sampled at 4pm PST, March 19, 2017")
  print(g)


  g <- ggplot(aes(x = reorder(city, pm25), y = pm25, fill=factor(APL)), data = na.omit(worlddat)) +
    geom_bar(stat = "identity") +
    coord_flip()
  g <- g + ggtitle("PM2.5 data collected from stations at a list of selected cities worldwide; \n the data are sampled at 4pm PST, March 19, 2017")
  print(g)

  #data(usdat)
  mapUS <- borders("usa", colour="gray50", fill="gray50") # create a layer of borders
  g <- ggplot(aes(x = lon, y = lat, colour = APL, size = pm25), data = usdat) +   mapUS
  g <- g + geom_point()
  g <- g + ggtitle("PM2.5 data collected from stations at continental USA; \n the data are sampled at 4pm PST, March 19, 2017
")
  print(g)
}
