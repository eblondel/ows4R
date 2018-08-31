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
#' @note Class used internally by \pkg{ows4R} to trigger a CSW Transaction request
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
    initialize = function(op, url, serviceVersion, type, user = NULL, pwd = NULL,
                          record = NULL, recordProperty = NULL, constraint = NULL,
                          logger = NULL, ...) {
      nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
      private$xmlNamespace = paste(private$xmlNamespace, nsVersion, sep="/")
      names(private$xmlNamespace) <- ifelse(serviceVersion=="3.0.0", "csw30", "csw")
      
      self[[type]] = list(
        record = record,
        recordProperty = recordProperty,
        constraint = constraint
      )
      super$initialize(op, "POST", url, request = private$xmlElement,
                       user = user, pwd = pwd,
                       contentType = "text/xml", mimeType = "text/xml",
                       logger = logger, ...)
      self$wrap <- TRUE
      self$attrs <- list(service = "CSW", version = serviceVersion)
      self$execute()
    }
    
  )
)