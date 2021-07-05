#' WPSDescriptionParameter
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process input description parameter
#' @return Object of \code{\link{R6Class}} modelling a WPS process input description parameter
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, version, logger)}}{
#'    This method is used to instantiate a \code{WPSDescriptionParameter} object
#'  }
#'  \item{\code{getFormats()}}{
#'    Get formats
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSDescriptionParameter <- R6Class("WPSDescriptionParameter",
   inherit = WPSParameter,                       
   private = list(
     
     formats = list(),
     
     #fetchFormats
     fetchFormats = function(xmlObj, version){
       
       children <- xmlChildren(xmlObj)
       dataElement <- NULL
       dataElements <- names(children)[endsWith(names(children), "Data")]
       if(length(dataElements)>0) dataElement <- dataElements[1]
       dataElements <- names(children)[endsWith(names(children), "Output")]
       if(length(dataElements)>0) dataElement <- dataElements[1]
       children <- xmlChildren(children[[dataElement]])
       
       formats <- list()
       if(version == "1.0.0"){
         if("Default" %in% names(children)){
           defaultFormat <- WPSFormat$new(xmlObj = xmlChildren(children$Default)$Format, version = version)
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
     initialize = function(xmlObj = NULL, version, logger = NULL, ...){
       super$initialize(xmlObj = xmlObj, version = version, logger = logger, ...)
       private$version = version
       if(!is.null(xmlObj)){
         private$formats = private$fetchFormats(xmlObj, version)
       }
     },
     
     #getFormats
     getFormats = function(){
       return(private$formats)
     }
     
   )
)