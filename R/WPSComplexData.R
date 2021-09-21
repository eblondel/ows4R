#' WPSComplexData
#'
#' @docType class
#' @export
#' @keywords OGC WPS ComplexData
#' @return Object of \code{\link{R6Class}} for modelling a WPS Complex Data
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, value, schema, mimeType)}}{
#'    This method is used to instantiate a \code{WPSComplexData} object
#'  }
#'  \item{\code{decode(xml)}}{
#'    Decodes from XML
#'  }
#'  \item{\code{getFeatures()}}{
#'    Returns features associates with output, if the output si made of a GML feature collection
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSComplexData <- R6Class("WPSComplexData",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "ComplexData",
    xmlNamespacePrefix = "WPS",
    features = NULL
  ),
  public = list(
    value = NULL,
    initialize = function(xml = NULL, value = NULL, schema = NULL, mimeType = NULL,
                          serviceVersion = "1.0.0", cdata = TRUE) {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      self$wrap <- TRUE
      if(is.null(xml)){
        self$value <- value
        if(cdata) self$value <- XML::xmlCDataNode(value)
        self$attrs$schema <- schema
        self$attrs$mimeType <- mimeType
      }else{
        self$decode(xml)
      }
    },
    #decode
    decode = function(xml){
      self$value <- as(xmlChildren(xml)[[1]], "character")
      self$attrs <- as.list(xmlAttrs(xml))
      if(!is.null(self$attrs$mimeType)) if(regexpr("gml", self$attrs$mimeType)>0){
        tmp <- tempfile(fileext = "gml")
        write(self$value, file = tmp)
        private$features = sf::st_read(tmp, quiet = TRUE)
        unlink(tmp)
      }
    },
    
    #getFeatures
    getFeatures = function(){
      return(private$features)
    }
  )
)