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
#'  \item{\code{getStatusLocation()}}{
#'    Get the status location
#'  }
#'  \item{\code{getProcessOutputs()}}{
#'    Get the process output(s)
#'  }
#'  \item{\code{decode()}}{
#'    Decodes WPS Execute response from XML
#'  }
#'  \item{\code{update(verbose)}}{
#'    Updates the status based on the execute status location.
#'    Returns an object of class \code{WPSExecuteResponse}
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
    xmlNamespacePrefix = "WPS",
    capabilities = NULL,
    processDescription = NULL
  ),
  public = list(
    process = NULL,
    status = NULL,
    statusLocation = NULL,
    statusHistory = NULL,
    processOutputs = list(),
    exception = NULL,
    initialize = function(xml, capabilities, processDescription = NULL, logger = NULL) {
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix, logger = logger) 
      private$xml = xml
      self$INFO("WPS ExecuteResponse:")
      print(xml)
      private$capabilities = capabilities
      private$processDescription = processDescription
      self$decode(xml, capabilities = capabilities, processDescription = processDescription, logger = logger)
    },
    
    #getProcess
    getProcess = function(){
      return(self$process)
    },
    
    #getStatus
    getStatus = function(){
      return(self$status)
    },
    
    #getStatusLocation
    getStatusLocation = function(){
      return(self$statusLocation)
    },
    
    #getStatusHistory
    getStatusHistory = function(){
      return(self$statusHistory)
    },
    
    #getProcessOutputs
    getProcessOutputs = function(){
      return(self$processOutputs)
    },
    
    #getException
    getException = function(){
      return(self$exception)
    },
    
    #decode
    decode = function(xml, capabilities, processDescription, logger){
      children <- xmlChildren(xmlChildren(xml)[[1]])
      self$process <- WPSProcess$new(xml = children$Process, capabilities = capabilities, version = xmlGetAttr(xmlChildren(xml)[[1]], "version"), logger = logger)
     
      #statusLocation
      statusLocation <- xmlGetAttr(xmlRoot(xml), "statusLocation")
      if(!is.null(statusLocation)) self$statusLocation <- statusLocation
      
      #status
      if("Status" %in% names(children)){
        self$status <- WPSStatus$new(xml = children$Status)
        self$statusHistory <- data.frame(
          creationTime = self$status$getCreationTime(),
          sysTime = Sys.time(),
          status = self$status$getValue(),
          percentCompleted = self$status$getPercentCompleted(),
          stringsAsFactors = F
        )
      }
      
      #process outputs
      if("ProcessOutputs" %in% names(children)){
        children <- xmlChildren(children$ProcessOutputs)
        outputsXML <- children[names(children) == "Output"]
        self$processOutputs <- lapply(1:length(outputsXML), function(i){
          outputXML <- outputsXML[[i]]
          dataType <- NULL
          if(!is.null(processDescription)){
            processDescOutputs <- processDescription$getProcessOutputs()
            if(length(processDescOutputs)>0){
              processDescOutput <- processDescOutputs[[i]]
              dataType <- processDescOutput$getDataType()
            }
          }
          WPSOutput$new(xml = outputXML, dataType = dataType)
        })
        names(self$processOutputs) <- NULL
      }
      
      #exception?
      if("Exception" %in% names(children)){
        exceptionXML <- children[names(children) == "Exception"]
        self$exception <- exceptionXML
      }
    },
    
    #update
    update = function(verbose = FALSE){
      
      if(!private$processDescription$isStoreSupported()){
        errMsg <- "The WPS ExecuteResponse 'update' method is not available, because process 'storeSupported' is FALSE"
        self$ERROR(errMsg)
        stop(errMsg)
      }
      if(!private$processDescription$isStatusSupported()){
        errMsg <- "The WPS ExecuteResponse 'update' method is not available, because process 'statusSupported' is FALSE"
        self$ERROR(errMsg)
        stop(errMsg)
      }
      
      if(is.null(self$getStatusLocation())){
        self$WARN("No status location for the WPS request. Skip update...")
        return(self)
      }
      client = private$capabilities$getClient()
      
      self$INFO(sprintf("Getting status location at '%s'", self$getStatusLocation()))
      statusLocation_req <- OWSHttpRequest$new(
        element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
        capabilities = private$xml, NULL, "GET", self$getStatusLocation(), request = NULL,
        user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), headers = client$getHeaders(), 
        namedParams = NULL, attrs = NULL,
        contentType = "text/xml", mimeType = "text/xml",
        logger = if(verbose) self$loggerType else NULL
      )
      statusLocation_req$execute()
      if(statusLocation_req$getStatus() != 200){
        errMsg <- sprintf("Error while getting updated status at '%s'", self$getStatusLocation())
        self$ERROR(errMsg)
        stop(errMsg)
      }else{
        resp <- WPSExecuteResponse$new(xml = statusLocation_req$getResponse(), capabilities = private$capabilities, 
                                       processDescription = private$processDescription,
                                       logger = if(verbose) self$loggerType else NULL)
        resp$statusHistory <- unique(rbind(self$statusHistory, resp$statusHistory))
        return(resp)
      }
      return(self)
    }
  )
)