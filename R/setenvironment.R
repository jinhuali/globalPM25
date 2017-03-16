#' Set an environment to access some useful constants within the package
#' @description Assign some constants such as URL and API token to a new environment that can be accessed, modified and saved within the package
#' @export
#' @examples
#' setenvironment()
setenvironment <- function(){
  cacheEnv <<- new.env()
  assign("atoken", "c37e84c905b04779aadbd46685abebbc9089b243", cacheEnv)
  assign("baseURL", "http://api.waqi.info", cacheEnv)
}
