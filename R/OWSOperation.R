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
#'  \item{\code{getName()}}{
#'    Get name
#'  }
#'  \item{\code{getParameters()}}{
#'    Get the list of parameters
#'  }
#'  \item{\code{getParameter(name)}}{
#'    Get a given parameter
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
      namespaces <- OWSUtils$getNamespaces(xmlDoc(xmlObj))
      ns <- OWSUtils$findNamespace(namespaces, "ows")
      private$name <- xmlGetAttr(xmlObj, "name")
      paramXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Parameter", ns)
      private$parameters <- lapply(paramXML, function(x){
        param <- unique(xpathSApply(xmlDoc(x), "//ns:Value", fun = xmlValue, namespaces = ns))
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
    },
    
    #getParameter
    getParameter = function(name){
      return(private$parameters[[name]])
    }
  )
)