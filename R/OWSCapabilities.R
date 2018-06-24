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
#'  \item{\code{new(url, service, version, logger)}}{
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
#'  \item{\code{getServiceProvider()}}{
#'    Get the service provider
#'  }
#'  \item{\code{getOperationsMetadata()}}{
#'    Get the service operations metadata
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSCapabilities <- R6Class("OWSCapabilities",
   inherit = OWSLogger,
   private = list(
     url = NA,
     version = NA,
     request = NA,
     serviceIdentification = NULL,
     serviceProvider = NULL,
     operationsMetadata = NULL
   ),
   
   public = list(
     
     #initialize
     initialize = function(url, service, version, logger = NULL) {
       super$initialize(logger = logger)
       namedParams <- list(request = "GetCapabilities", version = version)
       private$request <- OWSRequest$new(op = NULL, "GET", url, namedParams, "text/xml", logger = logger)
       xmlObj <- private$request$response
       private$serviceIdentification <- OWSServiceIdentification$new(xmlObj, service, version)
       private$serviceProvider <- OWSServiceProvider$new(xmlObj, service, version)
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
     
     #getServiceProvider
     getServiceProvider = function(){
       return(private$serviceProvider)
     },
     
     #getOperationsMetadata
     getOperationsMetadata = function(){
       return(private$operationsMetadata)
     }
   )
)