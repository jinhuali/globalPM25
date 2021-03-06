% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getPMbylatlon.R
\name{getPMbylatlon}
\alias{getPMbylatlon}
\title{get real-time PM2.5 level near a latitude and longitude}
\usage{
getPMbylatlon(lat, lon)
}
\arguments{
\item{lat}{latitude}

\item{lon}{longitude}
}
\value{
tibble
}
\description{
query real-time PM2.5 level at the station closest to a latitude and longitude. return a tibble containing Pm2.5 level, station location, local and UTC time
}
\examples{
\dontrun{getPMbylatlon(37.774929, -122.419416)} ##require personal token
}
