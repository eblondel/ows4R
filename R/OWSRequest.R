#' OWSRequest
#'
#' @docType class
#' @export
#' @keywords OGC Service Request
#' @return Object of \code{\link{R6Class}} modelling a OWS Service Capability Request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, capabilities, version, logger)}}{
#'    This method is used to instantiate a \code{OWSRequest} object
#'  }
#'  \item{\code{getName()}}{
#'    Get request name
#'  }
#'  \item{\code{getFormats()}}{
#'    Get request formats
#'  }
#' }
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
    initialize = function(xmlObj, capabilities, version, logger = NULL){
      super$initialize(logger = logger)
      
      private$capabilities = capabilities
      private$url = capabilities$getUrl()
      private$version = version
      
      request = private$fetchRequest(xmlObj, version)
      private$name = request$name
      private$formats = request$formats
      
    },
    
    #getName
    getName = function(){
      return(private$name)
    },
    
    #getFormats
    getFormats = function(){
      return(private$formats)
    }
  )
)