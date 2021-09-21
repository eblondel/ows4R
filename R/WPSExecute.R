#' WPSExecute
#'
#' @docType class
#' @export
#' @keywords OGC WPS Execute
#' @return Object of \code{\link{R6Class}} for modelling a WPS Execute request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(capabilities, op, url, serviceVersion, identifier, logger, ...)}}{
#'    This method is used to instantiate a WPSExecute object
#'  }
#'  \item{\code{getProcessDescription()}}{
#'    Get process description
#'  }
#' }
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
    Identifier = "",
    DataInputs = list(),
    ResponseForm = NULL,
    initialize = function(capabilities, op, url, serviceVersion, identifier, 
                          dataInputs = list(), responseForm = NULL,
                          logger = NULL, ...) {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      namedParams <- list(service = "WPS", version = serviceVersion)
      super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix,
                       capabilities, op, "POST", sprintf("%s?service=WPS", url), request = "Execute",
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
        dataInput <- dataInputs[[dataInputName]]
        WPSInput$new(identifier = dataInputName, data = dataInput, serviceVersion = serviceVersion)
      })
      #ResponseForm
      if(is.null(responseForm)){
        output <- NULL
        if(length(desc$getProcessOutputs())>0){
          output <- WPSOutput$new(identifier = desc$getProcessOutputs()[[1]]$getIdentifier())
        }
        responseForm <- WPSResponseDocument$new(output = output)
      }else{
        if(!is(responseForm, "WPSResponseDocument")){
          errMsg <- "The argument 'responseForm' should be an object of class 'WPSResponseDocument"
          stop(errMsg)
        }
      }
      self$ResponseForm <- responseForm
      self$execute()
    },
    
    #getProcessDescription
    getProcessDescription = function(){
      return(private$processDescription)
    }
  )
)