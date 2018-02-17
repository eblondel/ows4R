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
#' \dontrun{
#'    CSWCapabilities$new("http://localhost:8080/geonetwork/csw", version = "2.0.2")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version)}}{
#'    This method is used to instantiate a WFSGetCapabilities object
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWCapabilities <- R6Class("CSWCapabilities",
   inherit = OWSCapabilities,
   private = list(
    
   ),
   
   public = list(
     
     #initialize
     initialize = function(url, version) {
       super$initialize(url, service = "CSW", version)
       xmlObj <- self$getRequest()$response
     }
   )
)