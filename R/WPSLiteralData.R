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
#'  \item{\code{new(xmlObj, value)}}{
#'    This method is used to instantiate a WPSLiteralData object
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
    xmlNamespace = c(wps = "http://www.opengis.net/wps")
  ),
  public = list(
    value = NULL,
    wrap = TRUE,
    initialize = function(xmlObj = NULL, value = NULL) {
      if(is.null(xmlObj)){
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
        self$decode(xmlObj)
      }
    },
    
    #decode
    decode = function(xmlObj){
      dataType <- xmlGetAttr(xmlObj, "dataType")
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