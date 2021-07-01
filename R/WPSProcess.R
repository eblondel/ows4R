#' WPSProcess
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process
#' @return Object of \code{\link{R6Class}} modelling a WPS process
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, capabilities, version, logger)}}{
#'    This method is used to instantiate a \code{WPSProcess} object
#'  }
#'  \item{\code{getIdentifier()}}{
#'    Get process identifier
#'  }
#'  \item{\code{getTitle()}}{
#'    Get process title
#'  }
#'  \item{\code{getVersion()}}{
#'    Get process version
#'  }
#' }
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
    fetchProcess = function(xmlObj, version){
      
      children <- xmlChildren(xmlObj)
      
      processIdentifier <- NULL
      if(!is.null(children$Identifier)){
        processIdentifier <- xmlValue(children$Identifier)
      }
      
      processTitle <- NULL
      if(!is.null(children$Title)){
        processTitle <- xmlValue(children$Title)
      }
      
      processVersion <- xmlGetAttr(xmlObj, "wps:processVersion")
      
      process <- list(
        identifier = processIdentifier,
        title = processTitle,
        version = processVersion
      )
      
      return(process)
    }
    
  ),
  public = list(
    initialize = function(xmlObj, capabilities, version, logger = NULL, ...){
      super$initialize(logger = logger)
      
      private$capabilities = capabilities
      private$url = capabilities$getUrl()
      private$version = version
      
      process = private$fetchProcess(xmlObj, version)
      private$identifier = process$identifier
      private$title = process$title
      private$processVersion = process$version
    },
    
    #getIdentifier
    getIdentifier = function(){
      return(private$identifier)
    },
    
    #getTitle
    getTitle = function(){
      return(private$title)
    },
    
    #getVersion
    getVersion = function(){
      return(private$processVersion)
    },
    
    #getDescription
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
      processDescription <- WPSDescribeProcess$new(op = op, private$url, private$version, private$identifier, 
                                                   user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), headers = client$getHeaders(),
                                                   logger = self$loggerType)
      xmlObj <- processDescription$getResponse()
      processDescXML <- xmlChildren(xmlChildren(xmlObj)[[1]])[[1]]
      processDesc <- WPSProcessDescription$new(xmlObj = processDescXML, version = private$version)
      return(processDesc)
    }
  )
)