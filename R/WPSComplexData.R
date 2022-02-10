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
#'  \item{\code{checkValidity(parameterDescription)}}{
#'    Check the object against a parameter description inherited from a WPS process description,
#'    object of class \code{WPSComplexInputDescription}. If not valid, the function will raise an
#'    error.
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
    features = NULL,
    coerceToMimeType = function(value, mimeType){
      out_value <- value
      if(is(out_value, "sf")){
        out_value <- switch(mimeType,
          "text/xml; subtype=wfs-collection/1.0" = {
            #OK
            tmpfile <- tempfile(fileext = ".gml")
            sf::st_write(value, tmpfile, dataset_options = "FORMAT=GML2")
            out <- paste0(readLines(tmpfile), collapse="")
            unlink(tmpfile)
            out
          },
          "text/xml; subtype=wfs-collection/1.1" = {
            #OK
            tmpfile <- tempfile(fileext = ".gml")
            sf::st_write(
              value, tmpfile, 
              dataset_options = c(
                "FORMAT=GML3", 
                "WRITE_FEATURE_BOUNDED_BY=NO",
                "PREFIX=wfs", 
                "TARGET_NAMESPACE=http://www.opengis.net/wfs")
            )
            xml_txt <- paste0(readLines(tmpfile), collapse="")
            xml <- XML::xmlParse(xml_txt)
            xml <- xmlRoot(xml)
            removeAttributes(xml, .attrs = "xsi:schemaLocation")
            nodes = getNodeSet(xml, "//wfs:featureMember", namespaces = c(wfs = "http://www.opengis.net/wfs"))
            invisible(lapply(nodes, function(x){ xmlNamespace(x) <- "gml"}))
            
            out <- as(xml, "character")
            unlink(tmpfile)
            out
          },
          "application/wfs-collection-1.0" = {
            #OK
            tmpfile <- tempfile(fileext = ".gml")
            sf::st_write(value, tmpfile, dataset_options = "FORMAT=GML2")
            out <- paste0(readLines(tmpfile), collapse="")
            unlink(tmpfile)
            out
          },
          "application/wfs-collection-1.1" = {
            #OK
            tmpfile <- tempfile(fileext = ".gml")
            sf::st_write(
              value, tmpfile, 
              dataset_options = c(
                "FORMAT=GML3", 
                "WRITE_FEATURE_BOUNDED_BY=NO",
                "PREFIX=wfs", 
                "TARGET_NAMESPACE=http://www.opengis.net/wfs")
            )
            xml_txt <- paste0(readLines(tmpfile), collapse="")
            xml <- XML::xmlParse(xml_txt)
            xml <- xmlRoot(xml)
            removeAttributes(xml, .attrs = "xsi:schemaLocation")
            nodes = getNodeSet(xml, "//wfs:featureMember", namespaces = c(wfs = "http://www.opengis.net/wfs"))
            invisible(lapply(nodes, function(x){ xmlNamespace(x) <- "gml"}))
            
            out <- as(xml, "character")
            unlink(tmpfile)
            out
          },
          "text/xml; subtype=gml/2.1.2" = {
            #TODO
          },
          "text/xml; subtype=gml/3.1.1" = {
            #TODO
          },
          "text/xml; subtype=gml/3.2.1" = {
            #TODO
          },
          "application/gml-2.1.2" = {
            #TODO
          },
          "application/gml-3.2.1" = {
            #TODO
          },
          "application/json" = {
            tmpfile <- tempfile(fileext = ".geojson")
            sf::st_write(value, tmpfile)
            out <- paste0(readLines(tmpfile), collapse="")
            unlink(tmpfile)
            out
          }
        )
      } 
      return(out_value)
    }
  ),
  public = list(
    #'@field value value
    value = NULL,
    
    #'@description Initializes an object of class \link{WPSComplexData}
    #'@param xml an object of class \link{XMLInternalNode-class} to initialize from XML
    #'@param value value
    #'@param schema schema
    #'@param mimeType mime type
    #'@param serviceVersion WPS service version
    #'@param cdata whether value has to be wrapped in a XML CDATA. Default is \code{TRUE}
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
      if(!is.null(mimeType)) self$value <- private$coerceToMimeType(value, mimeType)
    },
    
    #'@description Decodes an object of class \link{WPSComplexData} from XML
    #'@param xml an object of class \link{XMLInternalNode-class} to initialize from XML
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
    
    #'@description Check the object against a parameter description inherited from a WPS process description,
    #'    object of class \code{WPSComplexInputDescription}. If not valid, the function will raise an error.
    #'@param parameterDescription object of class \link{WPSComplexInputDescription}
    #'@return an error if not valid
    checkValidity = function(parameterDescription){
      valid <- self$attrs$mimeType %in% sapply(parameterDescription$getFormats(), function(x){x$getMimeType()})
      if(!valid){
        errMsg <- sprintf("WPS Parameter [%s]: Mime type '%s' is invalid.",
                          parameterDescription$getIdentifier(), self$attrs$mimeType)
        self$ERROR(errMsg)
        stop(errMsg)
      }
    },
    
    #'@description Get features
    #'@return object of class \code{sf}
    getFeatures = function(){
      return(private$features)
    }
  )
)