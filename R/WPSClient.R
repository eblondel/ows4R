#' WPSClient
#'
#' @docType class
#' @export
#' @keywords OGC WPS Processing Process
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Processing Service.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on a WPS endpoint responding at http://localhost:8080/geoserver/wps
#'    wps <- WPSClient$new("http://localhost:8080/geoserver/wps", serviceVersion = "1.0.0")
#'    
#'    #get capabilities
#'    caps <- wps$getCapabilities()
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, serviceVersion, user, pwd, logger)}}{
#'    This method is used to instantiate a WPSClient with the \code{url} of the
#'    OGC service. Authentication is supported using basic auth (using \code{user}/\code{pwd} arguments), 
#'    bearer token (using \code{token} argument), or custom (using \code{headers} argument). By default, the \code{logger}
#'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
#'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
#'  }
#'  \item{\code{getCapabilities()}}{
#'    Get service capabilities. Inherited from OWS Client
#'  }
#'  \item{\code{reloadCapabilities()}}{
#'    Reload service capabilities
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
#'  \item{\code{execute(identifier, dataInputs, responseForm, language)}}{
#'    Execute a process
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSClient <- R6Class("WPSClient",
   inherit = OWSClient,
   private = list(
     serviceName = "WPS"
   ),
   public = list(
     #initialize
     initialize = function(url, serviceVersion = NULL, 
                           user = NULL, pwd = NULL, token = NULL, headers = c(),
                           logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion, user, pwd, token, headers, logger)
       self$capabilities = WPSCapabilities$new(self$url, self$version, 
                                               user = user, pwd = pwd, token = token, headers = headers,
                                               logger = logger)
       self$capabilities$setClient(self)
     },
     
     #getCapabilities
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #reloadCapabilities
     reloadCapabilities = function(){
       self$capabilities = WPSCapabilities$new(self$url, self$version, 
                                               user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                               logger = self$loggerType)
       self$capabilities$setClient(self)
     },
     
     #getProcesses
     getProcesses = function(pretty = FALSE, full = FALSE){
       return(self$capabilities$getProcesses(pretty = pretty, full = full))
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
     execute = function(identifier, request, dataInputs, responseForm, language){
        processes <- self$getProcesses()
        processes <- processes[sapply(processes, function(process){process$getIdentifier() == identifier})]
        if(length(processes)==0){
           errMsg <- sprintf("There is no process with identifier '%s'", identifier)
           self$ERROR(errMsg)
           stop(errMsg)
        }
        process <- processes[[1]]
        return(process$execute(dataInputs, request, responseForm, language))
     }
     
   )
)

