#' OWSNamespace
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords OWS namespace
#' @return Object of \code{\link{R6Class}} for modelling an OWS Namespace
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(id, uri)}}{
#'    This method is used to instantiate an OWS namespace
#'  }
#' }
#' 
#' @note class used internally by ows4R for specifying XML namespaces
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSNamespace <- R6Class("OWSNamespace",
  public = list(
    id = NA,
    uri = NA,
    initialize = function(id, uri){
      self$id = id
      self$uri = uri
    },
    getDefinition = function(){
      ns <- list(self$uri)
      names(ns) <- self$id
      return(ns)
    }
  )
)
OWSNamespace$CSW_2_0_2 = OWSNamespace$new("csw", "http://www.opengis.net/cat/csw/2.0.2")
OWSNamespace$CSW_3_0 = OWSNamespace$new("csw30", "http://www.opengis.net/cat/csw/3.0")
OWSNamespace$FES = OWSNamespace$new("fes", "http://www.opengis.net/fes/2.0")
OWSNamespace$OGC <- OWSNamespace$new("ogc", "http://www.opengis.net/ogc")
OWSNamespace$OWS <- OWSNamespace$new("ows", "http://www.opengis.net/ows")
OWSNamespace$OWS_1_1 = OWSNamespace$new("ows", "http://www.opengis.net/ows/1.1")
OWSNamespace$WMS_1_0_0 = OWSNamespace$new("wms", "http://www.opengis.net/wms")
OWSNamespace$WMS_1_1_0 = OWSNamespace$new("wms", "http://www.opengis.net/wms")
OWSNamespace$WMS_1_1_1 = OWSNamespace$new("wms", "http://www.opengis.net/wms")
OWSNamespace$WMS_1_3_0 = OWSNamespace$new("wms", "http://www.opengis.net/wms")
OWSNamespace$WPS_1_0_0 = OWSNamespace$new("wps", "http://www.opengis.net/wps/1.0.0")
OWSNamespace$XLINK = OWSNamespace$new("xlink", "http://www.w3.org/1999/xlink")
OWSNamespace$XSI = OWSNamespace$new("xsi", "http://www.w3.org/2001/XMLSchema-instance")

#' setOWSNamespaces
#' @export
setOWSNamespaces <- function(){
  .ows4R$namespaces <- list(
    OWSNamespace$CSW_2_0_2,
    OWSNamespace$CSW_3_0,
    OWSNamespace$FES,
    OWSNamespace$OGC,
    OWSNamespace$OWS,
    OWSNamespace$OWS_1_1,
    OWSNamespace$WMS_1_0_0,
    OWSNamespace$WMS_1_1_0,
    OWSNamespace$WMS_1_1_1,
    OWSNamespace$WMS_1_3_0,
    OWSNamespace$WPS_1_0_0,
    OWSNamespace$XLINK,
    OWSNamespace$XSI
  )
}

#' @name getOWSNamespaces
#' @aliases getOWSNamespaces
#' @title getOWSNamespaces
#' @export
#' @description \code{getOWSNamespaces} gets the list of namespaces registered
#' 
#' @usage getOWSNamespaces()
#' 
#' @examples             
#'   getOWSNamespaces()
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#
getOWSNamespaces = function(){
  return(.ows4R$namespaces)
}

#' @name getOWSNamespace
#' @aliases getOWSNamespace
#' @title getOWSNamespace
#' @export
#' @description \code{getOWSNamespace} gets a namespace given its id
#' 
#' @usage getOWSNamespace(id)
#' 
#' @param id namespace prefix
#' 
#' @examples             
#'   getOWSNamespace("GMD")
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#
getOWSNamespace = function(id){
  return(OWSNamespace[[id]])
}

#' @name registerOWSNamespace
#' @aliases registerOWSNamespace
#' @title registerOWSNamespace
#' @export
#' @description \code{registerOWSNamespace} allows to register a new namespace
#' in \pkg{ows4R}
#' 
#' @usage registerOWSNamespace(id, uri, force)
#' 
#' @param id prefix of the namespace
#' @param uri URI of the namespace
#' @param force logical parameter indicating if registration has be to be forced
#' in case the identified namespace is already registered
#' 
#' @examples             
#'   registerOWSNamespace(id = "myprefix", uri = "http://someuri")
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#
registerOWSNamespace <- function(id, uri, force = FALSE){
  ns <- getOWSNamespace(toupper(id))
  if(!is.null(ns)){
    if(!force) stop(sprintf("OWSNamespace with id '%s' already exists. Use force = TRUE to force registration", id))
    ns <- OWSNamespace$new(id, uri)
    OWSNamespace[[toupper(id)]] <- ns
    .ows4R$namespaces[sapply(.ows4R$namespaces, function(x){x$id == id})][[1]] <- ns
  }else{
    ns <- OWSNamespace$new(id, uri)
    OWSNamespace[[toupper(id)]] <- ns
    .ows4R$namespaces <- c(.ows4R$namespaces, ns)
  }
}