#' WPSComplexInputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process complex input description
#' @return Object of \code{\link{R6Class}} modelling a WPS process complex input description
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, version, logger)}}{
#'    This method is used to instantiate a \code{WPSComplexInputDescription} object
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSComplexInputDescription <- R6Class("WPSComplexInputDescription",
  inherit = WPSInputDescription,                       
  private = list(),
  public = list(
    initialize = function(xml = NULL, version, logger = NULL, ...){
      super$initialize(xml = xml, version = version, logger = logger, ...)
    }
  )
)