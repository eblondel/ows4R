#' WPSOutputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process output description
#' @return Object of \code{\link{R6Class}} modelling a WPS process input description
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSOutputDescription <- R6Class("WPSOutputDescription",
 inherit = WPSDescriptionParameter,                       
 private = list(),
 public = list(
    
    #'@description Initializes a \link{WPSOutputDescription}
    #'@param xml object of class \link{XMLInternalNode-class} from \pkg{XML}
    #'@param version WPS service version
    #'@param logger logger
    #'@param ... any other parameter
   initialize = function(xml = NULL, version, logger = NULL, ...){
     super$initialize(xml = xml, version = version, logger = logger, ...)
   }
 )
)