#' WPSCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC WPS Capabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Processing Service (WPS) Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, logger, ...)}}{
#'    This method is used to instantiate a WPSCapabilities object
#'  }
#'  \item{\code{getProcesses(pretty, full)}}{
#'    Return the list of processes offered by the service capabilities. \code{pretty} allows to control
#'    the type output. If \code{TRUE}, a \code{data.frame} will be returned. When prettified output, it
#'    is also possible to get a 'full' description of the process by setting \code{full = TRUE} in which 
#'    case a the WPS client will request a process description (with more information about the process) for
#'    each process listed in the capabilities.
#'  }
#'  \item{\code{describeProcess(identifier)}}{
#'    Get the description of a process, given its \code{identifier}, returning an object of class \code{WPSProcessDescription}
#'  }
#'  \item{\code{execute(identifier, dataInputs, responseForm, storeExecuteResponse, lineage, status,
#'                      update, updateInterval)}}{
#'    Execute a process, given its \code{identifier}
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
     xmlElement = "Capabilities",
     xmlNamespacePrefix = "WPS",
     processes = list(),
     
     #fetchProcesses
     fetchProcesses = function(xml, version){
       wpsNs <- NULL
       if(all(class(xml) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xml)
         if(!is.null(namespaces)) wpsNs <- OWSUtils$findNamespace(namespaces, id = "wps")
       }
       processListXML <- list()
       if(is.null(wpsNs)){
         processListXML <- getNodeSet(xml, "//ProcessOfferings/Process")
       }else{
         processListXML <- getNodeSet(xml, "//ns:ProcessOfferings/ns:Process", wpsNs) 
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
     initialize = function(url, version, client = NULL, logger = NULL, ...) {
       owsVersion <- switch(version,
                            "1.0.0" = "1.1",
                            "2.0.0" = "2.0"
       )
       super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                        url, service = "WPS", owsVersion = owsVersion, serviceVersion = version, 
                        client = client, logger = logger, ...)
       xml <- self$getRequest()$getResponse()
       private$processes <- private$fetchProcesses(xml, version)
     },
     
     #getProcesses
     getProcesses = function(pretty = FALSE, full = FALSE){
       processes <- private$processes
       if(pretty){
         processes <- do.call("rbind", lapply(processes, function(x){
           desc <- data.frame(
             identifier = x$getIdentifier(),
             title = x$getTitle(),
             version = x$getVersion(),
             stringsAsFactors = FALSE
           )
           if(full) desc <- x$getDescription()$asDataFrame()
           return(desc)
         }))
       }
       return(processes)
     },
     
     #describeProcess
     describeProcess = function(identifier){
        processes <- self$getProcesses()
        processes <- processes[sapply(processes, function(process){process$getIdentifier() == identifier})]
        if(length(processes)==0){
           errMsg <- sprintf("There is no process with identifier '%s'", identifier)
           self$ERROR(errMsg)
           stop(errMsg)
        }
        process <- processes[[1]]
        return(process$getDescription())
     },
     
     #execute
     execute = function(identifier, dataInputs = list(), responseForm = NULL,
                        storeExecuteResponse = FALSE, lineage = NULL, status = NULL,
                        update = FALSE, updateInterval = 1){
        processes <- self$getProcesses()
        processes <- processes[sapply(processes, function(process){process$getIdentifier() == identifier})]
        if(length(processes)==0){
           errMsg <- sprintf("There is no process with identifier '%s'", identifier)
           self$ERROR(errMsg)
           stop(errMsg)
        }
        process <- processes[[1]]
        return(process$execute(dataInputs = dataInputs, responseForm = responseForm,
                               storeExecuteResponse = storeExecuteResponse, lineage = lineage, status = status,
                               update = update, updateInterval = updateInterval))
     }
   )
)