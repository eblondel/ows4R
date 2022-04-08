#' OWSGetCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC OWS GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an abstract
#' OWS Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @note abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSCapabilities <- R6Class("OWSCapabilities",
   inherit = OGCAbstractObject,
   private = list(
     xmlElement = "Capabilities",
     xmlNamespacePrefix = "OWS",
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
     
      #'@description Initializes a \link{OWSCapabilities} object
      #'@param element element
      #'@param namespacePrefix namespace prefix
      #'@param url url
      #'@param service service
      #'@param owsVersion OWS version
      #'@param serviceVersion service version
      #'@param logger logger type \code{NULL}, "INFO" or "DEBUG"
      #'@param ... any other parameter to pass to \link{OWSGetCapabilities} service request
     initialize = function(element = NULL, namespacePrefix = NULL,
                           url, service, owsVersion, serviceVersion, 
                           logger = NULL, ...) {
       if(!is.null(element)) private$xmlElement <- element
       if(!is.null(namespacePrefix)){
          private$xmlNamespacePrefix <- namespacePrefix
          private$xmlNamespacePrefix <- paste0(private$xmlNamespacePrefix,"_",gsub("\\.","_",serviceVersion))
       }else{
          private$xmlNamespacePrefix <- paste0(private$xmlNamespacePrefix,"_",gsub("\\.","_",owsVersion))
       }
       
       super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix, logger = logger)
       private$url <- url
       private$service <- service
       private$owsVersion <- owsVersion
       private$serviceVersion <- serviceVersion
       namedParams <- list(service = service, version = serviceVersion)
       private$request <- OWSGetCapabilities$new(
          element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
          url, service, serviceVersion, logger = logger, ...)
       if(private$request$getStatus()==200){
          xmlObj <- private$request$getResponse()
          private$serviceIdentification <- OWSServiceIdentification$new(xmlObj, owsVersion, serviceVersion)
          private$serviceProvider <- OWSServiceProvider$new(xmlObj, owsVersion, serviceVersion)
          private$operationsMetadata <- OWSOperationsMetadata$new(xmlObj, owsVersion, serviceVersion)
       }else{
          self$ERROR(private$request$getException())
          stop(private$request$getException())
       }
     },
     
     #'@description Sets the OGC client
     #'@param client an object extending \link{OWSClient}
     setClient = function(client){
        private$client <- client
     },
     
     #'@description Get client
     #'@param an object extending \link{OWSClient}
     getClient = function(){
        return(private$client)
     },
     
     #'@description Get URL
     #'@return an object of class \code{character}
     getUrl = function(){
       return(private$url)
     },
     
     #'@description Get service
     #'@return an object of class \code{character}
     getService = function(){
       return(private$service)
     },
     
     #'@description Get service version
     #'@return an object of class \code{character}
     getServiceVersion = function(){
       return(private$serviceVersion)
     },
     
     #'@description Get OWS version
     #'@return an object of class \code{character}
     getOWSVersion = function(){
       return(private$owsVersion)
     },
     
     #'@description Get request
     #'@return an object of class \link{OWSGetCapabilities}
     getRequest = function(){
      return(private$request) 
     },
     
     #'@description Get service identification
     #'@return an object of class \link{OWSServiceIdentification}
     getServiceIdentification = function(){
       return(private$serviceIdentification)
     },
     
     #'@description Get service provider
     #'@return an object of class \link{OWSServiceProvider}
     getServiceProvider = function(){
       return(private$serviceProvider)
     },

     #'@description Get service operations metadata
     #'@return an object of class \link{OWSOperationsMetadata}     
     getOperationsMetadata = function(){
       return(private$operationsMetadata)
     }
   )
)