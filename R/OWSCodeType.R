#' OWSCodeType
#' @docType class
#' @export
#' @keywords OWS CodeType
#' @return Object of \code{\link[R6]{R6Class}} for modelling an OWS CodeType
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OWSCodeType <-  R6Class("OWSCodeType",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Identifier",
    xmlNamespacePrefix = "OWS"
  ),
  public = list(
    #'@field value code type 
    value = NULL,
    
    #'@description Initializes an object of class \link{OWSCodeType}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param owsVersion OWS version. Default is "1.1"
    #'@param value the code type
    initialize = function(xml = NULL, owsVersion = "1.1", value){
      private$xmlNamespacePrefix <- paste0(private$xmlNamespacePrefix, "_", gsub("\\.", "_", owsVersion))
      super$initialize(xml = xml, element = private$xmlElement)
      if(is.null(xml)){
        self$value <- value
      }
    }
  )
)