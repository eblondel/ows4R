#' OWSOperationsMetadata
#'
#' @docType class
#' @export
#' @keywords OGC OWS operation metadata
#' @return Object of \code{\link{R6Class}} for modelling an OGC Operations Metadata
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, serviceVersion)}}{
#'    This method is used to instantiate a OWSOperationsMetadata object
#'  }
#'  \item{\code{getOperations()}}{
#'    Get operations
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSOperationsMetadata <-  R6Class("OWSOperationsMetadata",
   private = list(
     operations = list(),
     
     #fetchOperations
     fetchOperations = function(xmlObj, serviceVersion){
       namespaces <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
       }
       namespaces <- as.data.frame(namespaces)
       namespaceURI <- paste("http://www.opengis.net/ows", serviceVersion, sep ="/")
       
       opXML <- NULL
       if(nrow(namespaces) > 0){
         ns <- OWSUtils$findNamespace(namespaces, uri = namespaceURI)
         if(length(ns)>0){
           opXML <- getNodeSet(xmlObj, "//ns:OperationsMetadata/ns:Operation", ns)
         }
         if(length(opXML)==0){
           ns <- OWSUtils$findNamespace(namespaces, id = "ows")
           if(length(ns)>0){
             opXML <- getNodeSet(xmlObj, "//ns:OperationsMetadata/ns:Operation", ns)
           }
         }
       }else{
         opXML <- getNodeSet(xmlObj, "//OperationsMetadata/Operation")
       }
       
       operations <- list()
       if(length(opXML)>0){
          operations <- lapply(opXML, function(x){return(OWSOperation$new(x, serviceVersion))})
       }
       return(operations)
       
     }
   ),
   public = list(
     initialize = function(xmlObj, serviceVersion){
       private$operations <- private$fetchOperations(xmlObj, serviceVersion)
     },
     
     #getOperations
     getOperations = function(){
       return(private$operations)
     }
   )
)