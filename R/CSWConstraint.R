#' CSWConstraint
#' @docType class
#' @export
#' @keywords OGC Filter
#' @return Object of \code{\link{R6Class}} for modelling an CSW Constraint
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(filter, cswVersion)}}{
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
    filter = NULL,
    initialize = function(filter, cswVersion = "2.0.2"){
      nsName <- names(private$xmlNamespace)
      private$xmlNamespace = paste(private$xmlNamespace, cswVersion, sep="/")
      names(private$xmlNamespace) <- nsName
      super$initialize(attrs = list(version = "1.1.0"))
      if(!is(filter, "OGCFilter")){
        stop("The argument should be an object of class 'OGCFilter'")
      }
      self$filter = filter
    }
  )
)