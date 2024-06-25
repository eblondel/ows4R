#' WPSProcess
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process
#' @return Object of \code{\link[R6]{R6Class}} modelling a WPS process
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSProcess <- R6Class("WPSProcess",
  inherit = OGCAbstractObject,                       
  private = list(
  
    capabilities = NULL,
    url = NA,
    version = NA,
    
    identifier = NA,
    title = NA,
    processVersion = NA,
    
    #fetchProcess
    fetchProcess = function(xml, version){
      
      children <- xmlChildren(xml)
      
      processIdentifier <- NULL
      if(!is.null(children$Identifier)){
        processIdentifier <- xmlValue(children$Identifier)
      }
      
      processTitle <- NULL
      if(!is.null(children$Title)){
        processTitle <- xmlValue(children$Title)
      }
      
      processVersion <- xmlGetAttr(xml, "wps:processVersion")
      
      process <- list(
        identifier = processIdentifier,
        title = processTitle,
        version = processVersion
      )
      
      return(process)
    }
    
  ),
  public = list(
    
    #'@description Initializes a \link{WPSProcess}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param capabilities object of class \link{WPSCapabilities}
    #'@param version service version
    #'@param logger logger
    #'@param ... any additional parameter
    initialize = function(xml, capabilities = NULL, version, logger = NULL, ...){
      super$initialize(logger = logger)
      
      private$capabilities = capabilities
      private$url = capabilities$getUrl()
      private$version = version
      
      process = private$fetchProcess(xml, version)
      private$identifier = process$identifier
      private$title = process$title
      private$processVersion = process$version
    },
    
    #'@description Get identifier
    #'@return object of class \code{character}
    getIdentifier = function(){
      return(private$identifier)
    },
    
    #'@description Get title
    #'@return object of class \code{character}
    getTitle = function(){
      return(private$title)
    },
    
    #'@description Get version
    #'@return object of class \code{character}
    getVersion = function(){
      return(private$processVersion)
    },
    
    #'@description Get description
    #'@return object of class \link{WPSProcessDescription}
    getDescription = function(){
      op <- NULL
      operations <- private$capabilities$getOperationsMetadata()$getOperations()
      if(length(operations)>0){
        op <- operations[sapply(operations,function(x){x$getName()=="DescribeProcess"})]
        if(length(op)>0){
          op <- op[[1]]
        }else{
          stop("Operation 'DescribeProcess' not supported by this service")
        }
      }
      client = private$capabilities$getClient()
      processDescription <- WPSDescribeProcess$new(capabilities = private$capabilities, op = op, private$url, private$version, private$identifier, 
                                                   user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), headers = client$getHeaders(),
                                                   logger = self$loggerType)
      #exception handling
      if(processDescription$hasException()){
        return(processDescription$getException())
      }
      
      #response handling
      xml <- processDescription$getResponse()
      processDescXML <- xmlChildren(xmlChildren(xml)[[1]])[[1]]
      processDesc <- WPSProcessDescription$new(xml = processDescXML, version = private$version)
      return(processDesc)
    },
    
    #'@description  Execute process
    #'@param dataInputs a named list of data inputs, objects of class \link{WPSLiteralData}, \link{WPSComplexData} or \link{WPSBoundingBoxData}
    #'@param responseForm response form, object of class \link{WPSResponseDocument}
    #'@param storeExecuteResponse store execute response? object of class \code{logical}. \code{FALSE} by default
    #'@param lineage lineage, object of class \code{logical}
    #'@param status status, object of class \code{logical}
    #'@param update update, object of class \code{logical}. For asynchronous requests
    #'@param updateInterval update interval, object of class \code{integer}. For asynchronous requests
    execute = function(dataInputs = list(), responseForm = NULL,
                       storeExecuteResponse = FALSE, lineage = NULL, status = NULL,
                       update = FALSE, updateInterval = 1){
      op <- NULL
      operations <- private$capabilities$getOperationsMetadata()$getOperations()
      if(length(operations)>0){
        op <- operations[sapply(operations,function(x){x$getName()=="Execute"})]
        if(length(op)>0){
          op <- op[[1]]
        }else{
          stop("Operation 'Execute' not supported by this service") #control altough Execute request is mandatory for WPS
        }
      }
      
      client = private$capabilities$getClient()
      processExecute <- WPSExecute$new(capabilities = private$capabilities, op = op, private$url, private$version, private$identifier,
                                       dataInputs = dataInputs, responseForm = responseForm,
                                       storeExecuteResponse = storeExecuteResponse, lineage = lineage, status = lineage,
                                       user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), headers = client$getHeaders(),
                                       logger = self$loggerType)
      #exception handling
      if(processExecute$hasException()){
        return(processExecute$getException())
      }
      
      #response handling
      resp <- NULL
      executeStatus <- processExecute$getStatus()
      if(executeStatus == 200){
        xml <- processExecute$getResponse()
        resp <- WPSExecuteResponse$new(xml = xml, capabilities = private$capabilities, 
                                       processDescription = processExecute$getProcessDescription(),
                                       logger = self$loggerType)
        if(update){
          if(is.null(status) || isFALSE(status)){
            self$WARN("Argument 'update' is ignored because 'status' is not TRUE")
          }
          while(!resp$getStatus()$getValue() %in% c("ProcessSucceeded", "ProcessFailed")){
            Sys.sleep(updateInterval)
            resp <- resp$update(verbose = !is.null(self$loggerType))
          }
          self$INFO("Process status history:")
          print(resp$getStatusHistory())
        }
        
      }else{
        #500
        self$ERROR("Error during WPS execution:")
        xml <- processExecute$getResponse()
        resp <- WPSExecuteResponse$new(xml = xml, capabilities = private$capabilities, 
                                       processDescription = processExecute$getProcessDescription(),
                                       logger = self$loggerType)
      }
      return(resp)
      
    }
  )
)