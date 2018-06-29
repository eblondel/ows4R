#' WFSClient
#'
#' @docType class
#' @export
#' @keywords OGC WFS Feature
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Feature Service.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    WFSClient$new("http://localhost:8080/geoserver/wfs", version = "1.1.1")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, serviceVersion, user, pwd, logger)}}{
#'    This method is used to instantiate a WFSClient with the \code{url} of the
#'    OGC service. Authentication (\code{user}/\code{pwd}) is not yet supported and will
#'    be added with the support of service transactional modes. By default, the \code{logger}
#'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
#'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
#'  }
#'  \item{\code{getCapabilities()}}{
#'    Get service capabilities. Inherited from OWS Client
#'  }
#'  \item{\code{describeFeatureType(typeName)}}{
#'    Get the description of a given featureType
#'  }
#'  \item{\code{getFeatures(typeName, ...)}}{
#'    Retrieves the features for a given feature type.
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSClient <- R6Class("WFSClient",
   inherit = OWSClient,
   private = list(
     serviceName = "WFS"
   ),
   public = list(
     #initialize
     initialize = function(url, serviceVersion = NULL, user = NULL, pwd = NULL, logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion, user, pwd, logger)
       self$capabilities = WFSCapabilities$new(self$url, self$version, logger = logger)
     },
     
     #getCapabilities
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #describeFeatureType
     describeFeatureType = function(typeName){
       self$INFO(sprintf("Fetching featureType description for '%s' ...", typeName))
       describeFeatureType <- NULL
       ft <- self$capabilities$findFeatureTypeByName(typeName, exact = TRUE)
       if(is(ft, "WFSFeatureType")){
         describeFeatureType <- ft$getDescription()
       }
       return(describeFeatureType)
     },
     
     #getFeatures
     getFeatures = function(typeName, ...){
       self$INFO(sprintf("Fetching features for '%s' ...", typeName))
       features <- NULL
       ft <- self$capabilities$findFeatureTypeByName(typeName, exact = TRUE)
       if(is(ft,"WFSFeatureType")){
         features <- ft$getFeatures(...)
       }
       return(features)
     }
   )
)

