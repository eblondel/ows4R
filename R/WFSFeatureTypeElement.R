#' WFSFeatureTypeElement
#'
#' @docType class
#' @export
#' @keywords OGC WFS FeatureType
#' @return Object of \code{\link{R6Class}} modelling a WFS feature type element
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj)}}{
#'    This method is used to instantiate a \code{WFSFeatureTypeElement} object
#'  }
#'  \item{\code{getMinOccurs()}}{
#'    Get min occurs
#'  }
#'  \item{\code{getMaxOccurs()}}{
#'    Get max occurs
#'  }
#'  \item{\code{isNillable()}}{
#'    Get TRUE if nillable, FALSE otherwise
#'  }
#'  \item{\code{getName()}}{
#'    Get element name
#'  }
#'  \item{\code{getType()}}{
#'    Get element type
#'  }
#' }
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
     
     #fetchElement
     fetchElement = function(xmlObj){
       
       #minOccurs
       elementMinOccurs <- xmlGetAttr(xmlObj, "minOccurs")
       #maxOccurs
       elementMaxOccurs <- xmlGetAttr(xmlObj, "maxOccurs")
       #nillable
       elementNillable <- ifelse(xmlGetAttr(xmlObj, "nillable") == "true", TRUE, FALSE)
       #name
       elementName <- xmlGetAttr(xmlObj, "name")
       #type
       elementType <- NULL
       type <- tolower(xmlGetAttr(xmlObj, "type"))
       if(length(type)==0){
         #try a basic parsing for types in type restriction
         #TODO study further WFS Schema (through GML geometa?) to propose generic solution
         type <- try(xpathSApply(xmlDoc(xmlObj), "//xs:restriction",
                             namespaces = c(xs = "http://www.w3.org/2001/XMLSchema"),
                             xmlGetAttr, "base"))
         if(class(type)=="try-error") type <- NULL
       }
       if(is.null(type)){
         stop(sprintf("Unknown data type for type '%s' while parsing FeatureType description!", type))
       }
       if(attr(regexpr("gml", type), "match.length") > 0){
         elementType <- "geometry"
       }else{
         baseType <- type
         #detect namespace xs/xsd (normal behavior)
         #primitive types that are not prefixed with xsd (http://www.w3.org/2001/XMLSchema) schema are not handled well
         #ows4R is permissive and controls it, although it is an issue of XML compliance on service providers side
         if(regexpr(":", type)>0) baseType <- unlist(strsplit(type,":"))[2] 
         elementType <- switch(baseType,
                             "string" = "character",
                             "long" = "numeric",
                             "int" = "integer",
                             "decimal" = "double",
                             "double" = "double",
                             "float" = "double",
                             "boolean" = "logical",
                             "date" = "Date",
                             "datetime" = "POSIXct",
                             NULL
        )
       }
       
       element <- list(
         minOccurs = elementMinOccurs,
         maxOccurs = elementMaxOccurs,
         nillable = elementNillable,
         name = elementName,
         type = elementType
       )
       return(element)
     } 
   ),                                 
                                 
   public = list(
     initialize = function(xmlObj){
       element = private$fetchElement(xmlObj)
       private$minOccurs = element$minOccurs
       private$maxOccurs = element$maxOccurs
       private$nillable = element$nillable
       private$name = element$name
       private$type = element$type
     },
     
     #getMinOccurs
     getMinOccurs = function(){
       return(private$minOccurs)
     },
     
     #getMaxOccurs
     getMaxOccurs = function(){
       return(private$maxOccurs)
     },
     
     #isNillable
     isNillable = function(){
       return(private$nillable)
     },
     
     #getName
     getName = function(){
       return(private$name)
     },
     
     #getType
     getType = function(){
       return(private$type)
     }
   )
)