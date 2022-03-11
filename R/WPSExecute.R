#' WPSExecute
#'
#' @docType class
#' @export
#' @keywords OGC WPS Execute
#' @return Object of \code{\link{R6Class}} for modelling a WPS Execute request
#' @format \code{\link{R6Class}} object.
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WPS Execute request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSExecute <- R6Class("WPSExecute",
  inherit = OWSHttpRequest,
  private = list(
    xmlElement = "Execute",
    xmlNamespacePrefix = "WPS",
    processDescription = NULL
  ),
  public = list(
    #'@field Identifier process identifier
    Identifier = "",
    #'@field DataInputs list of \link{WPSInput}
    DataInputs = list(),
    #'@field ResponseForm response form
    ResponseForm = NULL,
    
    #'@description  Initializes a \link{WPSExecute} service request
    #'@param capabilities object of class \link{WPSCapabilities}
    #'@param op object of class \link{OWSOperation}
    #'@param url url
    #'@param serviceVersion WPS service version
    #'@param identifier process identifier
    #'@param dataInputs a named list of data inputs, objects of class \link{WPSLiteralData}, \link{WPSComplexData} or \link{WPSBoundingBoxData}
    #'@param responseForm response form, object of class \link{WPSResponseDocument}
    #'@param storeExecuteResponse store execute response? object of class \code{logical}. \code{FALSE} by default
    #'@param lineage lineage, object of class \code{logical}
    #'@param status status, object of class \code{logical}
    #'@param user user
    #'@param pwd password
    #'@param token token
    #'@param headers headers
    #'@param config config
    #'@param logger logger
    #'@param ... any other parameter to pass to the request
    initialize = function(capabilities, op, url, serviceVersion, identifier, 
                          dataInputs = list(), responseForm = NULL,
                          storeExecuteResponse = FALSE, lineage = NULL, status = NULL,
                          user = NULL, pwd = NULL, token = NULL, headers = c(), config = httr::config(),
                          logger = NULL, ...) {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      namedParams <- list(service = "WPS", version = serviceVersion)
      super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix,
                       capabilities, op, "POST", sprintf("%s?service=WPS", url), request = "Execute",
                       user = user, pwd = pwd, token = token, headers = headers, config = config,
                       namedParams = namedParams, mimeType = "text/xml", logger = logger,
                       ...)
      self$wrap <- TRUE
      self$attrs <- namedParams
      
      #get process description
      desc <- capabilities$describeProcess(identifier = identifier)
      private$processDescription <- desc
      
      #Identifier
      self$Identifier <- OWSCodeType$new(value = identifier, owsVersion = capabilities$getOWSVersion())
      dataInputNames <- names(dataInputs)
      #DataInputs
      self$DataInputs <- lapply(dataInputNames, function(dataInputName){
        #check parameters vs process description
        descDataInput <- desc$getDataInputs()[sapply(desc$getDataInputs(), function(x){x$getIdentifier() == dataInputName})]
        if(length(descDataInput)==0){
          errMsg <- sprintf("No parameter '%s' for process '%s'. Allowed parameters are [%s]",
                            dataInputName, identifier, paste0(sapply(desc$getDataInputs(), function(x){x$getIdentifier()}), collapse=","))
          self$ERROR(errMsg)
          stop(errMsg)
        }
        descDataInput <- descDataInput[[1]]
        
        dataInput <- dataInputs[[dataInputName]]
        #check parameter validity vs. parameter description
        dataInput$checkValidity(descDataInput)
        
        WPSInput$new(identifier = dataInputName, data = dataInput, serviceVersion = serviceVersion)
      })
      #ResponseForm
      if(is.null(responseForm)){
        output <- NULL
        if(length(desc$getProcessOutputs())>0){
          output <- WPSOutput$new(identifier = desc$getProcessOutputs()[[1]]$getIdentifier())
        }
        responseForm <- WPSResponseDocument$new(
          output = output,
          storeExecuteResponse = storeExecuteResponse,
          lineage = lineage,
          status = status
        )
      }else{
        if(!is(responseForm, "WPSResponseDocument")){
          errMsg <- "The argument 'responseForm' should be an object of class 'WPSResponseDocument"
          stop(errMsg)
        }
      }
      self$ResponseForm <- responseForm
      self$execute()
    },
    
    #'@description Get process description
    #'@return an object of class \link{WPSProcessDescription}
    getProcessDescription = function(){
      return(private$processDescription)
    }
  )
)