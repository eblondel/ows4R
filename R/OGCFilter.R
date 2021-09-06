#' OGCFilter
#' @docType class
#' @export
#' @keywords OGC Filter
#' @return Object of \code{\link{R6Class}} for modelling an OGC Filter
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(expr, filterVersion)}}{
#'    This method is used to instantiate an OGCFilter object. The unique
#'    argument should be an object of class \code{\link{OGCExpression}}
#'  }
#'  \item{\code{setFilterVersion(filterVersion)}}{
#'    Set filter version
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsEqualTo$new(PropertyName = "property", Literal = "value")
#'   not <- Not$new(expr)
#'   not_xml <- not$encode() #see how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OGCFilter <-  R6Class("OGCFilter",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Filter",
    xmlNamespacePrefix = "OGC"
  ),
  public = list(
    expr = NULL,
    initialize = function(expr, filterVersion = "1.1.0"){
      self$setFilterVersion(filterVersion)
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      if(!is(expr, "OGCExpression")){
        stop("The argument should be an object of class 'OGCExpression'")
      }
      self$expr <- expr
    },
    
    #setFilterVersion
    setFilterVersion = function(filterVersion) {
      if(filterVersion=="2.0"){
        private$xmlNamespacePrefix = "FES"
      }else{
        private$xmlNamespacePrefix = "OGC"
      }
    }
  )
)