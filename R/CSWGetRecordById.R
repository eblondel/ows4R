#' CSWGetRecordById
#'
#' @docType class
#' @export
#' @keywords OGC CSW GetRecordById
#' @return Object of \code{\link{R6Class}} for modelling a CSW GetRecordById request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, id)}}{
#'    This method is used to instantiate a CSWGetRecordById object
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWGetRecordById <- R6Class("CSWGetRecordById",
    inherit = OWSRequest,
    private = list(
      name = "GetRecordById",
      defaultOutputSchema = "http://www.opengis.net/cat/csw/2.0.2"
    ),
    public = list(
      initialize = function(op, url, version, id, logger = NULL, ...) {
        namedParams <- list(service = "CSW", version = version, id = id)
        
        #default output schema
        outputSchema <- list(...)$outputSchema
        if(is.null(outputSchema)){
          outputSchema <- private$defaultOutputSchema
          namedParams <- c(namedParams, outputSchema = outputSchema)
        }
        
        super$initialize(op, "GET", url, request = private$name,
                         namedParams = namedParams,
                         mimeType = "text/xml", logger = logger, ...)
        
        #check response in case of ISO
        isoSchemas <- c("http://www.isotc211.org/2005/gmd","http://www.isotc211.org/2005/gfc")
        if(outputSchema %in% isoSchemas){
          xmltxt <- as(private$response, "character")
          isMetadata <- regexpr("MD_Metadata", xmltxt)>0
          isFeatureCatalogue <- regexpr("FC_FeatureCatalogue", xmltxt)>0
          if(isMetadata && outputSchema == isoSchemas[2]){
            outputSchema <- isoSchemas[1]
            message(sprintf("Metadata detected! Switch to schema '%s'!", outputSchema))
          }
          if(isFeatureCatalogue && outputSchema == isoSchemas[1]){
            outputSchema <- isoSchemas[2]
            message(sprintf("FeatureCatalogue detected! Switch to schema '%s'!", outputSchema))
          }
        }
        
        #bindings
        private$response <- switch(outputSchema,
          "http://www.isotc211.org/2005/gmd" = {
            out <- NULL
            xmlObjs <- getNodeSet(private$response, "//ns:MD_Metadata", c(ns = outputSchema))
            if(length(xmlObjs)>0){
              xmlObj <- xmlObjs[[1]]
              out <- geometa::ISOMetadata$new()
              out$decode(xml = xmlObj)
            }
            out
          },
          "http://www.isotc211.org/2005/gfc" = {
            out <- NULL
            xmlObjs <- getNodeSet(private$response, "//ns:FC_FeatureCatalogue", c(ns = outputSchema))
            if(length(xmlObjs)>0){
              xmlObj <- xmlObjs[[1]]
              out <- geometa::ISOFeatureCatalogue$new()
              out$decode(xml = xml)
            }
            out
          },
          "http://www.opengis.net/cat/csw/2.0.2" = {
            warnings(sprintf("R binding not yet supported for '%s'", outputSchema))
            private$response
          },
          "http://www.w3.org/ns/dcat#" = {
            warnings(sprintf("R binding not yet supported for '%s'", outputSchema))
            private$response
          }
        )
      }
    )
)