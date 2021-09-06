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
#'  \item{\code{new(capabilities, op, url, serviceVersion, identifier, logger, ...)}}{
#'    This method is used to instantiate a \code{WPSDescribeProcess} object
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
    xmlElement = "DescribeProcess",
    xmlNamespacePrefix = "WPS"
  ),
  public = list(
    initialize = function(capabilities, op, url, serviceVersion, identifier, logger = NULL, ...) {
      namedParams <- list(service = "WPS", version = serviceVersion, identifier = identifier)
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix,
                       capabilities, op, "GET", url, request = "DescribeProcess",
                       namedParams = namedParams, mimeType = "text/xml", logger = logger,
                       ...)
      self$execute()
    }
  )
)