#' WPSFormat
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
WPSFormat <- R6Class("WPSFormat",
   inherit = OGCAbstractObject,                       
   private = list(
     version = NA,
     mimeType = NA,
     encoding = NA,
     schema = NA,
     default = FALSE,
     
     #fetchFormat
     fetchFormat = function(xml, version){
       
       format <- NULL
       if(version == "1.0.0"){
         children <- xmlChildren(xml)
         format = list(
           mimeType = if(!is.null(children$MimeType)) xmlValue(children$MimeType) else NA,
           encoding = if(!is.null(children$Encoding)) xmlValue(children$Encoding) else NA,
           schema = if(!is.null(children$Schema)) xmlValue(children$Schema) else NA
         ) 
       }else if(version == "2.0"){
         format = list(
           mimeType = xmlGetAttr(xml, "mimeType"),
           encoding = xmlGetAttr(xml, "encoding"),
           schema = xmlGetAttr(xml, "schema"),
           default = xmlGetAttr(xml, "default") == "true"
         )
       }
       return(format)
     }
     
   ),
   public = list(
      
     #'@description Initializes an object of class \link{WPSFormat}
     #'@param xml an object of class \link[XML]{XMLInternalNode-class} to initialize from XML
     #'@param version WPS service version
     #'@param logger logger
     #'@param ... any additional parameter
     initialize = function(xml = NULL, version, logger = NULL, ...){
       super$initialize(logger = logger)
       private$version = version
       if(!is.null(xml)){
         format = private$fetchFormat(xml, version)
         private$mimeType = format$mimeType
         private$encoding = format$encoding
         private$schema = format$schema
         private$default = format$default
       }
     },
     
     #'@description Get mime type
     #'@return object of class \code{character}
     getMimeType = function(){
       return(private$mimeType)
     },
     
     #'@description Get encoding
     #'@return object of class \code{character}
     getEncoding = function(){
       return(private$encoding)
     },
     
     #'@description Get schema
     #'@return object of class \code{character}
     getSchema = function(){
       return(private$schema)
     },
     
     #'@description set is default
     #'@param default object of class \code{logical}
     setIsDefault = function(default){
       private$default = default
     },
     
     #'@description is default
     #'@return \code{TRUE} if default, \code{FALSE} otherwise
     isDefault = function(){
       return(private$default)
     }
     
   )
)