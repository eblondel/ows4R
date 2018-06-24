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
    name = "Transaction",
    defaultNamespace = "http://www.opengis.net/cat/csw"
  ),
  public = list(
    initialize = function(op, url, version, type, record, constraint = NULL, logger = NULL, ...) {
      namespace = c(csw = paste(private$defaultNamespace, version, sep="/"))
      
      namedParams <- list(request = private$name, transaction = record)
      names(namedParams)[2] <- type
      if(!is.null(namedParams)) namedParams <- c(namedParams, constraint = constraint)
      
      namedAttrs <- list(service = "CSW", version = version)

      super$initialize(op, "POST", url, namedParams = namedParams, namedAttrs = namedAttrs,
                       namespace = namespace, contentType = "text/xml", mimeType = "text/xml",
                       logger = logger, ...)
      
      
    }
    
  )
)