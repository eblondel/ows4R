#' WFSDescribeFeatureType
#'
#' @docType class
#' @export
#' @keywords OGC WFS DescribeFeatureType
#' @return Object of \code{\link{R6Class}} for modelling a WFS DescribeFeatureType request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(capabilities, op, url, version, typeName, logger, ...)}}{
#'    This method is used to instantiate a WFSDescribeFeatureType object
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WFS DescribeFeatureType request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSDescribeFeatureType <- R6Class("WFSDescribeFeatureType",
  inherit = OWSHttpRequest,
  private = list(
    name = "DescribeFeatureType"
  ),
  public = list(
    initialize = function(capabilities, op, url, version, typeName, logger = NULL, ...) {
      namedParams <- list(service = "WFS", version = version, typeName = typeName)
      super$initialize(op, "GET", url, request = private$name,
                       namedParams = namedParams, mimeType = "text/xml", logger = logger,
                       ...)
      self$execute()
    }
  )
)