.onLoad <- function(libname, pkgname){
  utils::globalVariables(c("aqi", "city", "pm25", "localtime", "APL", "lat", "lon", "localtimezone")) #suppress dataframe column names
}
