#' WMSGetFeatureInfo
#'
#' @docType class
#' @export
#' @keywords OGC WMS GetFeatureInfo
#' @return Object of \code{\link{R6Class}} for modelling a WMS GetFeatureInfo request
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a WMS GetFeatureInfo request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSGetFeatureInfo <- R6Class("WMSGetFeatureInfo",
 inherit = OWSHttpRequest,
 private = list(
   xmlElement = "GetFeatureInfo",
   xmlNamespacePrefix = "WMS"
 ), 
 public = list(
    
    #'@description Initializes a \link{WMSGetFeatureInfo} service request
    #'@param capabilities an object of class \link{WMSCapabilities}
    #'@param op object of class \link{OWSOperation} as retrieved from capabilities
    #'@param url url
    #'@param version version
    #'@param layers layers
    #'@param srs srs
    #'@param styles styles
    #'@param feature_count feature count
    #'@param x x
    #'@param y y
    #'@param width width
    #'@param height height
    #'@param bbox bbox
    #'@param info_format info format
    #'@param user user
    #'@param pwd pwd
    #'@param token token
    #'@param headers headers
    #'@param config config
    #'@param logger logger
    #'@param ... any parameter to pass to the service request
   initialize = function(capabilities, op, url, version, layers, srs, styles, feature_count = 1,
                         x, y, width, height, bbox, info_format = "text/xml",
                         user = NULL, pwd = NULL, token = NULL, headers = c(), config = httr::config(),
                         logger = NULL, ...) {
     
     mimeType <- switch(info_format,
      "application/vnd.ogc.gml" = "text/xml",
      "application/vnd.ogc.gml/3.1.1" = "text/xml",
      "application/json" = "application/json",
      "text/xml"                 
     )
      
     if(is(bbox, "matrix")){
        bbox <- paste0(bbox, collapse=",")
     }
     #case of 1.1
     namedParams <- list(
       service = "WMS", 
       version = version,
       FORMAT = "image/png",
       TRANSPARENT = "true",
       QUERY_LAYERS = layers,
       SRS = srs,
       LAYERS = layers,
       STYLES = styles,
       FEATURE_COUNT = format(feature_count, scientific = FALSE),
       X = x, Y = y,
       WIDTH = width, HEIGHT = height,
       BBOX = bbox,
       INFO_FORMAT = info_format
     )
     if(startsWith(version, "1.3")){
        names(namedParams)[which(names(namedParams)=="SRS")] <- "CRS"
        names(namedParams)[which(names(namedParams)=="X")] <- "I"
        names(namedParams)[which(names(namedParams)=="Y")] <- "J"
     }
     
     vendorParams <- list(...)
     if(length(vendorParams)>0) namedParams <- c(namedParams, vendorParams)
     namedParams <- namedParams[!sapply(namedParams, is.null)]
     super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix,
                      capabilities, op, "GET", url, request = "GetFeatureInfo",
                      user = user, pwd = pwd, token = token, headers = headers, config = config,
                      namedParams = namedParams, mimeType = mimeType, 
                      logger = logger)
     self$execute()
   }
 )
)