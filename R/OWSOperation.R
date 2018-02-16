#' OWSOperation
#'
#' @docType class
#' @export
#' @keywords OGC OWS operation
#' @return Object of \code{\link{R6Class}} for modelling an OGC Operation
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, service, version)}}{
#'    This method is used to instantiate an OWSOperation object
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSOperation <-  R6Class("OWSOperation",
  private = list(
    name = NA,
    parameters = list()
  ),
  public = list(
    initialize = function(xmlObj, service, version){
      private$name <- xmlGetAttr(xmlObj, "name")
      paramXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Parameter", ns)
      private$parameters <- lapply(paramXML, function(x){
        param <- xpathSApply(x, "//ns:Value", fun = xmlValue, namespaces = ns)
        return(param)
      })
      names(private$parameters) <- sapply(paramXML, xmlGetAttr, "name")
    },
    
    #getName
    getName = function(){
      return(private$name)
    },
    
    #getParameters
    getParameters = function(){
      return(private$parameters)
    }
  )
)