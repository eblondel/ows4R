#' OWSRequest
#'
#' @docType class
#' @export
#' @keywords OGC Service Request
#' @return Object of \code{\link[R6]{R6Class}} modelling a OWS Service Capability Request
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSRequest <- R6Class("OWSRequest",
  inherit = OGCAbstractObject,                       
  private = list(
    capabilities = NULL,
    url = NA,
    version = NA,
    name = NA,
    formats = list(),
    
    #fetchRequest
    fetchRequest = function(xmlObj, version){
      
      children = xmlChildren(xmlObj)
      name = xmlName(xmlObj)
      formats = sapply(children[names(children)=="Format"], xmlValue)
      names(formats) = NULL
      request <- list(name = name, formats = formats)
      return(request)
    }
    
  ),
  public = list(
    
    #'@description Initializes an object of class \link{OWSRequest}
    #'@param xmlObj object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param capabilities an object of class or extending \link{OWSCapabilities}
    #'@param version version
    #'@param logger logger
    initialize = function(xmlObj, capabilities, version, logger = NULL){
      super$initialize(logger = logger)
      
      private$capabilities = capabilities
      private$url = capabilities$getUrl()
      private$version = version
      
      request = private$fetchRequest(xmlObj, version)
      private$name = request$name
      private$formats = request$formats
      
    },
    
    #'@description Get request name
    #'@return the name, object of class \code{character}
    getName = function(){
      return(private$name)
    },
    
    #'@description Get request formats
    #'@return the formats, object (vector) of class \code{character}
    getFormats = function(){
      return(private$formats)
    }
  )
)