#' CSWQuery
#' @docType class
#' @export
#' @keywords OGC Query
#' @return Object of \code{\link{R6Class}} for modelling an CSW Query
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(filter, cswVersion)}}{
#'    This method is used to instantiate an CSWQUery object.
#'  }
#' }
CSWQuery <-  R6Class("CSWQuery",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Query",
    xmlNamespace = c(csw = "http://www.opengis.net/cat/csw")
  ),
  public = list(
    wrap = TRUE,
    ElementSetName = "full",
    constraint = NULL,
    initialize = function(elementSetName = "full", constraint = NULL,
                          typeNames = "csw:Record", cswVersion = "2.0.2"){
      nsName <- names(private$xmlNamespace)
      private$xmlNamespace = paste(private$xmlNamespace, cswVersion, sep="/")
      names(private$xmlNamespace) <- nsName
      super$initialize(attrs = list(typeNames = typeNames))
      if(!is(elementSetName, "character")){
        stop("The argument 'elementSetName' should be an object of class 'character'")
      }
      self$ElementSetName = elementSetName
      
      if(!is.null(constraint)) if(!is(constraint, "CSWConstraint")){
        stop("The argument 'constraint' should be an object of class 'OGCConstraint'")
      }
      self$constraint = constraint
    }
  )
)