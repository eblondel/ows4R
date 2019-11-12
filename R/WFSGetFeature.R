#' WFSGetFeature
#'
#' @docType class
#' @export
#' @keywords OGC WFS GetFeature
#' @return Object of \code{\link{R6Class}} for modelling a WFS GetFeature request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(op, url, version, typeName, logger, ...)}}{
#'    This method is used to instantiate a WFSGetFeature object
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WFS DescribeFeatureType request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSGetFeature <- R6Class("WFSGetFeature",
  inherit = OWSRequest,
  private = list(
     name = "GetFeature"
  ), 
  public = list(
     initialize = function(op, url, version, typeName, logger = NULL, ...) {
       namedParams <- list(service = "WFS", version = version, typeName = typeName)
       vendorParams <- list(...)
       if(length(vendorParams)>0) namedParams <- c(namedParams, vendorParams)
       super$initialize(op, "GET", url, request = private$name, 
                        namedParams = namedParams, mimeType = "text/xml", logger = logger)
       self$execute()
     }
   )
)