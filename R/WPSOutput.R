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
#'  \item{\code{new(xml, identifier, title, data)}}{
#'    This method is used to instantiate a \code{WPSOutput} object
#'  }
#'  \item{\code{decode(xml)}}{
#'    Decodes WPS output from XML
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
    xmlNamespacePrefix = "WPS"
  ),
  public = list(
    Identifier = NULL,
    Title = NULL,
    Data = NULL,
    initialize = function(xml = NULL, identifier = NULL, title = NULL, data = NULL, 
                          serviceVersion = "1.0.0") {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      if(is.null(xml)){
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
        self$decode(xml)
      }
    },
    
    #decode
    decode = function(xml){
      children <- xmlChildren(xml)
      self$Identifier <- if(!is.null(children$Identifier)) xmlValue(children$Identifier) else NA
      self$Title <- if(!is.null(children$Title)) xmlValue(children$Title) else NA
      if(!is.null(children$Data)){
        data_children <- xmlChildren(children$Data)
        if(length(data_children)>0){
          data_xml <- data_children[[1]]
          self$Data <- switch(xmlName(data_xml),
            "LiteralData" = WPSLiteralData$new(xml = data_xml),
            "ComplexData" = WPSComplexData$new(xml = data_xml),
            NULL
          )
        }
      }
    }
  )
)