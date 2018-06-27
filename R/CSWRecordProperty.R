#' CSWRecordProperty
#' @docType class
#' @export
#' @keywords CSW RecordProperty
#' @return Object of \code{\link{R6Class}} for modelling an CSW RecordProperty
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(name, value)}}{
#'    This method is used to instantiate an CSWRecordProperty object.
#'  }
#' }
CSWRecordProperty <-  R6Class("CSWRecordProperty",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "RecordProperty",
    xmlNamespace = c(csw = "http://www.opengis.net/cat/csw")
  ),
  public = list(
    wrap = TRUE,
    Name = NULL,
    Value = NULL,
    initialize = function(name, value, cswVersion = "2.0.2"){
      nsName <- names(private$xmlNamespace)
      private$xmlNamespace = paste(private$xmlNamespace, cswVersion, sep="/")
      names(private$xmlNamespace) <- nsName
      super$initialize()
      self$Name = name
      self$Value = value
    }
  )
)