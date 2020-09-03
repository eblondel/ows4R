#' WMSGetFeatureInfo
#'
#' @docType class
#' @export
#' @keywords OGC WMS GetFeatureInfo
#' @return Object of \code{\link{R6Class}} for modelling a WMS GetFeatureInfo request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(op, url, version, typeName, logger, ...)}}{
#'    This method is used to instantiate a WMSGetFeatureInfo object
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WMS GetFeatureInfo request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSGetFeatureInfo <- R6Class("WMSGetFeatureInfo",
 inherit = OWSRequest,
 private = list(
   name = "GetFeatureInfo"
 ), 
 public = list(
   initialize = function(op, url, version, layers, srs, styles, feature_count = 1,
                         x, y, width, height, bbox, info_format = "application/vnd.ogc.gml",
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
     namedParams <- list(
       service = "WMS", 
       version = version,
       FORMAT = "image/png",
       TRANSPARENT = "true",
       QUERY_LAYERS = layers,
       LAYERS = layers,
       STYLES = styles,
       FEATURE_COUNT = format(feature_count, scientific = FALSE),
       X = x, Y = y,
       WIDTH = width, HEIGHT = height,
       BBOX = bbox,
       INFO_FORMAT = info_format
     )
     vendorParams <- list(...)
     if(length(vendorParams)>0) namedParams <- c(namedParams, vendorParams)
     super$initialize(op, "GET", url, request = private$name, 
                      namedParams = namedParams, mimeType = mimeType, 
                      logger = logger)
     self$execute()
   }
 )
)