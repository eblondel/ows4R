#' OWSCodeType
#' @docType class
#' @export
#' @keywords OWS CodeType
#' @return Object of \code{\link{R6Class}} for modelling an OWS CodeType
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(expr)}}{
#'    This method is used to instantiate an OWSCodeType object. The unique
#'    argument should be an object of class \code{character}
#'  }
#' }
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
    value = NULL,
    initialize = function(xml = NULL, owsVersion = "1.1", value){
      private$xmlNamespacePrefix <- paste0(private$xmlNamespacePrefix, "_", gsub("\\.", "_", owsVersion))
      super$initialize(xml = xml, element = private$xmlElement)
      if(is.null(xml)){
        self$value <- value
      }
    }
  )
)