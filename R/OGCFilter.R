#' OGCFilter
#' @docType class
#' @export
#' @keywords OGC Filter
#' @return Object of \code{\link{R6Class}} for modelling an OGC Filter
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(expr)}}{
#'    This method is used to instantiate an OGCFilter object. The unique
#'    argument should be an object of class \code{\link{OGCExpression}}
#'  }
#' }
OGCFilter <-  R6Class("OGCFilter",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Filter",
    xmlNamespace = c(ogc = "http://www.opengis.net/ogc")
  ),
  public = list(
    expr = NULL,
    initialize = function(expr){
      super$initialize()
      if(!is(expr, "OGCExpression")){
        stop("The argument should be an object of class 'OGCExpression'")
      }
      self$expr <- expr
    }
  )
)