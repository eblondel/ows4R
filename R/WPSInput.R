#' WPSInput
#'
#' @docType class
#' @export
#' @keywords OGC WPS Input
#' @return Object of \code{\link{R6Class}} for modelling a WPS Input
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(identifier, data)}}{
#'    This method is used to instantiate a WPSInput object
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSInput <- R6Class("WPSInput",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Input",
    xmlNamespace = c(wps = "http://www.opengis.net/wps")
  ),
  public = list(
    Identifier = NULL,
    Data = NULL,
    initialize = function(identifier, data) {
      if(is(identifier, "character")){
        identifier <- OWSCodeType$new(value = identifier)
      }
      self$Identifier <- identifier
      self$Data <- data
    }
  )
)