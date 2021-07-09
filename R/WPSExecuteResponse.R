#' WPSExecuteResponse
#'
#' @docType class
#' @export
#' @keywords OGC WPS ExecuteResponse
#' @return Object of \code{\link{R6Class}} for modelling a WPS Execute response
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj)}}{
#'    This method is used to instantiate a WPSExecuteResponse object
#'  }
#'  \item{\code{getProcess()}}{
#'    Get the process
#'  }
#'  \item{\code{getStatus()}}{
#'    Get the status
#'  }
#'  \item{\code{getProcessOutputs()}}{
#'    Get the process output(s)
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSExecuteResponse <- R6Class("WPSExecuteResponse",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "ExecuteResponse",
    xmlNamespace = c(wps = "http://www.opengis.net/wps"),
    xmlObj = NULL
  ),
  public = list(
    process = NULL,
    status = NULL,
    processOutputs = list(),
    initialize = function(xmlObj, capabilities, logger = NULL) {
      private$xmlObj = xmlObj
      self$decode(xmlObj, capabilities = capabilities, logger = logger)
    },
    
    getProcess = function(){
      return(self$process)
    },
    
    getStatus = function(){
      return(self$status)
    },
    
    getProcessOutputs = function(){
      return(self$processOutputs)
    },
    
    #decode
    decode = function(xmlObj, capabilities, logger){
      children <- xmlChildren(xmlChildren(xmlObj)[[1]])
      self$process <- WPSProcess$new(xmlObj = children$Process, capabilities = capabilities, version = xmlGetAttr(xmlChildren(xmlObj)[[1]], "version"), logger = logger)
      #self$status <- WPSStatus$new(xmlObj = children$Status)
      if("ProcessOutputs" %in% names(children)){
        children <- xmlChildren(children$ProcessOutputs)
        outputsXML <- children[names(children) == "Output"]
        self$processOutputs <- lapply(outputsXML, function(x){WPSOutput$new(xmlObj = x)})
        names(self$processOutputs) <- NULL
      }
    },
    
    #
    xml = function(){
      return(private$xmlObj)
    }
  )
)