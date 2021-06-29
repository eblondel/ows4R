#' WPSClient
#'
#' @docType class
#' @export
#' @keywords OGC WPS Processing Process
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Processing Service.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on a WPS endpoint responding at http://localhost:8080/geoserver/wps
#'    wps <- WPSClient$new("http://localhost:8080/geoserver/wps", serviceVersion = "1.0.0")
#'    
#'    #get capabilities
#'    caps <- wps$getCapabilities()
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, serviceVersion, user, pwd, logger)}}{
#'    This method is used to instantiate a WPSClient with the \code{url} of the
#'    OGC service. Authentication is supported using basic auth (using \code{user}/\code{pwd} arguments), 
#'    bearer token (using \code{token} argument), or custom (using \code{headers} argument). By default, the \code{logger}
#'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
#'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
#'  }
#'  \item{\code{getCapabilities()}}{
#'    Get service capabilities. Inherited from OWS Client
#'  }
#'  \item{\code{reloadCapabilities()}}{
#'    Reload service capabilities
#'  }
#'  \item{\code{getProcesses(pretty)}}{
#'    Get the list of processes offered by the service
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSClient <- R6Class("WPSClient",
   inherit = OWSClient,
   private = list(
     serviceName = "WPS"
   ),
   public = list(
     #initialize
     initialize = function(url, serviceVersion = NULL, 
                           user = NULL, pwd = NULL, token = NULL, headers = c(),
                           logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion, user, pwd, token, headers, logger)
       self$capabilities = WPSCapabilities$new(self$url, self$version, 
                                               user = user, pwd = pwd, token = token, headers = headers,
                                               logger = logger)
       self$capabilities$setClient(self)
     },
     
     #getCapabilities
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #reloadCapabilities
     reloadCapabilities = function(){
       self$capabilities = WPSCapabilities$new(self$url, self$version, 
                                               user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                               logger = self$loggerType)
       self$capabilities$setClient(self)
     },
     
     #getProcesses
     getProcesses = function(pretty = FALSE){
       return(self$capabilities$getProcesses(pretty = pretty))
     }
     
   )
)

