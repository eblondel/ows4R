#' OGCFilter
#' @docType class
#' @export
#' @keywords OGC Filter
#' @return Object of \code{\link[R6]{R6Class}} for modelling an OGC Filter
#' @format \code{\link[R6]{R6Class}} object.
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
    #'@field expr OGC expression
    expr = NULL,
    
    #'@description Initializes an object of class \link{OGCFilter}.
    #'@param expr object of class \link{OGCExpression}
    #'@param filterVersion OGC filter version. Default is "1.1.0"
    initialize = function(expr, filterVersion = "1.1.0"){
      self$setFilterVersion(filterVersion)
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      if(!is(expr, "OGCExpression")){
        stop("The argument should be an object of class 'OGCExpression'")
      }
      self$expr <- expr
    },
    
    #'@description Sets the OGC filter version
    #'@param filterVersion OGC filter version
    setFilterVersion = function(filterVersion) {
      if(filterVersion=="2.0"){
        private$xmlNamespacePrefix = "FES"
      }else{
        private$xmlNamespacePrefix = "OGC"
      }
    }
  )
)