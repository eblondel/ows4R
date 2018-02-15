#' WFSFeatureTypeElement
#'
#' @docType class
#' @export
#' @keywords OGC WFS FeatureType
#' @return Object of \code{\link{R6Class}} modelling a WFS feature type element
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
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
       type <- xmlGetAttr(xmlObj, "type")
       if(attr(regexpr("gml", type),
               "match.length") > 0) elementType <- "Spatial"
       if(type == "xsd:string") elementType <- "character"
       if(type == "xsd:int") elementType <- "integer"
       if(type == "xsd:decimal") elementType <- "double"
       if(type == "xsd:boolean") elementType <- "logical"
       if(type == "xsd:date") elementType <- "character" #TODO
       if(type == "xsd:dateTime") elementType <- "character" #TODO
       
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