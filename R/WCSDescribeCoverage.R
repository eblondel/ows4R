#' WCSDescribeCoverage
#'
#' @docType class
#' @export
#' @keywords OGC WCS DescribeCoverage
#' @return Object of \code{\link{R6Class}} for modelling a WCS DescribeCoverage request
#' @format \code{\link{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSDescribeCoverage <- R6Class("WCSDescribeCoverage",
   inherit = OWSHttpRequest,
   private = list(
     xmlElement = "DescribeCoverage",
     xmlNamespacePrefix = "WCS"
   ),
   public = list(
     
     #'@description Initializes a \link{WCSDescribeCoverage} service request
     #'@param capabilities an object of class \link{WCSCapabilities}
     #'@param op object of class \link{OWSOperation} as retrieved from capabilities
     #'@param url url
     #'@param serviceVersion serviceVersion
     #'@param coverageId coverage ID
     #'@param logger logger
     #'@param ... any parameter to pass to the service request
     initialize = function(capabilities, op, url, serviceVersion,
                           coverageId, logger = NULL, ...) {
       
       namedParams <- list(service = "WCS", version = serviceVersion)
       if(startsWith(serviceVersion, "1.0")) namedParams <- c(namedParams, coverage = coverageId)
       if(startsWith(serviceVersion, "1.1")) namedParams <- c(namedParams, identifiers = coverageId)
       if(startsWith(serviceVersion, "2.0")) namedParams <- c(namedParams, coverageId = coverageId)
       
       super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                        capabilities, op, "GET", url, request = "DescribeCoverage",
                        namedParams = namedParams, mimeType = "text/xml",
                        logger = logger, ...)
       self$execute()
     }
   )
)