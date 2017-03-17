#' Set an environment to access useful constants that are shared within the package
#' @description Assign constants such as URL and API token to a new environment that can be accessed and modified
#' @export
#' @examples
#' setenvironment()
setenvironment <- function(){
  cacheEnv <<- new.env()
  assign(".atoken", "c37e84c905b04779aadbd46685abebbc9089b243", cacheEnv)
  assign(".baseURL", "http://api.waqi.info", cacheEnv)
}
