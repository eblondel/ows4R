#' CSWGetRecords
#'
#' @docType class
#' @export
#' @keywords OGC CSW GetRecords
#' @return Object of \code{\link{R6Class}} for modelling a CSW GetRecords request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, constraints, ...)}}{
#'    This method is used to instantiate a CSWGetRecords object
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWGetRecords <- R6Class("CSWGetRecords",
  inherit = OWSRequest,
  private = list(
    name = "GetRecords",
    defaultOutputSchema = "http://www.opengis.net/cat/csw/2.0.2"
  ),
  public = list(
    initialize = function(op, url, version, constraint = NULL, logger = NULL, ...) {
      namedParams <- list(request = private$name, version = version)
      if(!is.null(constraint)) namedParams <- c(namedParams, constraint = constraint)
      
      #default output schema
      outputSchema <- list(...)$outputSchema
      if(is.null(outputSchema)){
        outputSchema <- private$defaultOutputSchema
        namedParams <- c(namedParams, outputSchema = outputSchema)
      }
      
      #other default params
      typeNames <- switch(outputSchema,
        "http://www.isotc211.org/2005/gmd" = "gmd:MD_Metadata",
        "http://www.isotc211.org/2005/gfc" = "gfc:FC_FeatureCatalogue",
        "http://www.opengis.net/cat/csw/2.0.2" = "csw:Record",
        "http://www.w3.org/ns/dcat#" = "dcat"
      )
      namedParams <- c(namedParams, typeNames = typeNames)
      namedParams[["resultType"]] <- "results"
      namedParams[["CONSTRAINTLANGUAGE"]] <- "CQL_TEXT"
      
      super$initialize(op, url, namedParams, mimeType = "text/xml", logger = logger, ...)
      
      #bindings
      self$response <- switch(outputSchema,
        "http://www.isotc211.org/2005/gmd" = {
          out <- NULL
          xmlObjs <- getNodeSet(self$response, "//ns:MD_Metadata", c(ns = outputSchema))
          if(length(xmlObjs)>0){
            out <- lapply(xmlObjs,function(xmlObj){
              out.obj <- geometa::ISOMetadata$new()
              out.obj$decode(xml = xmlObj)
              return(out.obj)
            })
          }
          out
        },
        "http://www.isotc211.org/2005/gfc" = {
          out <- NULL
          xmlObjs <- getNodeSet(self$response, "//ns:FC_FeatureCatalogue", c(ns = outputSchema))
          if(length(xmlObjs)>0){
            out <- lapply(xmlObjs,function(xmlObj){
              out.obj <- geometa::ISOFeatureCatalogue$new()
              out.obj$decode(xml = xmlObj)
              return(out.obj)
            })
          }
          out
        },
        "http://www.opengis.net/cat/csw/2.0.2" = {
          warnings(sprintf("R binding not yet supported for '%s'", outputSchema))
          self$response
        },
        "http://www.w3.org/ns/dcat#" = {
          warnings(sprintf("R binding not yet supported for '%s'", outputSchema))
          self$response
        }
      )
    }
  )
)