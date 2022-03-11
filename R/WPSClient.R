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
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSClient <- R6Class("WPSClient",
   inherit = OWSClient,
   private = list(
     serviceName = "WPS"
   ),
   public = list(
      #'@description This method is used to instantiate a \link{WPSClient} with the \code{url} of the
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
      #'@param config config
      #'@param cas_url Central Authentication Service (CAS) URL
      #'@param logger logger
      initialize = function(url, serviceVersion = NULL, 
                           user = NULL, pwd = NULL, token = NULL, headers = c(), config = httr::config(), cas_url = NULL,
                           logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion = serviceVersion, 
                        user = user, pwd = pwd, token = token, headers = headers, config = config, cas_url = cas_url, 
                        logger = logger)
       self$capabilities = WPSCapabilities$new(self$url, self$version, 
                                               user = user, pwd = pwd, token = token, headers = headers, config = config,
                                               logger = logger)
       self$capabilities$setClient(self)
     },
     
     #'@description Get WPS capabilities
     #'@return an object of class \link{WPSCapabilities}
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #'@description Reloads WPS capabilities
     reloadCapabilities = function(){
       self$capabilities = WPSCapabilities$new(self$url, self$version, 
                                               user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), 
                                               headers = self$getHeaders(), config = self$getConfig(),
                                               logger = self$loggerType)
       self$capabilities$setClient(self)
     },
     
     #'@description Get the list of processes offered by the service capabilities. \code{pretty} allows to control
     #'    the type output. If \code{TRUE}, a \code{data.frame} will be returned. When prettified output, it
     #'    is also possible to get a 'full' description of the process by setting \code{full = TRUE} in which 
     #'    case a the WPS client will request a process description (with more information about the process) for
     #'    each process listed in the capabilities.
     #' @param pretty pretty
     #' @param full full
     #' @return a \code{list} of \link{WPSProcessDescription} or a \code{data.frame}
     getProcesses = function(pretty = FALSE, full = FALSE){
       return(self$capabilities$getProcesses(pretty = pretty, full = full))
     },
     
     #'@description Get the description of a process, given its \code{identifier}, returning an object of class \code{WPSProcessDescription}
     #'@param identifier process identifier
     #'@return an object of class \link{WPSProcessDescription}
     describeProcess = function(identifier){
        return(self$capabilities$describeProcess(identifier = identifier))
     },
     
     #'@description  Execute a process, given its \code{identifier}
     #'@param identifier process identifier
     #'@param dataInputs a named list of data inputs, objects of class \link{WPSLiteralData}, \link{WPSComplexData} or \link{WPSBoundingBoxData}
     #'@param responseForm response form, object of class \link{WPSResponseDocument}
     #'@param storeExecuteResponse store execute response? object of class \code{logical}. \code{FALSE} by default
     #'@param lineage lineage, object of class \code{logical}
     #'@param status status, object of class \code{logical}
     #'@param update update, object of class \code{logical}. For asynchronous requests
     #'@param updateInterval update interval, object of class \code{integer}. For asynchronous requests
     execute = function(identifier, dataInputs = list(), responseForm = NULL,
                        storeExecuteResponse = FALSE, lineage = NULL, status = NULL,
                        update = FALSE, updateInterval = 1){
        return(self$capabilities$execute(identifier = identifier, dataInputs = dataInputs, 
                                         responseForm = responseForm, storeExecuteResponse = storeExecuteResponse, 
                                         lineage = lineage, status = status,
                                         update = update, updateInterval = updateInterval))
     }
     
   )
)

