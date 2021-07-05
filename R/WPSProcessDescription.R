#' WPSProcessDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process ProcessDescription
#' @return Object of \code{\link{R6Class}} modelling a WPS process description
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, capabilities, version, logger)}}{
#'    This method is used to instantiate a \code{WPSProcessDescription} object
#'  }
#'  \item{\code{getIdentifier()}}{
#'    Get process identifier
#'  }
#'  \item{\code{getTitle()}}{
#'    Get process title
#'  }
#'  \item{\code{getAbstract()}}{
#'    Get process abstract
#'  }
#'  \item{\code{getVersion()}}{
#'    Get process version
#'  }
#'  \item{\code{isStatusSupported()}}{
#'    Get whether status is supported
#'  }
#'  \item{\code{isStoreSupported()}}{
#'    Get whether store is supported
#'  }
#'  \item{\code{getDataInputs()}}{
#'    Get data inputs
#'  }
#'  \item{\code{getProcessOutputs()}}{
#'    Get process outputs
#'  }
#'  \item{\code{asDataFrame()}}{
#'    Get process description as data.frame
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSProcessDescription <- R6Class("WPSProcessDescription",
  inherit = OGCAbstractObject,                       
  private = list(
    
    capabilities = NULL,
    url = NA,
    version = NA,
    
    identifier = NA,
    title = NA,
    abstract= NA,
    processVersion = NA,
    statusSupported = FALSE,
    storeSupported = FALSE,
    dataInputs = list(),
    processOutputs = list(),
    
    #fetchProcessDescription
    fetchProcessDescription = function(xmlObj, version){
      
      children <- xmlChildren(xmlObj)
      
      processIdentifier <- NULL
      if(!is.null(children$Identifier)){
        processIdentifier <- xmlValue(children$Identifier)
      }
      
      processTitle <- NULL
      if(!is.null(children$Title)){
        processTitle <- xmlValue(children$Title)
      }
      
      processAbstract <- NULL
      if(!is.null(children$Abstract)){
        processAbstract <- xmlValue(children$Abstract)
      }
      
      processVersion <- xmlGetAttr(xmlObj, "wps:processVersion")
      statusAttr <- xmlGetAttr(xmlObj, "statusSupported")
      if(!is.null(statusAttr)) statusSupported <- statusAttr == "true"
      storeAttr <- xmlGetAttr(xmlObj, "storeSupported")
      if(!is.null(storeAttr)) storeSupported <- storeAttr == "true"
      
      dataInputsXML <- xmlChildren(children$DataInputs)
      dataInputsXML <- dataInputsXML[names(dataInputsXML)=="Input"]
      dataInputs <- lapply(dataInputsXML, function(x){
        input_binding <- NULL
        if("LiteralData" %in% names(xmlChildren(x))){
          input_binding = WPSLiteralInputDescription$new(xmlObj = x, version = version)
        }else if("ComplexData" %in% names(xmlChildren(x))){
          input_binding = WPSComplexInputDescription$new(xmlObj = x, version = version)
        }else if("BoundingBoxData" %in% names(xmlChildren(x))){
          #TODO
        }
        return(input_binding)
      })
      names(dataInputs) <- NULL
      dataInputs <- dataInputs[!sapply(dataInputs, is.null)]
      
      processOutputsXML <- xmlChildren(children$ProcessOutputs)
      processOutputsXML <- processOutputsXML[names(processOutputsXML)=="Output"]
      processOutputs <- lapply(processOutputsXML, function(x){
        output_binding <- NULL
        if("LiteralOutput" %in% names(xmlChildren(x))){
          output_binding = WPSLiteralOutputDescription$new(xmlObj = x, version = version)
        }else if("ComplexOutput" %in% names(xmlChildren(x))){
          output_binding = WPSComplexOutputDescription$new(xmlObj = x, version = version)
        }else if("BoundingBoxOutput" %in% names(xmlChildren(x))){
          #TODO
        }
        return(output_binding)
      })
      names(processOutputs)
      processOutputs <- processOutputs[!sapply(processOutputs, is.null)]
      
      processDescription <- list(
        identifier = processIdentifier,
        title = processTitle,
        abstract = processAbstract,
        version = processVersion,
        statusSupported = statusSupported,
        storeSupported = storeSupported,
        dataInputs = dataInputs,
        processOutputs = processOutputs
      )
      
      return(processDescription)
    }
    
  ),
  public = list(
    initialize = function(xmlObj, version, logger = NULL, ...){
      super$initialize(logger = logger)
      private$version = version
      
      processDesc = private$fetchProcessDescription(xmlObj, version)
      private$identifier = processDesc$identifier
      private$title = processDesc$title
      private$abstract = processDesc$abstract
      private$processVersion = processDesc$version
      private$statusSupported = processDesc$statusSupported
      private$storeSupported = processDesc$storeSupported
      private$dataInputs = processDesc$dataInputs
      private$processOutputs = processDesc$processOutputs
    },
    
    #getIdentifier
    getIdentifier = function(){
      return(private$identifier)
    },
    
    #getTitle
    getTitle = function(){
      return(private$title)
    },
    
    #getAbstract
    getAbstract = function(){
      return(private$abstract)
    },
    
    #getVersion
    getVersion = function(){
      return(private$processVersion)
    },
    
    #isStatusSupported
    isStatusSupported = function(){
      return(private$statusSupported)
    },
    
    #isStoreSupported
    isStoreSupported = function(){
      return(private$storeSupported)
    },
    
    #getDataInputs
    getDataInputs = function(){
      return(private$dataInputs)
    },
    
    #getProcessOutputs
    getProcessOutputs = function(){
      return(private$processOutputs)
    },
    
    #asDataFrame
    asDataFrame = function(){
      return(data.frame(
        identifier = self$getIdentifier(),
        title = self$getTitle(),
        abstract = self$getAbstract(),
        processVersion = self$getVersion(),
        statusSupported = self$isStatusSupported(),
        storeSupported = self$isStoreSupported(),
        stringsAsFactors = FALSE
      ))
    }
  )
)