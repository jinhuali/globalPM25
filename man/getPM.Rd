% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getPM.R
\name{getPM}
\alias{getPM}
\title{get all real-time PM2.5 data near any location}
\usage{
getPM(locationname = "New York", radius = 20, zoomlevel = 10)
}
\arguments{
\item{locationname}{a string contains location name}

\item{radius}{miles (default = 20)}

\item{zoomlevel}{map zoom level (default = 12)}
}
\value{
a tibble
}
\description{
Query real-time  PM2.5 levels near any location with a radius.
}
\examples{
\dontrun{getPM()} #require personal token
\dontrun{getPM(locationname = 'forbidden city')}
}
