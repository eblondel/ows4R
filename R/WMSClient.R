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
#' \dontrun{
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
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSClient <- R6Class("WMSClient",
   inherit = OWSClient,
   private = list(
     serviceName = "WMS"
   ),
   public = list(
      
      #'@description This method is used to instantiate a \link{WMSClient} with the \code{url} of the
      #'    OGC service. Authentication is supported using basic auth (using \code{user}/\code{pwd} arguments), 
      #'    bearer token (using \code{token} argument), or custom (using \code{headers} argument). By default, the \code{logger}
      #'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
      #'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
      #'@param url url
      #'@param serviceVersion WFS service version
      #'@param user user
      #'@param pwd password
      #'@param token token
      #'@param headers headers
      #'@param config config
      #'@param cas_url Central Authentication Service (CAS) URL
      #'@param logger logger
     initialize = function(url, serviceVersion = NULL, 
                           user = NULL, pwd = NULL, token = NULL, headers = c(), config = httr::config(), cas_url = NULL,
                           logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion = serviceVersion, 
                        user = user, pwd = pwd, token = token, headers = headers, config = config, cas_url = cas_url, 
                        logger = logger)
       self$capabilities = WMSCapabilities$new(self$url, self$version, 
                                               user = user, pwd = pwd, token = token, headers = headers, config = config,
                                               logger = logger)
       self$capabilities$setClient(self)
     },
     
     #'@description Get WMS capabilities
     #'@return an object of class \link{WMSCapabilities}
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #'@description Reloads WFS capabilities
     reloadCapabilities = function(){
       self$capabilities = WMSCapabilities$new(self$url, self$version, 
                                               user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), 
                                               headers = self$getHeaders(), config = self$getConfig(),
                                               logger = self$loggerType)
       self$capabilities$setClient(self)
     },
     
     #'@description List the layers available. If \code{pretty} is TRUE,
     #'    the output will be an object of class \code{data.frame}
     #'@param pretty pretty
     #'@return a \code{list} of \link{WMSLayer} available, or a \code{data.frame}
     getLayers = function(pretty = FALSE){
       return(self$capabilities$getLayers(pretty = pretty))
     },
     
     #'@description Get map. NOT YET IMPLEMENTED
     getMap = function(){
       stop("Not yet supported")
     },
     
     #'@description Get feature info
     #'@param layer layer name
     #'@param srs srs
     #'@param styles styles
     #'@param feature_count feature count. Default is 1
     #'@param x x
     #'@param y y
     #'@param width width
     #'@param height height
     #'@param bbox bbox
     #'@param info_format info format. Default is "application/vnd.ogc.gml"
     #'@param ... any other parameter to pass to a \link{WMSGetFeatureInfo} request
     #'@return an object of class \code{sf} given the feature(s)
     getFeatureInfo = function(layer, srs = NULL,
                               styles = NULL, feature_count = 1,
                               x, y, width, height, bbox, 
                               info_format = "application/vnd.ogc.gml",
                               ...){
       wmsLayer = self$capabilities$findLayerByName(layer)
       features <- NULL
       if(is(wmsLayer,"WMSLayer")){
          features <- wmsLayer$getFeatureInfo(
             srs = srs, styles = styles, feature_count = feature_count,
             x = x, y = y, width = width, height = height, bbox = bbox,
             info_format = info_format,
             ...
          )
       }else if(is(wmsLayer, "list")){
          if(length(wmsLayer)==0){
             self$WARN(sprintf("No layer for layer name = '%s'", layer))
             return(NULL)
          }
       }
       return(features)
     },
     
     #'@description Get legend graphic. NOT YET IMPLEMENTED
     getLegendGraphic = function(){
       stop("Not yet supported")
     }
     
   )
)

