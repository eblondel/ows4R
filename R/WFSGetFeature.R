#' WFSGetFeature
#'
#' @docType class
#' @export
#' @keywords OGC WFS GetFeature
#' @return Object of \code{\link{R6Class}} for modelling a WFS GetFeature request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, typeName)}}{
#'    This method is used to instantiate a WFSGetFeature object
#'  }
#'  \item{\code{getRequest()}}{
#'    Get GetFeature request
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSGetFeature <- R6Class("WFSGetFeature",
  private = list(
     request = NA,
     
     #buildRequest
     buildRequest = function(url, version, typeName){
       namedParams <- list(request = "GetFeature", version = version, typeName = typeName)
       request <- OWSRequest$new(url, namedParams, "text/xml")
       return(request)
     }
     
  ), 
  public = list(
     initialize = function(url, version, typeName) {
       private$request <- private$buildRequest(url, version, typeName)
     },
     
     #getRequest
     getRequest = function(){
       return(private$request)
     }
   )
)