#' WPSComplexOutputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process complex output description
#' @return Object of \code{\link[R6]{R6Class}} modelling a WPS process complex input description
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSComplexOutputDescription <- R6Class("WPSComplexOutputDescription",
  inherit = WPSOutputDescription,                       
  private = list(),
  public = list(
    
    #'@description Initializes a \link{WPSComplexOutputDescription}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param version WPS service version
    #'@param logger logger
    #'@param ... any other parameter
    initialize = function(xml = NULL, version, logger = NULL, ...){
      super$initialize(xml = xml, version = version, logger = logger, ...)
    }
  )
)