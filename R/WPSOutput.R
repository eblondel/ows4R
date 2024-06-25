#' WPSOutput
#'
#' @docType class
#' @export
#' @keywords OGC WPS Input
#' @return Object of \code{\link[R6]{R6Class}} for modelling a WPS Input
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSOutput <- R6Class("WPSOutput",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Output",
    xmlNamespacePrefix = "WPS",
    coerceToDataType = function(data, dataType){
      out_data <- data
      out_data$value <- switch(dataType,
        "string" = as(out_data$value, "character"),
        "double" = as(out_data$value, "numeric"),
        "int" = as(out_data$value, "integer"),
        "boolean" = as(out_data$value, "logical")
      )
      return(out_data)
    }
  ),
  public = list(
    #'@field Identifier identifier
    Identifier = NULL,
    #'@field Title tile
    Title = NULL,
    #'@field Data data
    Data = NULL,
    
    #'@description Initializes a \link{WPSOutput}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param identifier identifier
    #'@param title title
    #'@param data data
    #'@param dataType data type
    #'@param serviceVersion WPS service version
    initialize = function(xml = NULL, identifier = NULL, title = NULL, 
                          data = NULL, dataType = NULL,
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
      if(!is.null(dataType)) self$Data <- private$coerceToDataType(self$Data, dataType)
    },
    
    #'@description Decodes an object of class \link{WPSOutput} from \pkg{XML}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
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
            "BoundingBoxData" = WPSBoundingBoxData$new(xml = data_xml)
          )
        }
      }
    },
    
    #'@description Get data
    #'@return data
    getData = function(){
      return(self$Data)
    },
    
    #'@description Get data value
    #'@return data value
    getDataValue = function(){
      return(self$Data$value)
    }
  )
)