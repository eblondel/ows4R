#' WFSCapabilities
#'
#' @docType class
#' @export
#' @keywords OGC WFS GetCapabilities
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Web Feature Service Get Capabilities document.
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used to read a \code{WFSCapabilities} document. The use of \code{WFSClient} is
#' recommended instead to benefit from the full set of capabilities associated to a WFS server.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSCapabilities <- R6Class("WFSCapabilities",
   inherit = OWSCapabilities,
   private = list(
     xmlElement = "Capabilities",
     xmlNamespacePrefix = "WFS",
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
     
      #'@description Initializes a \link{WFSCapabilities} object
      #'@param url url
      #'@param version version
      #'@param logger logger type \code{NULL}, "INFO" or "DEBUG"
      #'@param ... any other parameter to pass to \link{OWSGetCapabilities} service request
     initialize = function(url, version, logger = NULL, ...) {
       super$initialize(
          element = private$xmlElement, namespacePrefix = private$namespacePrefix,
          url, service = "WFS", owsVersion = "1.1", serviceVersion = version, logger = logger, 
          ...)
       xmlObj <- self$getRequest()$getResponse()
       private$featureTypes = private$fetchFeatureTypes(xmlObj, version)
     },
     
     #'@description List the feature types available. If \code{pretty} is TRUE,
     #'    the output will be an object of class \code{data.frame}
     #'@param pretty whether the output should be summarized as \code{data.frame}
     #'@return a \code{list} of \link{WFSFeatureType} or a \code{data.frame}
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
     
     #'@description Finds a feature type by name
     #'@param expr expr
     #'@param exact exact matching? Default is \code{TRUE}
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