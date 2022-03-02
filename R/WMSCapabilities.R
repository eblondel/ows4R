#' WMSCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC WMS GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Map Service Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used to read a \code{WMSCapabilities} document. The use of \code{WMSClient} is
#' recommended instead to benefit from the full set of capabilities associated to a WMS server.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSCapabilities <- R6Class("WMSCapabilities",
 inherit = OWSCapabilities,
 private = list(
   xmlElement = "Capabilities",
   xmlNamespacePrefix = "WMS",
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
   
    #'@description Initializes a \link{WMSCapabilities} object
    #'@param url url
    #'@param version version
    #'@param logger logger type \code{NULL}, "INFO" or "DEBUG"
    #'@param ... any other parameter to pass to \link{OWSGetCapabilities} service request
   initialize = function(url, version, logger = NULL, ...) {
     super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix,
                      url, service = "WMS", owsVersion = "1.1", serviceVersion = version, 
                      logger = logger, ...)
     xmlObj <- self$getRequest()$getResponse()
     private$requests = private$fetchRequests(xmlObj, version)
     private$layers = private$fetchLayers(xmlObj, version)
   },
   
   #'@description List the requests available. If \code{pretty} is TRUE,
   #'    the output will be an object of class \code{data.frame}
   #'@param pretty pretty
   #'@return a \code{list} of \link{OWSRequest} available, or a \code{data.frame}
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
   
   #'@description List the names of requests available.
   #'@return object of class \code{character}
   getRequestNames = function(){
      return(names(private$requests))
   },
   
   #'@description List the layers available. If \code{pretty} is TRUE,
   #'    the output will be an object of class \code{data.frame}
   #'@param pretty pretty
   #'@return a \code{list} of \link{WMSLayer} available, or a \code{data.frame}
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
   
   
   #'@description Finds a layer by name
   #'@param expr expr
   #'@param exact exact matching? Default is \code{TRUE}
   findLayerByName = function(expr, exact = TRUE){
     result <- lapply(private$layers, function(x){
       ft <- NULL
       if(exact){
          if(expr == x$getName()) ft <- x
       }else{
          if(!is.null(x$getName())) if(attr(regexpr(expr, x$getName()), "match.length") != -1 
             && endsWith(x$getName(), expr)){
            ft <- x
          }
       }
       return(ft)
     })
     result <- result[!sapply(result, is.null)]
     if(length(result) == 1) result <- result[[1]]
     return(result)
   }
   
 )
)