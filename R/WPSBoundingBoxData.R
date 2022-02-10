#' WPSBoundingBoxData
#'
#' @docType class
#' @export
#' @keywords OGC WPS Bounding Box data
#' @return Object of \code{\link{R6Class}} for modelling an OGC WPS BoundingBox data
#' @format \code{\link{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSBoundingBoxData <-  R6Class("WPSBoundingBoxData",
    inherit = OWSBoundingBox,
    private = list(
      xmlElement = "BoundingBoxData",
      xmlNamespacePrefix = "WPS" 
    ),
    public = list(
      
      #'@description Initializes an object of class \link{WPSBoundingBoxData}
      #'@param xml an object of class \link{XMLInternalNode-class} to initialize from XML
      #'@param owsVersion OWS version
      #'@param serviceVersion WPS service version
      #'@param logger logger
      #'@param ... any other parameter
      initialize = function(xml = NULL, owsVersion, serviceVersion = "1.0.0", logger = NULL, ...){
        super$initialize(xml = xml, 
                         element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                         owsVersion = owsVersion, serviceVersion = serviceVersion, 
                         logger = logger, ...)
      }
    )
)