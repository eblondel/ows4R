#' WPSFormat
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
#'    This method is used to instantiate a \code{WPSFormat} object
#'  }
#'  \item{\code{getMimeType()}}{
#'    Get mimetype
#'  }
#'  \item{\code{getEncoding()}}{
#'    Get encoding
#'  }
#'  \item{\code{getSchema()}}{
#'    Get schema
#'  }
#'  \item{\code{setIsDefault(default)}}{
#'    Set if default format or not
#'  }
#'  \item{\code{isDefault()}}{
#'    Is default format
#'  }
#' }
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
     
     #getMimeType
     getMimeType = function(){
       return(private$mimeType)
     },
     
     #getEncoding
     getEncoding = function(){
       return(private$encoding)
     },
     
     #getSchema
     getSchema = function(){
       return(private$schema)
     },
     
     #setIsDefault
     setIsDefault = function(default){
       private$default = default
     },
     
     #isDefault
     isDefault = function(){
       return(private$default)
     }
     
   )
)