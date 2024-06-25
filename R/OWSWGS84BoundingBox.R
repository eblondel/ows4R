#' OWSWGS84BoundingBox
#'
#' @docType class
#' @export
#' @keywords OGC OWS wgs84 boundingbox
#' @return Object of \code{\link[R6]{R6Class}} for modelling an OGC WS84 BoundingBox
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{geometa}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSWGS84BoundingBox <-  R6Class("OWSWGS84BoundingBox",
   inherit = OWSBoundingBox,
   private = list(
      xmlElement = "WGS84BoundingBox",
      xmlNamespacePrefix = "OWS" 
   ),
   public = list(
      
      #'@description Initializes an object of class \link{OWSBoundingBox}
      #'@param xml an object of class \link[XML]{XMLInternalNode-class} to initialize from XML
      #'@param owsVersion OWS version
      #'@param serviceVersion service version
      #'@param logger logger
      initialize = function(xml = NULL, owsVersion, serviceVersion, logger = NULL){
         super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                          owsVersion = owsVersion, serviceVersion = serviceVersion, 
                          logger = logger)
      }
   )
)