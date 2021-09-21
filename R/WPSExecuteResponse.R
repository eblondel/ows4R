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
#'  \item{\code{new(xml)}}{
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
#'  \item{\code{decode()}}{
#'    Decodes WPS Execute response from XML
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSExecuteResponse <- R6Class("WPSExecuteResponse",
  inherit = OGCAbstractObject,
  private = list(
    xml = NULL,
    xmlElement = "ExecuteResponse",
    xmlNamespace = c(wps = "http://www.opengis.net/wps")
  ),
  public = list(
    process = NULL,
    status = NULL,
    processOutputs = list(),
    initialize = function(xml, capabilities, processDescription = NULL, logger = NULL) {
      private$xml = xml
      self$decode(xml, capabilities = capabilities, processDescription = processDescription, logger = logger)
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
    decode = function(xml, capabilities, processDescription, logger){
      children <- xmlChildren(xmlChildren(xml)[[1]])
      self$process <- WPSProcess$new(xml = children$Process, capabilities = capabilities, version = xmlGetAttr(xmlChildren(xml)[[1]], "version"), logger = logger)
      #TODO self$status <- WPSStatus$new(xml = children$Status)
      if("ProcessOutputs" %in% names(children)){
        children <- xmlChildren(children$ProcessOutputs)
        outputsXML <- children[names(children) == "Output"]
        self$processOutputs <- lapply(1:length(outputsXML), function(i){
          outputXML <- outputsXML[[i]]
          dataType <- NULL
          if(!is.null(processDescription)){
            processOutput <- processDescription$getProcessOutputs()[[i]]
            dataType <- processOutput$getDataType()
          }
          WPSOutput$new(xml = outputXML, dataType = dataType)
        })
        names(self$processOutputs) <- NULL
      }
    }
  )
)