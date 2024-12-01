#' WFSFeatureTypeElement
#'
#' @docType class
#' @export
#' @keywords OGC WFS FeatureType
#' @return Object of \code{\link[R6]{R6Class}} modelling a WFS feature type element
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSFeatureTypeElement <- R6Class("WFSFeatureTypeElement",
   private = list(
     minOccurs = NA,
     maxOccurs = NA,
     nillable = NA,
     name = NA,
     type = NA,
     geometry = FALSE,
     
     #fetchElement
     fetchElement = function(xmlObj, namespaces){
       
       #minOccurs
       elementMinOccurs <- xmlGetAttr(xmlObj, "minOccurs")
       #maxOccurs
       elementMaxOccurs <- xmlGetAttr(xmlObj, "maxOccurs")
       #nillable
       elementNillable <- ifelse(xmlGetAttr(xmlObj, "nillable") == "true", TRUE, FALSE)
       #name
       elementName <- xmlGetAttr(xmlObj, "name")
       #type
       elementType <- "character"
       type <- xmlGetAttr(xmlObj, "type")
       #geometry
       geometry <- FALSE
       if(length(type)==0){
         #try a basic parsing for types in type restriction
         #TODO study further WFS Schema (through GML geometa?) to propose generic solution
         type <- try(xpathSApply(xmlDoc(xmlObj), "//xs:restriction",
                             namespaces = c(xs = "http://www.w3.org/2001/XMLSchema"),
                             xmlGetAttr, "base"))
         if(is(type,"try-error")) type <- NULL
       }
       if(is.null(type)){
         stop(sprintf("Unknown data type for type '%s' while parsing FeatureType description!", type))
       }
       gml_xmlns = namespaces[regexpr("gml", namespaces$uri)>0,] #may include app-schema GML secondary namespace
       if(length(type)>0){
         if(any(startsWith(type, gml_xmlns$id))){
           gml_xmlns = gml_xmlns[startsWith(type, gml_xmlns$id),]
           elementType <- unlist(strsplit(unlist(strsplit(type, paste0(gml_xmlns$id,":")))[2], "PropertyType"))[1]
           geometry <- TRUE
         }else{
           baseType <- tolower(type)
           #detect namespace xs/xsd (normal behavior)
           #primitive types that are not prefixed with xsd (http://www.w3.org/2001/XMLSchema) schema are not handled well
           #ows4R is permissive and controls it, although it is an issue of XML compliance on service providers side
           if(regexpr(":", baseType)>0) baseType <- unlist(strsplit(baseType,":"))[2] 
           elementType <- switch(baseType,
                               "string" = "character",
                               "long" = "numeric",
                               "int" = "integer",
                               "short" = "integer",
                               "decimal" = "double",
                               "double" = "double",
                               "float" = "double",
                               "boolean" = "logical",
                               "date" = "Date",
                               "datetime" = "POSIXct",
                               NULL
          )
         }
       }
       
       element <- list(
         minOccurs = elementMinOccurs,
         maxOccurs = elementMaxOccurs,
         nillable = elementNillable,
         name = elementName,
         type = elementType,
         geometry = geometry
       )
       return(element)
     } 
   ),                                 
                                 
   public = list(
      
     #'@description Initializes a \link{WFSFeatureTypeElement}
     #'@param xmlObj object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
     #'@param namespaces namespaces definitions inherited from parent XML, as \code{data.frame}
     initialize = function(xmlObj, namespaces){
       element = private$fetchElement(xmlObj, namespaces)
       private$minOccurs = element$minOccurs
       private$maxOccurs = element$maxOccurs
       private$nillable = element$nillable
       private$name = element$name
       private$type = element$type
       private$geometry = element$geometry
     },
     
     #'@description get min occurs
     #'@return an object of class \code{character}
     getMinOccurs = function(){
       return(private$minOccurs)
     },
     
     #'@description get max occurs
     #'@return an object of class \code{character}
     getMaxOccurs = function(){
       return(private$maxOccurs)
     },
     
     #'@description get if nillable
     #'@return an object of class \code{logical}
     isNillable = function(){
       return(private$nillable)
     },
     
     #'@description get name
     #'@return an object of class \code{character}
     getName = function(){
       return(private$name)
     },
     
     #'@description get type
     #'@return an object of class \code{character}
     getType = function(){
       return(private$type)
     },
     
     #'@description Is geometry
     #'@param return object of class \code{logical}
     isGeometry = function(){
        return(private$geometry)
     }
   )
)