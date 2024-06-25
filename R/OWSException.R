#' OWSException
#'
#' @docType class
#' @export
#' @keywords OGC exception
#' @return Object of \code{\link[R6]{R6Class}} modelling a OWS Service exception
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSException <- R6Class("OWSException",
  inherit = OGCAbstractObject,                       
  private = list(
    capabilities = NULL,
    url = NA,
    version = NA,
    
    #fetchException
    fetchException = function(xmlObj, version){
      children = xmlChildren(xmlObj)
      text = sapply(children[names(children)=="ExceptionText"], xmlValue)[[1]]
      exception = list(locator = xmlGetAttr(xmlObj, "locator"), code = xmlGetAttr(xmlObj, "exceptionCode"), text = text)
      return(exception)
    }
    
  ),
  public = list(
    
    #'@field ExceptionText exception text
    ExceptionText = NULL,
    
    #'@description Initializes an object of class \link{OWSException}
    #'@param xmlObj object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param logger logger
    initialize = function(xmlObj, logger = NULL){
      super$initialize(logger = logger)
      exception = private$fetchException(xmlObj = xmlObj, version = version)
      self$ExceptionText = exception$text
      self$attrs = list(exceptionCode = exception$code, locator = exception$locator)
    },
    
    #'@description Get exception locator
    #'@return the exception locator, object of class \code{character}
    getLocator = function(){
      return(self$attrs$locator)
    },
    
    #'@description Get exception code
    #'@return the exception code, object of class \code{character}
    getCode = function(){
      return(self$attrs$code)
    },
    
    #'@description Get exception text explanation
    #'@return the exception text, object of class \code{character}
    getText = function(){
      return(self$ExceptionText)
    }
  )
)