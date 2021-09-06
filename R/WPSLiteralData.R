#' WPSLiteralData
#'
#' @docType class
#' @export
#' @keywords OGC WPS LiteralData
#' @return Object of \code{\link{R6Class}} for modelling a WPS Literal Data
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, value)}}{
#'    This method is used to instantiate a \code{WPSLiteralData} object
#'  }
#'  \item{\code{decode()}}{
#'    Decodes WPS input from XML
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSLiteralData <- R6Class("WPSLiteralData",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "LiteralData",
    xmlNamespacePrefix = "WPS"
  ),
  public = list(
    value = NULL,
    initialize = function(xml = NULL, value = NULL, serviceVersion = "1.0.0") {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      self$wrap <- TRUE
      if(is.null(xml)){
        self$attrs$dataType <- switch(class(value),
          "character" = "xs:string",
          "numeric" = "xs:double",
          "integer" = "xs:integer",
          "logical" = "xs:boolean",
          "xs:string"
        )
        self$value <- value
        if(is.logical(value)) self$value <- tolower(as.character(value))
      }else{
        self$decode(xml)
      }
    },
    
    #decode
    decode = function(xml){
      dataType <- xmlGetAttr(xml, "dataType")
      self$attrs$dataType <- dataType
      value <- xmlValue(Obj)
      self$value <- switch(dataType,
        "xs:string" = value,
        "xs:numeric" = as.numeric(value),
        "xs:integer" = as.integer(value),
        "xs:boolean" = as.logical(value),
        value
      )
    }
  )
)