#' WFSCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC WFS GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Feature Service Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on WMS endpoint responding at http://localhost:8080/geoserver/wfs
#'    caps <- WFSCapabilities$new("http://localhost:8080/geoserver/wfs", version = "1.1.1")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version)}}{
#'    This method is used to instantiate a WFSGetCapabilities object
#'  }
#'  \item{\code{getFeatureTypes(pretty)}}{
#'    List the feature types available. If \code{pretty} is TRUE,
#'    the output will be an object of class \code{data.frame}
#'  }
#'  \item{\code{findFeatureTypeByName(name, exact)}}{
#'    Find feature type(s) by name.
#'  }
#' }
#' 
#' @note Class used to read a \code{WFSCapabilities} document. The use of \code{WFSClient} is
#' recommended instead to benefit from the full set of capabilities associated to a WFS server.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSCapabilities <- R6Class("WFSCapabilities",
   inherit = OWSCapabilities,
   private = list(
     
     featureTypes = NA,

     #fetchFeatureTypes
     fetchFeatureTypes = function(xmlObj, version){
       
       wfsNs <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
         wfsNs <- OWSUtils$findNamespace(namespaces, id = "wfs")
       }
       
       featureTypesXML <- getNodeSet(xmlObj, "//ns:FeatureType", wfsNs)
       featureTypesList <- lapply(featureTypesXML, function(x){
        WFSFeatureType$new(x, self, version, logger = self$loggerType)
       })
       
       return(featureTypesList)
     }
                             
   ),
                           
   public = list(
     
     #initialize
     initialize = function(url, version, logger = NULL) {
       super$initialize(url, service = "WFS", serviceVersion = version,
                        owsVersion = "1.1", logger = logger)
       xmlObj <- self$getRequest()$getResponse()
       private$featureTypes = private$fetchFeatureTypes(xmlObj, version)
     },
     
     #getFeatureTypes
     getFeatureTypes = function(pretty = FALSE){
       fts <- private$featureTypes
       if(pretty){
         fts <- do.call("rbind", lapply(fts, function(x){
           return(data.frame(
             name = x$getName(),
             title = x$getTitle(),
             stringsAsFactors = FALSE
           ))
         }))
       }
       return(fts)
     },
     
     #findFeatureTypeByName
     findFeatureTypeByName = function(expr, exact = TRUE){
       result <- lapply(private$featureTypes, function(x){
          ft <- NULL
          if(attr(regexpr(expr, x$getName()), "match.length") != -1 
             && endsWith(x$getName(), expr)){
            ft <- x
          }
           return(ft)
       })
       result <- result[!sapply(result, is.null)]
       if(length(result) == 1) result <- result[[1]]
       return(result)
     }
     
   )
)