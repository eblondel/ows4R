#' OWSGetCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC OWS GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an abstract
#' OWS Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    OWSCapabilities$new("http://localhost:8080/geoserver/wfs", service = "wfs" version = "1.1.0")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, service, version)}}{
#'    This method is used to instantiate a OWSGetCapabilities object
#'  }
#'  \item{\code{getUrl()}}{
#'    Get URL
#'  }
#'  \item{\code{getVersion()}}{
#'    Get version
#'  }
#'  \item{\code{getRequest()}}{
#'    Get request
#'  }
#'  \item{\code{getServiceIdentification()}}{
#'    Get the service identification
#'  }
#'  \item{\code{getOperationsMetadata()}}{
#'    Get the service operations metadata
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSCapabilities <- R6Class("OWSCapabilities",
   
   private = list(
     
     url = NA,
     version = NA,
     request = NA,
     serviceIdentification = NULL,
     operationsMetadata = NULL,
     
     #buildRequest
     buildRequest = function(url, service, version){
       namedParams <- list(request = "GetCapabilities", service, version = version)
       request <- OWSRequest$new(url, namedParams, "text/xml")
       return(request)
     }
   ),
   
   public = list(
     
     #initialize
     initialize = function(url, service, version) {
       private$request <- private$buildRequest(url, service, version)
       xmlObj <- private$request$response
       private$serviceIdentification <- OWSServiceIdentification$new(xmlObj, service, version)
       private$operationsMetadata <- OWSOperationsMetadata$new(xmlObj, service, version)
     },
     
     #getUrl
     getUrl = function(){
       return(private$url)
     },
     
     #getVersion
     getVersion = function(){
       return(private$version)
     },
     
     #getRequest
     getRequest = function(){
      return(private$request) 
     },
     
     #getServiceIdentification
     getServiceIdentification = function(){
       return(private$serviceIdentification)
     },
     
     #getOperationsMetadata
     getOperationsMetadata = function(){
       return(private$operationsMetadata)
     }
   )
)