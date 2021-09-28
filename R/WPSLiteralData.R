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
#'  \item{\code{new(xml, value, serviceVersion)}}{
#'    This method is used to instantiate a \code{WPSLiteralData} object
#'  }
#'  \item{\code{decode(xml)}}{
#'    Decodes WPS input from XML
#'  }
#'  \item{\code{checkValidity(parameterDescription)}}{
#'    Check the object against a parameter description inherited from a WPS process description,
#'    object of class \code{WPSLiteralInputDescription}. If not valid, the function will raise 
#'    an error.
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
      print(xml)
      dataType <- xmlGetAttr(xml, "dataType")
      if(is.null(dataType)) dataType <- "xs:string"
      self$attrs$dataType <- dataType
      value <- xmlValue(xml)
      self$value <- switch(dataType,
        "xs:string" = value,
        "xs:numeric" = as.numeric(value),
        "xs:integer" = as.integer(value),
        "xs:boolean" = as.logical(value),
        value
      )
    },
    
    #checkValidity
    checkValidity = function(parameterDescription){
      #datatype
      valid <- switch(self$attrs$dataType,
        "character" = { parameterDescription$getDataType() == "string" },
        "numeric"   = { parameterDescription$getDataType() == "double" },
        "integer"   = { parameterDescription$getDataType() == "integer"},
        "logical"   = { parameterDescription$getDataType() == "boolean"},
        TRUE
      )
      if(!valid){
        errMsg <- sprintf("WPS Parameter [%s]: Data type '%s' is invalid.",
                          parameterDescription$getIdentifier(), self$attrs$dataType)
        self$ERROR(errMsg)
        stop(errMsg)
      }
      #allowed values
      allowedValues <- parameterDescription$getAllowedValues()
      if(length(allowedValues)>0){
        if(!self$value %in% allowedValues){
          errMsg <- sprintf("WPS Parameter [%s]: Value '%s' is invalid. Allowed values are [%s]",
                            parameterDescription$getIdentifier(), self$value, 
                            paste0(allowedValues, collapse=", "))
          self$ERROR(errMsg)
          stop(errMsg)
        }
      }
    }
  )
)