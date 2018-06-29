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
#'  \item{\code{new(url, service, serviceVersion, owsVersion, logger)}}{
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
   inherit = OGCAbstractObject,
   private = list(
     url = NA,
     service = NA,
     serviceVersion = NA,
     owsVersion = NA,
     request = NA,
     serviceIdentification = NULL,
     serviceProvider = NULL,
     operationsMetadata = NULL
   ),
   
   public = list(
     
     #initialize
     initialize = function(url, service, serviceVersion, owsVersion, logger = NULL) {
       super$initialize(logger = logger)
       private$url <- url
       private$service <- service
       private$serviceVersion <- serviceVersion
       private$owsVersion <- owsVersion
       namedParams <- list(service = service, version = serviceVersion)
       private$request <- OWSGetCapabilities$new(op = NULL, url, service, serviceVersion, logger = logger)
       xmlObj <- private$request$getResponse()
       private$serviceIdentification <- OWSServiceIdentification$new(xmlObj, owsVersion)
       private$serviceProvider <- OWSServiceProvider$new(xmlObj, owsVersion)
       private$operationsMetadata <- OWSOperationsMetadata$new(xmlObj, owsVersion)
     },
     
     #getUrl
     getUrl = function(){
       return(private$url)
     },
     
     #getService
     getService = function(){
       return(private$service)
     },
     
     #getServiceVersion
     getServiceVersion = function(){
       return(private$serviceVersion)
     },
     
     #getOWSVersion
     getOWSVersion = function(){
       return(private$owsVersion)
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