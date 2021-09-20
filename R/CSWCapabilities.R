#' CSWCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC CSW Capabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Catalogue Service for the Web (CSW) Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, client logger)}}{
#'    This method is used to instantiate a \code{CSWCapabilities} object
#'  }
#' }
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
     
     #initialize
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