#' WPSLiteralData
#'
#' @docType class
#' @export
#' @keywords OGC WPS LiteralData
#' @return Object of \code{\link{R6Class}} for modelling a WPS Literal Data
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(identifier, data)}}{
#'    This method is used to instantiate a WPSLiteralData object
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSLiteralData <- R6Class("WPSLiteralData",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "LiteralData",
    xmlNamespace = c(wps = "http://www.opengis.net/wps")
  ),
  public = list(
    value = NULL,
    wrap = TRUE,
    initialize = function(value) {
      self$value <- value
    }
  )
)