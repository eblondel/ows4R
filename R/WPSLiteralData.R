#' WPSLiteralData
#'
#' @docType class
#' @export
#' @keywords OGC WPS LiteralData
#' @return Object of \code{\link[R6]{R6Class}} for modelling a WPS Literal Data
#' @format \code{\link[R6]{R6Class}} object.
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
    #'@field value value
    value = NULL,
    
    #'@description Initializes an object of class \link{WPSLiteralData}
    #'@param xml an object of class \link[XML]{XMLInternalNode-class} to initialize from XML
    #'@param value value
    #'@param serviceVersion WPS service version
    initialize = function(xml = NULL, value = NULL, serviceVersion = "1.0.0") {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      self$wrap <- TRUE
      if(is.null(xml)){
        self$attrs$dataType <- switch(class(value),
          "character" = "xs:string",
          "numeric" = "xs:double",
          "integer" = "xs:int",
          "logical" = "xs:boolean",
          "xs:string"
        )
        self$value <- value
        if(is.logical(value)) self$value <- tolower(as.character(value))
      }else{
        self$decode(xml)
      }
    },
    
    #'@description Decodes an object of class \link{WPSLiteralData} from XML
    #'@param xml an object of class \link[XML]{XMLInternalNode-class} to initialize from XML
    decode = function(xml){

      dataType <- xmlGetAttr(xml, "dataType")
      if(is.null(dataType)) dataType <- "xs:string"
      self$attrs$dataType <- dataType
      value <- xmlValue(xml)
      self$value <- switch(dataType,
        "xs:string" = value,
        "xs:numeric" = as.numeric(value),
        "xs:double" = as.numeric(value),
        "xs:int" = as.integer(value),
        "xs:integer" = as.integer(value),
        "xs:boolean" = as.logical(value),
        value
      )
    },
    
    #'@description Check the object against a parameter description inherited from a WPS process description,
    #'    object of class \code{WPSLiteralInputDescription}. If not valid, the function will raise an error.
    #'@param parameterDescription object of class \link{WPSLiteralInputDescription}
    #'@return an error if not valid
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