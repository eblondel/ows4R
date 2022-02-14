#' WCSClient
#'
#' @docType class
#' @export
#' @keywords OGC WCS Coverage 
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Coverage Service.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    wcs <- WCSClient$new("http://localhost:8080/geoserver/wcs", serviceVersion = "2.0.1")
#' }
#'
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSClient <- R6Class("WCSClient",
   inherit = OWSClient,
   private = list(
     serviceName = "WCS"
   ),
   public = list(
     
     #'@description This method is used to instantiate a \link{WCSClient} with the \code{url} of the
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
     #'@param logger logger
     initialize = function(url, serviceVersion = NULL, user = NULL, pwd = NULL, logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion, user, pwd, logger)
       self$capabilities = WCSCapabilities$new(self$url, serviceVersion, logger = logger)
     },
     
     #'@description Get WCS capabilities
     #'@return an object of class \link{WCSCapabilities}
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #'@description Reloads WCS capabilities
     reloadCapabilities = function(){
       self$capabilities = WCSCapabilities$new(self$url, self$version, logger = self$loggerType)
     },
     
     #'@description Describes coverage
     #'@param identifier identifier
     #'@return an object of class \link{WCSCoverageDescription}
     describeCoverage = function(identifier){
       self$INFO(sprintf("Fetching coverageSummary description for '%s' ...", identifier))
       describeCoverage <- NULL
       cov <- self$capabilities$findCoverageSummaryById(identifier, exact = TRUE)
       if(is(cov, "WFSCoverageSummary")){
         describeCoverage <- cov$getDescription()
       }
       return(describeCoverage)
     }
   )
)

