#' WPSOutput
#'
#' @docType class
#' @export
#' @keywords OGC WPS Input
#' @return Object of \code{\link{R6Class}} for modelling a WPS Input
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(identifier, data)}}{
#'    This method is used to instantiate a WPSOutput object
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSOutput <- R6Class("WPSOutput",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Output",
    xmlNamespace = c(wps = "http://www.opengis.net/wps")
  ),
  public = list(
    Identifier = NULL,
    Title = NULL,
    Data = NULL,
    initialize = function(xmlObj = NULL, identifier = NULL, title = NULL, data = NULL) {
      if(is.null(xmlObj)){
        if(is(identifier, "character")){
          identifier <- OWSCodeType$new(value = identifier)
        }
        self$Identifier <- identifier
        if(is(title, "character")){
          title <- OWSCodeType$new(value = title)
        }
        self$Title <- title
        self$Data <- data
      }else{
        self$decode(xmlObj)
      }
    },
    
    #decode
    decode = function(xmlObj){
      children <- xmlChildren(xmlObj)
      self$Identifier <- if(!is.null(children$Identifier)) xmlValue(children$Identifier) else NA
      self$Title <- if(!is.null(children$Title)) xmlValue(children$Title) else NA
      if(!is.null(children$Data)){
        data_children <- xmlChildren(children$Data)
        if(length(data_children)>0){
          data_xml <- data_children[[1]]
          self$Data <- switch(xmlName(data_xml),
            "LiteralData" = WPSLiteralData$new(xmlObj = data_xml),
            "ComplexData" = WPSComplexData$new(xmlObj = data_xml),
            NULL
          )
        }
      }
    }
  )
)