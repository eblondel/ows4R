#' OWSOperationsMetadata
#'
#' @docType class
#' @export
#' @keywords OGC OWS operation metadata
#' @return Object of \code{\link{R6Class}} for modelling an OGC Operations Metadata
#' @format \code{\link{R6Class}} object.
#' 
#' @note Abstract class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSOperationsMetadata <-  R6Class("OWSOperationsMetadata",
   private = list(
     operations = list(),
     
     #fetchOperations
     fetchOperations = function(xmlObj, owsVersion, serviceVersion){
       namespaces <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
       }
       namespaces <- as.data.frame(namespaces)
       
       opXML <- NULL
       if(nrow(namespaces) > 0){
          namespaceURI <- NULL
          if(any(sapply(namespaces$uri, endsWith, "ows"))){
             namespaceURI <- paste(namespaces[which(sapply(namespaces$uri, endsWith, "ows")), "uri"], owsVersion, sep ="/")
          }else{
             namespaceURI <- paste(namespaces[1L, "uri"])
          }
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
          operations <- lapply(opXML, function(x){return(OWSOperation$new(x, owsVersion, serviceVersion))})
       }
       return(operations)
       
     }
   ),
   public = list(
      
     #'@description Initializes an \link{OWSOperationsMetadata} object
     #'@param xmlObj object of class \link{XMLInternalNode-class} from \pkg{XML}
     #'@param owsVersion OWS version
     #'@param serviceVersion service version
     initialize = function(xmlObj, owsVersion, serviceVersion){
       private$operations <- private$fetchOperations(xmlObj, owsVersion, serviceVersion)
     },
     
     #'@description Get operations
     #'@return a list of \link{OWSOperation}
     getOperations = function(){
       return(private$operations)
     }
   )
)