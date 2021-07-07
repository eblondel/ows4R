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
#'  \item{\code{new(op, url, version, layers, srs, styles, feature_count,
#'                  x, y, width, height, bbox, info_format, logger, ...)}}{
#'    This method is used to instantiate a WMSGetFeatureInfo object
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WMS GetFeatureInfo request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSGetFeatureInfo <- R6Class("WMSGetFeatureInfo",
 inherit = OWSHttpRequest,
 private = list(
   name = "GetFeatureInfo"
 ), 
 public = list(
   initialize = function(op, url, version, layers, srs, styles, feature_count = 1,
                         x, y, width, height, bbox, info_format = "text/xml",
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
     super$initialize(op, "GET", url, request = private$name, 
                      namedParams = namedParams, mimeType = mimeType, 
                      logger = logger)
     self$execute()
   }
 )
)