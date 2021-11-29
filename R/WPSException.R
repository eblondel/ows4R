#' WPSException
#'
#' @docType class
#' @export
#' @keywords OGC WPS Exception
#' @return Object of \code{\link{R6Class}} for modelling a WPS Exception
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, serviceVersion)}}{
#'    This method is used to instantiate a \code{WPSException} object
#'  }
#'  \item{\code{decode(xml)}}{
#'    Decodes WPS exception from XML
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSException <- R6Class("WPSException",
   inherit = OGCAbstractObject,
   private = list(
     xmlElement = "Exception",
     xmlNamespacePrefix = "WPS"
   ),
   public = list(
     value = NULL,
     percentCompleted = 0L,
     initialize = function(xml = NULL, serviceVersion = "1.0.0") {
       private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
       super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
       if(!is.null(xml)){
         self$decode(xml)
       }
     },
     
     #decode
     decode = function(xml){
      
     }
   )
)