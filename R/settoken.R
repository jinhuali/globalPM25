#' Set your API toke
#' @description request your token from [aqicn.org](http://aqicn.org/data-platform/token/#/)
#' @param atoken character vector
#' @export
#' @examples
#' settoken("demo")
settoken <- function(atoken){
  assign("atoken", atoken, env = cacheEnv)
}
