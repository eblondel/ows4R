#' CSWGetCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC CSW GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Catalogue Service for the Web (CSW) Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    CSWGetCapabilities$new("http://localhost:8080/geonetwork/csw", version = "2.0.2")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version)}}{
#'    This method is used to instantiate a WFSGetCapabilities object
#'  }
#'  \item{\code{getServiceIdentification()}}{
#'    Get the service identification
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWCapabilities <- R6Class("CSWCapabilities",
   
   private = list(
     
     url = NA,
     version = NA,
     request = NA,
     serviceIdentification = NA,
     
     #buildRequest
     buildRequest = function(url, version){
       namedParams <- list(request = "GetCapabilities", version = version)
       request <- OWSRequest$new(url, namedParams, "text/xml")
       return(request)
     }
   ),
   
   public = list(
     
     #initialize
     initialize = function(url, version) {
       private$request <- private$buildRequest(url, version)
       xmlObj <- private$request$response
       private$serviceIdentification <- OWSServiceIdentification$new(xmlObj, version, "CSW")
     },
     
     #getServiceIdentification
     getServiceIdentification = function(){
       return(private$serviceIdentification)
     }
   )
)