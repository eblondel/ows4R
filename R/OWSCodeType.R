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
    xmlNamespace = c(ows = "http://www.opengis.net/ows")
  ),
  public = list(
    value = NULL,
    initialize = function(xml = NULL, serviceVersion = "1.1", value){
      private$xmlNamespace <- paste0(private$xmlNamespace, "/", serviceVersion)
      names(private$xmlNamespace) <- "ows"
      if(is.null(xml)){
        self$value <- value
      }
    }
  )
)