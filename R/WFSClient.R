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
#' \donttest{
#'    #example based on a WFS endpoint responding at http://localhost:8080/geoserver/wfs
#'    wfs <- WFSClient$new("http://localhost:8080/geoserver/wfs", serviceVersion = "1.1.1")
#'    
#'    #get capabilities
#'    caps <- wfs$getCapabilities()
#'    
#'    #find feature type
#'    ft <- caps$findFeatureTypeByName("mylayer")
#'    data <- ft$getFeatures()
#'    data_with_filter <- ft$getFeatures(cql_filter = "somefilter")
#'    
#'    #Advanced examples at https://github.com/eblondel/ows4R/wiki#wfs
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
#'  \item{\code{reloadCapabilities()}}{
#'    Reload service capabilities
#'  }
#'  \item{\code{describeFeatureType(typeName)}}{
#'    Get the description of a given featureType
#'  }
#'  \item{\code{getFeatures(typeName, ...)}}{
#'    Retrieves the features for a given feature type.
#'  }
#'  \item{\code{getFeatureTypes(pretty)}}{
#'    List the feature types available. If \code{pretty} is TRUE,
#'    the output will be an object of class \code{data.frame}
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
     
     #reloadCapabilities
     reloadCapabilities = function(){
       self$capabilities = WFSCapabilities$new(self$url, self$version, logger = self$loggerType)
     },
     
     #describeFeatureType
     describeFeatureType = function(typeName){
       self$INFO(sprintf("Fetching featureType description for '%s' ...", typeName))
       describeFeatureType <- NULL
       ft <- self$capabilities$findFeatureTypeByName(typeName)
       if(is(ft, "WFSFeatureType")){
         describeFeatureType <- ft$getDescription()
       }else if(is(ft, "list")){
          describeFeatureType <- ft[[1]]$getDescription()
       }
       return(describeFeatureType)
     },
     
     #getFeatures
     getFeatures = function(typeName, ...){
       self$INFO(sprintf("Fetching features for '%s' ...", typeName))
       features <- NULL
       ft <- self$capabilities$findFeatureTypeByName(typeName)
       if(is(ft,"WFSFeatureType")){
         features <- ft$getFeatures(...)
       }else if(is(ft, "list")){
          features <- ft[[1]]$getFeatures(...)
       }
       return(features)
     },
     
     #getFeatureTypes
     getFeatureTypes = function(pretty = FALSE){
       return(self$capabilities$getFeatureTypes(pretty = pretty))
     }
     
   )
)

