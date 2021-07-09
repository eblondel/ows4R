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
#'  \item{\code{new(xmlObj, value, schema, mimeType)}}{
#'    This method is used to instantiate a \code{WPSComplexData} object
#'  }
#'  \item{\code{decode(xmlObj)}}{
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
    xmlNamespace = c(wps = "http://www.opengis.net/wps"),
    features = NULL
  ),
  public = list(
    value = NULL,
    wrap = TRUE,
    initialize = function(xmlObj = NULL, value = NULL, schema = NULL, mimeType = NULL) {
      if(is.null(xmlObj)){
        self$value <- value
        self$attrs$schema <- schema
        self$attrs$mimeType <- mimeType
      }else{
        self$decode(xmlObj)
      }
    },
    #decode
    decode = function(xmlObj){
      self$value <- as(xmlChildren(xmlObj)[[1]], "character")
      self$attrs <- as.list(xmlAttrs(xmlObj))
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