#' constants
#' @describeIn @description Assign some constants such as URL and API token to a environment that can be accessed, modified and saved within the package
#' @docType data
#' @keywords data
cacheEnv <- new.env()
assign("atoken", "c37e84c905b04779aadbd46685abebbc9089b243", cacheEnv)
assign("baseURL", "http://api.waqi.info", cacheEnv)
