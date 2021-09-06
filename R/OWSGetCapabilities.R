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
#'  \item{\code{new(element, namespacePrefix, url, service, version, ...)}}{
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
    xmlElement = "GetCapabilities",
    xmlNamespacePrefix = "OWS_1_1"
  ),
  public = list(
    initialize = function(element = NULL, namespacePrefix = NULL, url, service, version, ...) {
      if(!is.null(element)) private$xmlElement <- element
      if(!is.null(namespacePrefix)) private$xmlNamespacePrefix <- namespacePrefix
      namedParams <- list(service = service, version = version)
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                       capabilities = NULL, op = NULL, type = "GET", url = url, request = "GetCapabilities",
                       namedParams = namedParams, mimeType = "text/xml", ...)
      self$execute()
    }
  )
)