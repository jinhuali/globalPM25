#' Set your API toke
#'
#' @description request your personal token from \url{http://aqicn.org/data-platform/token/}
#' @param atoken character
#' @export
#' @examples
#' setenvironment()
#' settoken("demo")
settoken <- function(atoken){
  assign("atoken", atoken, envir = cacheEnv)
}
