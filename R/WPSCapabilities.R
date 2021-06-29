#' WPSCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC WPS Capabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Processing Service (WPS) Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on WPS endpoint responding at http://localhost:8000/wps
#'    caps <- WPSCapabilities$new("http://localhost:8000/wps", version = "2.0.2")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, logger, ...)}}{
#'    This method is used to instantiate a WPSCapabilities object
#'  }
#' }
#' 
#' @note Class used to read a \code{WPSCapabilities} document. The use of \code{WPSClient} is
#' recommended instead to benefit from the full set of capabilities associated to a WPS server.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSCapabilities <- R6Class("WPSCapabilities",
   inherit = OWSCapabilities,
   private = list(),
   public = list(
     
     #initialize
     initialize = function(url, version, logger = NULL, ...) {
       owsVersion <- switch(version,
                            "1.0.0" = "1.1",
                            "2.0.0" = "2.0"
       )
       super$initialize(url, service = "WPS", owsVersion = owsVersion, serviceVersion = version, 
                        logger = logger, ...)
       xmlObj <- self$getRequest()$getResponse()
     }
   )
)