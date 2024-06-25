#' WPSInput
#'
#' @docType class
#' @export
#' @keywords OGC WPS Input
#' @return Object of \code{\link[R6]{R6Class}} for modelling a WPS Input
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSInput <- R6Class("WPSInput",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Input",
    xmlNamespacePrefix = "WPS"
  ),
  public = list(
    #'@field Identifier identifier
    Identifier = NULL,
    #'@field Data data
    Data = NULL,
    
    #'@description Initializes a \link{WPSInput}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param identifier identifier
    #'@param data data
    #'@param serviceVersion service version. Default "1.0.0"
    initialize = function(xml = NULL, identifier, data,
                          serviceVersion = "1.0.0") {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      self$wrap <- TRUE
      if(is.null(xml)){
        if(is(identifier, "character")){
          identifier <- OWSCodeType$new(value = identifier)
        }
        self$Identifier <- identifier
        self$Data <- data
      }else{
        self$decode(xml)
      }
    }
  )
)