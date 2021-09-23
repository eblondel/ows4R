#' WPSBoundingBoxData
#'
#' @docType class
#' @export
#' @keywords OGC WPS Bounding Box data
#' @return Object of \code{\link{R6Class}} for modelling an OGC WPS BoundingBox data
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, owsVersion, serviceVersion, logger)}}{
#'    This method is used to instantiate an \code{WPSBoundingBoxData} object
#'  }
#' }
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
      initialize = function(xml = NULL, owsVersion, serviceVersion = "1.0.0", logger = NULL, ...){
        super$initialize(xml = xml, 
                         element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                         owsVersion = owsVersion, serviceVersion = serviceVersion, 
                         logger = logger, ...)
      }
    )
)