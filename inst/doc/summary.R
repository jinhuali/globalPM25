## ---- echo = FALSE-------------------------------------------------------
###opts_knit$set(stop_on_error = 2L)
installIfNeeded <- function(packages, ...) {
    installedPackages <- installed.packages()[, 1]
    toInstall <- setdiff(packages, installedPackages)
    if (length(toInstall) > 0) install.packages(toInstall, ...)
}
installIfNeeded(c("globalPM25",
                  "ggplot2"))
library(ggplot2)
library(globalPM25)

## ---- eval=FALSE---------------------------------------------------------
#  settoken()

## ---- fig.width=8, fig.height=4------------------------------------------
require(globalPM25)
data("worlddat")
mapWorld <- ggplot2::borders("world", colour="gray50", fill="gray50") # create a layer of borders
g <- ggplot(aes(x = lon, y = lat, colour = APL, size = pm25), data = na.omit(worlddat)) +   mapWorld
g <- g + geom_point()
g <- g + ggtitle("PM2.5 data collected from stations at a list of selected cities worldwide; \n the data are sampled at 4pm PST, March 19, 2017")
g

## ---- fig.width=8, fig.height=4------------------------------------------
g <- ggplot(aes(x = reorder(city, pm25), y = pm25, fill=factor(APL)), data = na.omit(worlddat)) +
    geom_bar(stat = "identity") +
    coord_flip()
g <- g + ggtitle("PM2.5 data collected from stations at a list of selected cities worldwide; \n the data are sampled at 4pm PST, March 19, 2017")
g

## ---- fig.width=8, fig.height=4------------------------------------------
data(usdat)
mapUS <- ggplot2::borders("usa", colour="gray50", fill="gray50") # create a layer of borders
g <- ggplot(aes(x = lon, y = lat, colour = APL, size = pm25), data = usdat) +   mapUS
g <- g + geom_point()
g <- g + ggtitle("PM2.5 data collected from stations at continental USA; \n the data are sampled at 4pm PST, March 19, 2017
")
g

## ---- fig.width=8, fig.height=4------------------------------------------
getPMnearme() #get real-time PM2.5 level from a station cloest to you (base on your computer ip address)

## ---- fig.width=8, fig.height=4------------------------------------------
getPMbyCityNames(c("newyork", "chicago", "san jose", "dallas", "los angeles"))

## ---- fig.width=8, fig.height=4------------------------------------------
getPMinRegion("san jose", 100)

## ---- fig.width=8, fig.height=4------------------------------------------
getPMatMajorWorldCities()

