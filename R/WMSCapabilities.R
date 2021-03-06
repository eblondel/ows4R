#' WMSCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC WMS GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Map Service Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on WMS endpoint responding at http://localhost:8080/geoserver/wms
#'    caps <- WMSCapabilities$new("http://localhost:8080/geoserver/wms", version = "1.1.1")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, logger, ...)}}{
#'    This method is used to instantiate a WMSCapabilities object
#'  }
#'  \item{\code{getRequests(pretty)}}{
#'    List the requests available. If \code{pretty} is TRUE,
#'    the output will be an object of class \code{data.frame}
#'  }
#'  \item{\code{getRequestNames()}}{
#'    List the request names available.
#'  }
#'  \item{\code{getLayers(pretty)}}{
#'    List the layers available. If \code{pretty} is TRUE,
#'    the output will be an object of class \code{data.frame}
#'  }
#'  \item{\code{findLayerByName(name, exact)}}{
#'    Find layer(s) by name.
#'  }
#' }
#' 
#' @note Class used to read a \code{WMSCapabilities} document. The use of \code{WMSClient} is
#' recommended instead to benefit from the full set of capabilities associated to a WMS server.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSCapabilities <- R6Class("WMSCapabilities",
 inherit = OWSCapabilities,
 private = list(
   
   requests = list(),
   layers = list(),
   
   #fetchRequests
   fetchRequests = function(xmlObj, version){
      wmsNs <- NULL
      if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
         if(!is.null(namespaces)) wmsNs <- OWSUtils$findNamespace(namespaces, id = "wms")
      }
      requestsXML <- list()
      if(is.null(wmsNs)){
         requestsXML <- getNodeSet(xmlObj, "//Request")
      }else{
         requestsXML <- getNodeSet(xmlObj, "//ns:Request", wmsNs) 
      }
      requestsList <- list()
      if(length(requestsXML)>0){
         requests <- xmlChildren(requestsXML[[1]])
         requestsList <- lapply(requests, function(x){
            OWSRequest$new(x, self, version, logger = self$loggerType)
         })
      }
      return(requestsList)
   },
   
   #fetchLayers
   fetchLayers = function(xmlObj, version){
     wmsNs <- NULL
     if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
       namespaces <- OWSUtils$getNamespaces(xmlObj)
       if(!is.null(namespaces)) wmsNs <- OWSUtils$findNamespace(namespaces, id = "wms")
     }
     layersXML <- list()
     if(is.null(wmsNs)){
       layersXML <- getNodeSet(xmlObj, "//Layer/Layer")
     }else{
       layersXML <- getNodeSet(xmlObj, "//ns:Layer/ns:Layer", wmsNs)
     }
     layersList <- lapply(layersXML, function(x){
       WMSLayer$new(x, self, version, logger = self$loggerType)
     })
     return(layersList)
   }
   
 ),
 
 public = list(
   
   #initialize
   initialize = function(url, version, logger = NULL, ...) {
     super$initialize(url, service = "WMS", owsVersion = "1.1", serviceVersion = version, 
                      logger = logger, ...)
     xmlObj <- self$getRequest()$getResponse()
     private$requests = private$fetchRequests(xmlObj, version)
     private$layers = private$fetchLayers(xmlObj, version)
   },
   
   #getRequests
   getRequests = function(pretty = FALSE){
      requests <- private$requests
      if(pretty){
         requests <- do.call("rbind", lapply(requests, function(x){
            return(data.frame(
               name = x$getName(),
               formats = paste0(x$getFormats(), collapse=","),
               stringsAsFactors = FALSE
            ))
         }))
      }
      return(requests)
   },
   
   #getRequestNames
   getRequestNames = function(){
      return(names(private$requests))
   },
   
   #getLayers
   getLayers = function(pretty = FALSE){
     layers <- private$layers
     if(pretty){
       layers <- do.call("rbind", lapply(layers, function(x){
         return(data.frame(
           name = if(!is.null(x$getName())){x$getName()}else{NA},
           title = x$getTitle(),
           stringsAsFactors = FALSE
         ))
       }))
     }
     return(layers)
   },
   
   #findLayerByName
   findLayerByName = function(expr, exact = TRUE){
     result <- lapply(private$layers, function(x){
       ft <- NULL
       if(!is.null(x$getName())) if(attr(regexpr(expr, x$getName()), "match.length") != -1 
          && endsWith(x$getName(), expr)){
         ft <- x
       }
       return(ft)
     })
     result <- result[!sapply(result, is.null)]
     if(length(result) == 1) result <- result[[1]]
     return(result)
   }
   
 )
)