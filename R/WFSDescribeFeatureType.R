#' WFSDescribeFeatureType
#'
#' @docType class
#' @export
#' @keywords OGC WFS DescribeFeatureType
#' @return Object of \code{\link{R6Class}} for modelling a WFS DescribeFeatureType request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, typeName)}}{
#'    This method is used to instantiate a WFSDescribeFeatureType object
#'  }
#'  \item{\code{getRequest()}}{
#'    Get DescribeFeatureType request
#'  }
#'  \item{\code{getContent()}}{
#'    Get content
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSDescribeFeatureType <- R6Class("WFSDescribeFeatureType",
  private = list(
    request = NA,
    content = NA,
    
    #buildRequest
    buildRequest = function(url, version, typeName){ 
      namedParams <- list(request = "DescribeFeatureType", version = version, typeName = typeName)
      request <- OWSRequest$new(url, namedParams, "text/xml")
      return(request)
    },
    
    #fetchFeatureTypeDescription
    fetchFeatureTypeDescription = function(xmlObj){
      namespaces <- OWSUtils$getNamespaces(xmlObj)
      xsdNs <- OWSUtils$findNamespace(namespaces, "XMLSchema")
      elementXML <- getNodeSet(xmlObj, "//ns:sequence/ns:element", xsdNs)
      elements <- lapply(elementXML, WFSFeatureTypeElement$new)
      return(elements)
    }
  ),
  public = list(
    initialize = function(url, version, typeName) {
      private$request <- private$buildRequest(url, version, typeName)
      xmlObj <- private$request$response
      private$content = private$fetchFeatureTypeDescription(xmlObj)
    },
    
    #getRequest
    getRequest = function(){
      return(private$request)
    },
    
    #getContent
    getContent = function(){
      return(private$content)
    }
  )
                                  
)