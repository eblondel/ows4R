#' OWSGetCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC GetCapabilities
#' @return Object of \code{\link{R6Class}} for modelling a GetCapabilities request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(op, url, service, version)}}{
#'    This method is used to instantiate a OWSGetCapabilities object
#'  }
#' }
#' 
#' @note Abstract class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSGetCapabilities <- R6Class("OWSGetCapabilities",
  inherit = OWSHttpRequest,
  private = list(
    name = "GetCapabilities"
  ),
  public = list(
    initialize = function(op, url, service, version, ...) {
      namedParams <- list(service = service, version = version)
      super$initialize(op, "GET", url, request = private$name,
                       namedParams = namedParams, mimeType = "text/xml", ...)
      self$execute()
    }
  )
)