#' WPSInput
#'
#' @docType class
#' @export
#' @keywords OGC WPS Input
#' @return Object of \code{\link{R6Class}} for modelling a WPS Input
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, identifier, data, serviceVersion)}}{
#'    This method is used to instantiate a WPSInput object
#'  }
#' }
#' 
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
    Identifier = NULL,
    Data = NULL,
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