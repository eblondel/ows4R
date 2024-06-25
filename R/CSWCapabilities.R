#' CSWCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC CSW Capabilities
#' @return Object of \code{\link[R6]{R6Class}} with methods for interfacing an OGC
#' Catalogue Service for the Web (CSW) Get Capabilities document.
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used to read a \code{CSWCapabilities} document. The use of \code{CSWClient} is
#' recommended instead to benefit from the full set of capabilities associated to a CSW server.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWCapabilities <- R6Class("CSWCapabilities",
   inherit = OWSCapabilities,
   private = list(
      xmlElement = "Capabilities",
      xmlNamespacePrefix = "CSW"
   ),
   public = list(
     
     #'@description Initializes a \link{CSWCapabilities} object
     #'@param url url
     #'@param version version
     #'@param client object of class \link{CSWClient}
     #'@param logger logger type \code{NULL}, "INFO" or "DEBUG"
     #'@param ... any other parameter to pass to \link{OWSGetCapabilities} service request
     initialize = function(url, version, client = NULL, logger = NULL, ...) {
       owsVersion <- switch(version,
         "2.0.2" = "1.1",
         "3.0.0" = "2.0"
       )
       private$xmlNamespacePrefix <- paste0(private$xmlNamespacePrefix,"_",gsub("\\.","_",version))
       super$initialize(
          element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
          url, service = "CSW", owsVersion = owsVersion, serviceVersion = version, 
          logger = logger, ...)
       xmlObj <- self$getRequest()$getResponse()
     }
   )
)