#' CSWConstraint
#' @docType class
#' @export
#' @keywords OGC Filter
#' @return Object of \code{\link{R6Class}} for modelling an CSW Constraint
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(cqlText, filter, cswVersion)}}{
#'    This method is used to instantiate an CSWConstraint object.
#'  }
#' }
CSWConstraint <-  R6Class("CSWConstraint",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Constraint",
    xmlNamespace = c(csw = "http://www.opengis.net/cat/csw")
  ),
  public = list(
    wrap = TRUE,
    CqlText = NULL,
    filter = NULL,
    initialize = function(cqlText = NULL, filter = NULL, cswVersion = "2.0.2"){
      nsName <- names(private$xmlNamespace)
      private$xmlNamespace = paste(private$xmlNamespace, cswVersion, sep="/")
      names(private$xmlNamespace) <- nsName
      super$initialize(attrs = list(version = "1.1.0"))
      if(!is.null(cqlText)) if(!is(cqlText, "character")){
        stop("The argument 'cqlText' should be an object of class 'character'")
      }
      if(!is.null(filter)) if(!is(filter, "OGCFilter")){
        stop("The argument 'filter' should be an object of class 'OGCFilter'")
      }
      self$CqlText = cqlText
      self$filter = filter
    }
  )
)