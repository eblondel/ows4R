#' WPSException
#'
#' @docType class
#' @export
#' @keywords OGC WPS Exception
#' @return Object of \code{\link[R6]{R6Class}} for modelling a WPS Exception
#' @format \code{\link[R6]{R6Class}} object.
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
     #'@field value value
     value = NULL,
     #'@field percentCompleted percent of completion
     percentCompleted = 0L,
     
     #'@description Initializes a \link{WPSException}
     #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
     #'@param serviceVersion service version. Default "1.0.0"
     initialize = function(xml = NULL, serviceVersion = "1.0.0") {
       private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
       super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
       if(!is.null(xml)){
         self$decode(xml)
       }
     },
     
     #'@description Decodes an object of class \link{WPSException} from XML
     #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
     decode = function(xml){
       stop("Not yet implemented")
     }
   )
)