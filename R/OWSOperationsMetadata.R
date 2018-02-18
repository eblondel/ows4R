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
#'  \item{\code{new(xmlObj, service, version)}}{
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
     fetchOperations = function(xmlObj, service, version){
       namespaces <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
       }
       namespaces <- as.data.frame(namespaces)
       namespace <- tolower(service)
       
       opXML <- NULL
       if(nrow(namespaces) > 0){
         ns <- OWSUtils$findNamespace(namespaces, namespace)
         if(length(ns)>0){
           if(namespace %in% names(ns)){
             opXML <- getNodeSet(xmlObj, "//ns:OperationsMetadata/ns:Operation", ns)
           }
         }
         if(length(opXML)==0){
           ns <- OWSUtils$findNamespace(namespaces, "ows")
           if(length(ns)>0){
             opXML <- getNodeSet(xmlObj, "//ns:OperationsMetadata/ns:Operation", ns)
           }
         }
       }else{
         opXML <- getNodeSet(xmlObj, "//OperationsMetadata/Operation")
       }
       
       operations <- list()
       if(length(opXML)>0){
          operations <- lapply(opXML, function(x){return(OWSOperation$new(x, service, version))})
       }
       return(operations)
       
     }
   ),
   public = list(
     initialize = function(xmlObj, service, version){
       private$operations <- private$fetchOperations(xmlObj, service, version)
     },
     
     #getOperations
     getOperations = function(){
       return(private$operations)
     }
   )
)