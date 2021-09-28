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
#'  \item{\code{new(xml, version, logger)}}{
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