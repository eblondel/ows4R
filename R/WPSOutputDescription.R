#' WPSOutputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process output description
#' @return Object of \code{\link{R6Class}} modelling a WPS process input description
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, version, logger)}}{
#'    This method is used to instantiate a \code{WPSOutputDescription} object
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSOutputDescription <- R6Class("WPSOutputDescription",
 inherit = WPSDescriptionParameter,                       
 private = list(),
 public = list(
   initialize = function(xmlObj = NULL, version, logger = NULL, ...){
     super$initialize(xmlObj = xmlObj, version = version, logger = logger, ...)
   }
 )
)