#' WCSCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC WCS GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Coverage Service Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    WCSCapabilities$new("http://localhost:8080/geoserver/wcs", serviceVersion = "2.0.1")
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSCapabilities <- R6Class("WCSCapabilities",
   inherit = OWSCapabilities,
   private = list(
     xmlElement = "Capabilities",
     xmlNamespacePrefix = "WCS",
     coverageSummaries = NA,
     fetchCoverageSummaries = function(xmlObj, serviceVersion, owsVersion){
       wcsNs <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
         wcsNs <- OWSUtils$findNamespace(namespaces, id = "wcs")
       }
       
       coverageXML <- list()
       if(substr(serviceVersion,1,3)=="1.0"){
         coverageXML <- getNodeSet(xmlObj, "//ns:CoverageOfferingBrief", wcsNs)
       }else{
         coverageXML <- getNodeSet(xmlObj, "//ns:CoverageSummary", wcsNs)
       }
       coverageList <- lapply(coverageXML, function(x){
         covsum <- WCSCoverageSummary$new(x, self, serviceVersion, owsVersion, logger = self$loggerType)
         return(covsum)
       })
       
       return(coverageList)
     }
     
   ),
   public = list(
     
     #'@description Initializes a \link{WCSCapabilities} object
     #'@param url url
     #'@param version version
     #'@param client an object of class \link{WCSClient}
     #'@param logger logger type \code{NULL}, "INFO" or "DEBUG"
     #'@param ... any other parameter to pass to \link{OWSGetCapabilities} service request
     initialize = function(url, version, client = NULL, logger = NULL, ...) {
       owsVersion <- switch(version,
                            "1.0"   = "1.1",
                            "1.0.0" = "1.1",
                            "1.1"   = "1.1",
                            "1.1.0" = "1.1",
                            "1.1.1" = "1.1",
                            "2.0.0" = "2.0",
                            "2.0.1" = "2.0",
                            "2.1.0" = "2.0",
                            NULL
       )
       if(is.null(owsVersion)){
         stop(sprintf("Unknown WCS service version '%s'", version))
       }
       super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                        url, service = "WCS", owsVersion = owsVersion, serviceVersion = version, 
                        client = client, logger = logger, ...)
       xml <- self$getRequest()$getResponse()
       private$coverageSummaries <- private$fetchCoverageSummaries(xml, serviceVersion = version, owsVersion = owsVersion)
     },
     
     #'@description Get coverage summaries
     #'@return a \code{list} of \link{WCSCoverageSummary} objects
     getCoverageSummaries = function(){
       return(private$coverageSummaries)
     },
     
     #'@description Finds a coverage by name
     #'@param expr expr
     #'@param exact exact matching? Default is \code{TRUE}
     findCoverageSummaryById = function(expr, exact = FALSE){
       result <- lapply(private$coverageSummaries, function(x){
         cov <- NULL
         if(exact){
           if(x$getId() == expr) cov <- x
         }else{
           if(attr(regexpr(expr, x$getId()), "match.length") != -1 
              && endsWith(x$getId(), expr)){
             cov <- x
           }
         }                         
         return(cov)
       })
       result <- result[!sapply(result, is.null)]
       if(length(result) == 1) result <- result[[1]]
       return(result)
     }
   )
)