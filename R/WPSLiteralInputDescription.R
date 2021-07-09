#' WPSLiteralInputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process input description
#' @return Object of \code{\link{R6Class}} modelling a WPS process input description
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, version, logger)}}{
#'    This method is used to instantiate a \code{WPSLiteralInputDescription} object
#'  }
#'  \item{\code{getDataType()}}{
#'    Get data type
#'  }
#'  \item{\code{getDefaultValue()}}{
#'    Get default value
#'  }
#'  \item{\code{getAllowedValues()}}{
#'    Get allowed values
#'  }
#' }
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
     fetchLiteralInput = function(xmlObj, version){
       
       children <- xmlChildren(xmlChildren(xmlObj)$LiteralData)
       
       literalInput <- list(
         dataType = xmlGetAttr(children$DataType, "ows:reference"),
         defaultValue = xmlValue(children$DefaultValue),
         allowedValues = if("AllowedValues" %in% names(children)) sapply(xmlChildren(children$AllowedValues), xmlValue) else NA
       )
       
       return(literalInput)
     }
     
   ),
   public = list(
     initialize = function(xmlObj = NULL, version, logger = NULL, ...){
       super$initialize(xmlObj = xmlObj, version = version, logger = logger, ...)
       private$version = version
       if(!is.null(xmlObj)){
         literalInput = private$fetchLiteralInput(xmlObj, version)
         private$dataType = literalInput$dataType
         private$defaultValue = literalInput$defaultValue
         private$allowedValues = literalInput$allowedValues
       }
     },
     
     #getDataType
     getDataType = function(){
       return(private$dataType)
     },
     
     #getDefaultValue
     getDefaultValue = function(){
       return(private$defaultValue)
     },
     
     #getAllowedValues
     getAllowedValues = function(){
       return(private$allowedValues)
     }
   )
)