#' OWSGetCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC OWS GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an abstract
#' OWS Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, service,  owsVersion, serviceVersion, logger, ...)}}{
#'    This method is used to instantiate a OWSGetCapabilities object
#'  }
#'  \item{\code{setClient(client)}}{
#'    Internal method to self-assign the parent client
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
#' @note abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSCapabilities <- R6Class("OWSCapabilities",
   inherit = OGCAbstractObject,
   private = list(
     client = NULL,
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
     initialize = function(url, service, owsVersion, serviceVersion, 
                           logger = NULL, ...) {
       super$initialize(logger = logger)
       private$url <- url
       private$service <- service
       private$owsVersion <- owsVersion
       private$serviceVersion <- serviceVersion
       namedParams <- list(service = service, version = serviceVersion)
       private$request <- OWSGetCapabilities$new(url, service, serviceVersion, logger = logger, ...)
       xmlObj <- private$request$getResponse()
       private$serviceIdentification <- OWSServiceIdentification$new(xmlObj, owsVersion, serviceVersion)
       private$serviceProvider <- OWSServiceProvider$new(xmlObj, owsVersion, serviceVersion)
       private$operationsMetadata <- OWSOperationsMetadata$new(xmlObj, owsVersion, serviceVersion)
     },
     
     #setClient
     setClient = function(client){
        private$client <- client
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
     },
     
     #getClient
     getClient = function(){
        return(private$client)
     }
   )
)