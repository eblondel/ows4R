#' WPSComplexOutputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process complex output description
#' @return Object of \code{\link{R6Class}} modelling a WPS process complex input description
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, version, logger)}}{
#'    This method is used to instantiate a \code{WPSComplexOutputDescription} object
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSComplexOutputDescription <- R6Class("WPSComplexOutputDescription",
  inherit = WPSOutputDescription,                       
  private = list(),
  public = list(
    initialize = function(xmlObj = NULL, version, logger = NULL, ...){
      super$initialize(xmlObj = xmlObj, version = version, logger = logger, ...)
    }
  )
)