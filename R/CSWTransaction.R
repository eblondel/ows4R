#' CSWTransaction
#'
#' @docType class
#' @export
#' @keywords OGC CSW Transaction
#' @return Object of \code{\link[R6]{R6Class}} for modelling a CSW Transaction request
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a CSW Transaction request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWTransaction <- R6Class("CSWTransaction",
  lock_objects = FALSE,
  inherit = OWSHttpRequest, 
  private = list(
    xmlElement = "Transaction",
    xmlNamespacePrefix = "CSW"
  ),
  public = list(
    
    #'@description Initializes a \link{CSWTransaction} service request
    #'@param capabilities an object of class \link{CSWCapabilities}
    #'@param op object of class \link{OWSOperation} as retrieved from capabilities
    #'@param url url
    #'@param serviceVersion serviceVersion. Default is "2.0.2
    #'@param type type of transaction, either "Insert", "Update", or "Delete"
    #'@param user user
    #'@param pwd password
    #'@param token token
    #'@param headers headers
    #'@param record record
    #'@param recordProperty record property
    #'@param constraint constraint
    #'@param logger logger
    #'@param ... any parameter to pass to the service request
    initialize = function(capabilities, op, url, serviceVersion, type, 
                          user = NULL, pwd = NULL, token = NULL, headers = list(),
                          record = NULL, recordProperty = NULL, constraint = NULL,
                          logger = NULL, ...) {
      nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", nsVersion), sep="_")
      
      self[[type]] = list(
        record = record,
        recordProperty = recordProperty,
        constraint = constraint
      )
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                       capabilities, op, "POST", url, request = private$xmlElement,
                       user = user, pwd = pwd, token = token, headers = headers,
                       contentType = "text/xml", mimeType = "text/xml",
                       logger = logger, ...)
      self$wrap <- TRUE
      self$attrs <- list(service = "CSW", version = serviceVersion)
      self$execute()
    }
    
  )
)