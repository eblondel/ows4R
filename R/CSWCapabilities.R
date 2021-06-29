#' CSWCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC CSW Capabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Catalogue Service for the Web (CSW) Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on CSW endpoint responding at http://localhost:8000/csw
#'    caps <- CSWCapabilities$new("http://localhost:8000/geonetwork/csw", version = "2.0.2")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, logger)}}{
#'    This method is used to instantiate a WFSGetCapabilities object
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
   private = list(),
   public = list(
     
     #initialize
     initialize = function(url, version, client = NULL, logger = NULL, ...) {
       owsVersion <- switch(version,
         "2.0.2" = "1.1",
         "3.0.0" = "2.0"
       )
       super$initialize(url, service = "CSW", owsVersion = owsVersion, serviceVersion = version, 
                        logger = logger, ...)
       xmlObj <- self$getRequest()$getResponse()
     }
   )
)