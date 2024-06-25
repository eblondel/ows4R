#' WPSExecuteResponse
#'
#' @docType class
#' @export
#' @keywords OGC WPS ExecuteResponse
#' @return Object of \code{\link[R6]{R6Class}} for modelling a WPS Execute response
#' @format \code{\link[R6]{R6Class}} object.
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
    #'@field process process
    process = NULL,
    #'@field status status
    status = NULL,
    #'@field statusLocation status location
    statusLocation = NULL,
    #'@field statusHistory status history
    statusHistory = NULL,
    #'@field processOutputs process outputs
    processOutputs = list(),
    #'@field exception exception
    exception = NULL,
    
    #'@description Initializes a \link{WPSExecuteResponse}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param capabilities object of class \link{WPSCapabilities}
    #'@param processDescription process description
    #'@param logger logger
    initialize = function(xml, capabilities, processDescription = NULL, logger = NULL) {
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix, logger = logger) 
      private$xml = xml
      self$INFO("WPS ExecuteResponse:")
      print(xml)
      private$capabilities = capabilities
      private$processDescription = processDescription
      self$decode(xml, capabilities = capabilities, processDescription = processDescription, logger = logger)
    },
    
    #'@description Get process
    #'@return an object of class \link{WPSProcess}
    getProcess = function(){
      return(self$process)
    },
    
    #'@description Get status
    #'@return an object of class \link{WPSStatus}
    getStatus = function(){
      return(self$status)
    },
    
    #'@description Get status location
    #'@return an object of class \code{character}
    getStatusLocation = function(){
      return(self$statusLocation)
    },
    
    #'@description Get status history
    #'@return an object of class \code{character}
    getStatusHistory = function(){
      return(self$statusHistory)
    },
    
    #'@description Get list of process outputs
    #'@return a \code{list} of outputs
    getProcessOutputs = function(){
      return(self$processOutputs)
    },
    
    #'@description Get exception
    #'@return an object of class \link{WPSException}
    getException = function(){
      return(self$exception)
    },
    
    #'@description Decodes an object of class \link{WPSExecuteResponse} from XML
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param capabilities object of class \link{WPSCapabilities}
    #'@param processDescription process description
    #'@param logger logger
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
    
    #'@description Updates status history
    #'@param verbose verbose. Default is \code{FALSE}
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