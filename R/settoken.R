#' Set your API toke
#'
#' @description request your personal \code{token} from \url{http://aqicn.org/data-platform/token/}
#' @param token character
#' @export
#' @examples
#' \dontshow{setenvironment()}
#' settoken("demo")
settoken <- function(token){
  assign(".atoken", token, envir = cacheEnv)
}
