#' WPSDescribeProcess
#'
#' @docType class
#' @export
#' @keywords OGC WPS DescribeProcess
#' @return Object of \code{\link{R6Class}} for modelling a WPS DescribeProcess request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(capabilities, op, url, version, identifier, logger, ...)}}{
#'    This method is used to instantiate a WPSDescribeProcess object
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WPS DescribeProcess request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSDescribeProcess <- R6Class("WPSDescribeProcess",
  inherit = OWSHttpRequest,
  private = list(
    name = "DescribeProcess"
  ),
  public = list(
    initialize = function(capabilities, op, url, version, identifier, logger = NULL, ...) {
      namedParams <- list(service = "WPS", version = version, identifier = identifier)
      super$initialize(capabilities, op, "GET", url, request = private$name,
                       namedParams = namedParams, mimeType = "text/xml", logger = logger,
                       ...)
      self$execute()
    }
  )
)