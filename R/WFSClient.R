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
#'    if(length(ft)>0){
#'      data <- ft$getFeatures()
#'      data_with_filter <- ft$getFeatures(cql_filter = "somefilter")
#'    }
#'    
#'    #Advanced examples at https://github.com/eblondel/ows4R/wiki#wfs
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
      
      #'@description This method is used to instantiate a \link{WFSClient} with the \code{url} of the
      #'    OGC service. Authentication is supported using basic auth (using \code{user}/\code{pwd} arguments), 
      #'    bearer token (using \code{token} argument), or custom (using \code{headers} argument). By default, the \code{logger}
      #'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
      #'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
      #'@param url url
      #'@param serviceVersion WFS service version
      #'@param user user
      #'@param pwd password
      #'@param token token
      #'@param headers headers
      #'@param cas_url Central Authentication Service (CAS) URL
      #'@param logger logger
     initialize = function(url, serviceVersion = NULL, 
                           user = NULL, pwd = NULL, token = NULL, headers = c(), cas_url = NULL,
                           logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion = serviceVersion, 
                        user = user, pwd = pwd, token = token, headers = headers, cas_url = cas_url, 
                        logger = logger)
       self$capabilities = WFSCapabilities$new(self$url, self$version, 
                                               user = user, pwd = pwd, token = token, headers = headers,
                                               logger = logger)
       self$capabilities$setClient(self)
     },
     
     #'@description Get WFS capabilities
     #'@return an object of class \link{WFSCapabilities}
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #'@description Reloads WFS capabilities
     reloadCapabilities = function(){
       self$capabilities = WFSCapabilities$new(self$url, self$version, 
                                               user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                               logger = self$loggerType)
       self$capabilities$setClient(self)
     },
     
     #'@description Describes a feature type
     #'@param typeName the name of the feature type
     #'@return a \code{list} of \link{WFSFeatureTypeElement}
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
     
     #'@description Get features
     #'@param typeName the name of the feature type
     #'@param ... any other parameter to pass to the \link{WFSGetFeature} request
     #'@return features as object of class \code{sf}
     getFeatures = function(typeName, ...){
       self$INFO(sprintf("Fetching features for '%s' ...", typeName))
       features <- NULL
       ft <- self$capabilities$findFeatureTypeByName(typeName)
       if(is(ft,"WFSFeatureType")){
         features <- ft$getFeatures(...)
       }else if(is(ft, "list")){
          if(length(ft)==0){
             self$WARN(sprintf("No featuretype for type name = '%s'", typeName))
             return(NULL)
          }
       }
       return(features)
     },
     
     #'@description List the feature types available. If \code{pretty} is TRUE,
     #'    the output will be an object of class \code{data.frame}
     #'@param pretty whether the output should be summarized as \code{data.frame}
     #'@return a \code{list} of \link{WFSFeatureType} or a \code{data.frame}
     getFeatureTypes = function(pretty = FALSE){
       return(self$capabilities$getFeatureTypes(pretty = pretty))
     }
     
   )
)

