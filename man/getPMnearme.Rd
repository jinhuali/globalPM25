% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getPMnearme.R
\name{getPMnearme}
\alias{getPMnearme}
\title{get real-time PM2.5 level near you}
\usage{
getPMnearme()
}
\value{
a tibble containing location, time and PM2.5 level
}
\description{
get real-time PM2.5 level at a station that closest to you (based on your computer ip address)
}
\examples{
\dontrun{getPMnearme()} #require personal token
}
