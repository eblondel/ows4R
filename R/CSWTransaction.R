#' CSWTransaction
#'
#' @docType class
#' @export
#' @keywords OGC CSW Transaction
#' @return Object of \code{\link{R6Class}} for modelling a CSW Transaction request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, id)}}{
#'    This method is used to instantiate a CSWTransaction object
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWTransaction <- R6Class("CSWTransaction",
  lock_objects = FALSE,
  inherit = OWSRequest, 
  private = list(
    xmlElement = "Transaction",
    xmlNamespace = c(csw = "http://www.opengis.net/cat/csw")
  ),
  public = list(
    initialize = function(op, url, version, type,
                          record = NULL, recordProperty = NULL, constraint = NULL,
                          logger = NULL, ...) {
      nsName <- names(private$xmlNamespace)
      private$xmlNamespace = paste(private$xmlNamespace, version, sep="/")
      names(private$xmlNamespace) <- nsName
      
      self[[type]] = list(
        record = record,
        recordProperty = recordProperty,
        constraint = constraint
      )
      super$initialize(op, "POST", url, request = private$xmlElement,
                       contentType = "text/xml", mimeType = "text/xml",
                       logger = logger, ...)
      self$attrs <- list(service = "CSW", version = version)
      self$execute()
    }
    
  )
)