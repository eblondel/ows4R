#' WMSClient
#'
#' @docType class
#' @export
#' @keywords OGC WMS Map GetFeatureInfo
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Map Service.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on a WMS endpoint responding at http://localhost:8080/geoserver/wms
#'    wms <- WMSClient$new("http://localhost:8080/geoserver/wms", serviceVersion = "1.1.1")
#'    
#'    #get capabilities
#'    caps <- wms$getCapabilities()
#'    
#'    #get feature info
#'    
#'    #Advanced examples at https://github.com/eblondel/ows4R/wiki#wms
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, serviceVersion, user, pwd, logger)}}{
#'    This method is used to instantiate a WMSClient with the \code{url} of the
#'    OGC service. Authentication (\code{user}/\code{pwd}) is not yet supported.By default, the \code{logger}
#'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
#'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
#'  }
#'  \item{\code{getCapabilities()}}{
#'    Get service capabilities. Inherited from OWS Client
#'  }
#'  \item{\code{reloadCapabilities()}}{
#'    Reload service capabilities
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSClient <- R6Class("WMSClient",
   inherit = OWSClient,
   private = list(
     serviceName = "WMS"
   ),
   public = list(
     #initialize
     initialize = function(url, serviceVersion = NULL, user = NULL, pwd = NULL, logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion, user, pwd, logger)
       self$capabilities = WMSCapabilities$new(self$url, self$version, logger = logger)
     },
     
     #getCapabilities
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #reloadCapabilities
     reloadCapabilities = function(){
       self$capabilities = WMSCapabilities$new(self$url, self$version, logger = self$loggerType)
     },
     
     #getLayers
     getLayers = function(pretty = FALSE){
       return(self$capabilities$getLayers(pretty = pretty))
     },
     
     #getMap
     getMap = function(){
       stop("Not yet supported")
     },
     
     #getFeatureInfo
     getFeatureInfo = function(layer, srs = NULL, crs = NULL,
                               styles = NULL, feature_count = 1,
                               x, y, width, height, bbox, 
                               info_format = "application/vnd.ogc.gml",
                               ...){
       wmsLayer = self$capabilities$findLayerByName(layer)
       features <- NULL
       if(is(wmsLayer,"WMSLayer")){
          features <- wmsLayer$getFeatureInfo(
             srs = srs, crs = crs, styles = styles, feature_count = feature_count,
             x = x, y = y, width = width, height = height, bbox = bbox,
             info_format = info_format,
             ...
          )
       }else if(is(wmsLayer, "list")){
          features <- wmsLayer[[1]]$getFeatureInfo(
             srs = srs, crs = crs, styles = styles, feature_count = feature_count,
             x = x, y = y, width = width, height = height, bbox = bbox,
             info_format = info_format,
             ...
          )
       }
       return(features)
     },
     
     #getLegendGraphic
     getLegendGraphic = function(){
       stop("Not yet supported")
     }
     
   )
)

