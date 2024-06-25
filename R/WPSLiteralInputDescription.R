#' WPSLiteralInputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process input description
#' @return Object of \code{\link[R6]{R6Class}} modelling a WPS process input description
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSLiteralInputDescription <- R6Class("WPSLiteralInputDescription",
   inherit = WPSInputDescription,                       
   private = list(
     dataType = NA,
     defaultValue = NA,
     allowedValues = c(),
     anyValue = FALSE, #NOT IMPLEMENTED
     uoms = list(), #NOT IMPLEMENTED
     
     #fetchLiteralInput
     fetchLiteralInput = function(xml, version){
       
       children <- xmlChildren(xmlChildren(xml)$LiteralData)
       
       literalInput <- list(
         dataType = xmlGetAttr(children$DataType, "ows:reference"),
         defaultValue = xmlValue(children$DefaultValue),
         allowedValues = if("AllowedValues" %in% names(children)) sapply(xmlChildren(children$AllowedValues), xmlValue) else c()
       )
       
       return(literalInput)
     }
     
   ),
   public = list(
      
      #'@description Initializes a \link{WPSLiteralInputDescription}
      #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
      #'@param version WPS service version
      #'@param logger logger
      #'@param ... any other parameter
      initialize = function(xml = NULL, version, logger = NULL, ...){
       super$initialize(xml = xml, version = version, logger = logger, ...)
       private$version = version
       if(!is.null(xml)){
         literalInput = private$fetchLiteralInput(xml, version)
         private$dataType = literalInput$dataType
         private$defaultValue = literalInput$defaultValue
         private$allowedValues = literalInput$allowedValues
       }
     },
     
     #'@description Get data type
     #'@return the data type, object of class \code{character}
     getDataType = function(){
       return(private$dataType)
     },
     
     #'@description Get default value
     #'@return the default value, object of class \code{character}
     getDefaultValue = function(){
       return(private$defaultValue)
     },
     
     #'@description Get allowed values
     #'@return the allowed values
     getAllowedValues = function(){
       return(private$allowedValues)
     }
   )
)