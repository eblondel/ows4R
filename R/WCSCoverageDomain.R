#' WCSCoverageDomain
#'
#' @docType class
#' @export
#' @keywords OGC WCS Coverage domain
#' @return Object of \code{\link{R6Class}} modelling a WCS coverage domain
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSCoverageDomain <- R6Class("WCSCoverageDomain",
   inherit = OGCAbstractObject,                       
   private = list(
     capabilities = NULL,
     url = NA,
     version = NA,
     
     #fetchDomain
     fetchDomain = function(xmlObj, serviceVersion, owsVersion){
      
       children <- xmlChildren(xmlObj)
       
       #spatialDomain
       spatialDomain <- NULL
       if(startsWith(serviceVersion, "1.0")){
         if("spatialDomain" %in% names(children)){
           spatialDomain <- WCSCoverageSpatialDomain$new(
             xmlObj = children$spatialDomain,
             serviceVersion, owsVersion
           )
         }
       }else if(startsWith(serviceVersion, "1.1")){
         if("SpatialDomain" %in% names(children)){
           spatialDomain <- WCSCoverageSpatialDomain$new(
             xmlObj = children$SpatialDomain,
             serviceVersion, owsVersion
           )
         }
       }
       
       #temporalDomain
       temporalDomain <- NULL
       if(startsWith(serviceVersion, "1.0")){
         if("temporalDomain" %in% names(children)){
           temporalDomain <- WCSCoverageTemporalDomain$new(
             xmlObj = children$temporalDomain,
             serviceVersion, owsVersion
           )
         }
       }else if(startsWith(serviceVersion, "1.1")){
         if("TemporalDomain" %in% names(children)){
           temporalDomain <- WCSCoverageTemporalDomain$new(
             xmlObj = children$TemporalDomain,
             serviceVersion, owsVersion
           )
         }
       }
       
       domain <- list(
         spatialDomain = spatialDomain,
         temporalDomain = temporalDomain
       )
       return(domain)
     }
     
   ),
   public = list(
     #'@field spatialDomain spatial domain
     spatialDomain = NULL,
     #'@field temporalDomain temporal domain
     temporalDomain = NULL,
     
     #'@description Initializes an object of class \link{WCSCoverageDomain}
     #'@param xmlObj an object of class \link{XMLInternalNode-class} to initialize from XML
     #'@param serviceVersion service version
     #'@param owsVersion OWS version
     #'@param logger logger
     initialize = function(xmlObj, serviceVersion, owsVersion, logger = NULL){
       super$initialize(logger = logger)
       domain = private$fetchDomain(xmlObj, serviceVersion, owsVersion)
       self$spatialDomain = domain$spatialDomain
       self$temporalDomain = domain$temporalDomain
     },
     
     #'@description Get spatial domain
     #'@return object of class \link{WCSCoverageSpatialDomain}
     getSpatialDomain = function(){
       return(self$spatialDomain)
     },
     
     #'@description Get spatial domain
     #'@return object of class \link{WCSCoverageTemporalDomain}
     getTemporalDomain = function(){
       return(self$temporalDomain)
     }
     
   )
)