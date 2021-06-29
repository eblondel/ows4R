#' WPSCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC WPS Capabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Processing Service (WPS) Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on WPS endpoint responding at http://localhost:8000/wps
#'    caps <- WPSCapabilities$new("http://localhost:8000/wps", version = "2.0.2")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, logger, ...)}}{
#'    This method is used to instantiate a WPSCapabilities object
#'  }
#'  \item{\code{getProcesses(pretty)}}{
#'    Return the list of processes offered by the service capabilities.
#'  }
#' }
#' 
#' @note Class used to read a \code{WPSCapabilities} document. The use of \code{WPSClient} is
#' recommended instead to benefit from the full set of capabilities associated to a WPS server.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSCapabilities <- R6Class("WPSCapabilities",
   inherit = OWSCapabilities,
   private = list(
     processes = list(),
     
     #fetchProcesses
     fetchProcesses = function(xmlObj, version){
       wpsNs <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
         if(!is.null(namespaces)) wpsNs <- OWSUtils$findNamespace(namespaces, id = "wps")
       }
       processListXML <- list()
       if(is.null(wpsNs)){
         processListXML <- getNodeSet(xmlObj, "//ProcessOfferings/Process")
       }else{
         processListXML <- getNodeSet(xmlObj, "//ns:ProcessOfferings/ns:Process", wpsNs) 
       }
       processList <- list()
       if(length(processListXML)>0){
         processList <- lapply(processListXML, function(x){
           WPSProcess$new(x, self, version, logger = self$loggerType)
         })
       }
       return(processList)
     }
   ),
   public = list(
     
     #initialize
     initialize = function(url, version, logger = NULL, ...) {
       owsVersion <- switch(version,
                            "1.0.0" = "1.1",
                            "2.0.0" = "2.0"
       )
       super$initialize(url, service = "WPS", owsVersion = owsVersion, serviceVersion = version, 
                        logger = logger, ...)
       xmlObj <- self$getRequest()$getResponse()
       private$processes <- private$fetchProcesses(xmlObj, version)
     },
     
     #getProcesses
     getProcesses = function(pretty = FALSE){
       processes <- private$processes
       if(pretty){
         processes <- do.call("rbind", lapply(processes, function(x){
           return(data.frame(
             identifier = x$getIdentifier(),
             title = x$getTitle(),
             version = x$getVersion(),
             stringsAsFactors = FALSE
           ))
         }))
       }
       return(processes)
     }
   )
)