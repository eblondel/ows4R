#' WPSDescriptionParameter
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process input description parameter
#' @return Object of \code{\link{R6Class}} modelling a WPS process input description parameter
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSDescriptionParameter <- R6Class("WPSDescriptionParameter",
   inherit = WPSParameter,                       
   private = list(
     dataType = NULL,
     formats = list(),
     
     #fetchFormats
     fetchFormats = function(xml, version){
       
       children <- xmlChildren(xml)
       dataElement <- NULL
       dataElements <- names(children)[endsWith(names(children), "Data")]
       if(length(dataElements)>0) dataElement <- dataElements[1]
       dataElements <- names(children)[endsWith(names(children), "Output")]
       if(length(dataElements)>0) dataElement <- dataElements[1]
       children <- xmlChildren(children[[dataElement]])
       
       #dataType
       if("DataType" %in% names(children)){
          private$dataType <- xmlValue(children$DataType)
       }
       
       #formats
       formats <- list()
       if(version == "1.0.0"){
         if("Default" %in% names(children)){
           defaultFormat <- WPSFormat$new(xml = xmlChildren(children$Default)$Format, version = version)
           defaultFormat$setIsDefault(TRUE)
           formats <- c(formats, defaultFormat)
         }
         if("Supported" %in% names(children)){
           supportedFormats <- lapply(xmlChildren(children$Supported), WPSFormat$new, version = version)
           formats <- c(formats, supportedFormats)
         }
         names(formats) <- NULL
         
       }else if(version == "2.0"){
         formatsXML <- children[names(children) == "Format"]
         formats <- lapply(formatsXML, lapply(formatsXML, WPSFormat$new, version = version))
         names(formats) <- NULL
       }
       return(formats)
     }
     
   ),
   public = list(
      #'@description Initializes a \link{WPSDescriptionParameter}
      #'@param xml object of class \link{XMLInternalNode-class} from \pkg{XML}
      #'@param version WPS service version
      #'@param logger logger
      #'@param ... any other parameter
     initialize = function(xml = NULL, version, logger = NULL, ...){
       super$initialize(xml = xml, version = version, logger = logger, ...)
       private$version = version
       if(!is.null(xml)){
         private$formats = private$fetchFormats(xml, version)
       }
     },
     
     #'@description Get data type
     #'@return object of class \code{character}
     getDataType = function(){
        return(private$dataType)
     },
     
     #'@description get formats
     #'@return the formats
     getFormats = function(){
       return(private$formats)
     }
     
   )
)