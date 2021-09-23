#' OWSWGS84BoundingBox
#'
#' @docType class
#' @export
#' @keywords OGC OWS wgs84 boundingbox
#' @return Object of \code{\link{R6Class}} for modelling an OGC WS84 BoundingBox
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, owsVersion, serviceVersion, logger)}}{
#'    This method is used to instantiate an \code{OWSWGS84BoundingBox} object
#'  }
#' }
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
     initialize = function(xml = NULL, owsVersion, serviceVersion, logger = NULL){
       super$initialize(xml = xml, 
                        element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                        owsVersion = owsVersion, serviceVersion = serviceVersion, 
                        logger = logger, ...)
     }
   )
)