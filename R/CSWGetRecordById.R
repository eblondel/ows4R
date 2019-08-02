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
#'  \item{\code{new(op, url, serviceVersion, user, pwd, token, id, elementSetName, logger, ...)}}{
#'    This method is used to instantiate a CSWGetRecordById object
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a CSW GetRecordById request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWGetRecordById <- R6Class("CSWGetRecordById",
    inherit = OWSRequest,
    private = list(
      xmlElement = "GetRecordById",
      xmlNamespace = c(csw = "http://www.opengis.net/cat/csw"),
      defaultAttrs = list(
        service = "CSW",
        version = "2.0.2",
        outputSchema= "http://www.opengis.net/cat/csw"
      )
    ),
    public = list(
      Id = NA,
      ElementSetName = "full",
      initialize = function(op, url, serviceVersion = "2.0.2",
                            user = NULL, pwd = NULL, token = NULL,
                            id, elementSetName = "full", logger = NULL, ...) {
        self$Id = id
        allowedElementSetNames <- c("full", "brief", "summary")
        if(!(elementSetName %in% allowedElementSetNames)){
          stop(sprintf("elementSetName value should be among following values: [%s]",
                       paste(allowedElementSetNames, collapse=",")))
        }
        self$ElementSetName = elementSetName
        super$initialize(op, "POST", url, request = private$xmlElement,
                         user = user, pwd = pwd, token = token,
                         contentType = "text/xml", mimeType = "text/xml",
                         logger = logger, ...)
        
        nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
        private$xmlNamespace = paste(private$xmlNamespace, nsVersion, sep="/")
        names(private$xmlNamespace) <- ifelse(serviceVersion=="3.0.0", "csw30", "csw")
        
        self$attrs <- private$defaultAttrs
        
        #serviceVersion
        self$attrs$version = serviceVersion
        
        #output schema
        self$attrs$outputSchema = paste(self$attrs$outputSchema, nsVersion, sep="/")
        outputSchema <- list(...)$outputSchema
        if(!is.null(outputSchema)){
          self$attrs$outputSchema = outputSchema
        }
        
        #execute
        self$execute()
        
        #check response in case of ISO
        outputSchema <- self$attrs$outputSchema
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
            out <- NULL
            warnMsg <- sprintf("R Dublin Core binding not yet supported for '%s'", outputSchema)
            warnings(warnMsg)
            self$WARN(warnMsg)
            self$WARN("Dublin Core returned as R list...")
            recordsXML <- getNodeSet(private$response, "//csw:Record", private$xmlNamespace[1])
            if(length(recordsXML)>0){
              recordXML <- recordsXML[[1]]
              children <- xmlChildren(recordXML)
              out <- lapply(children, xmlValue)
              names(out) <- names(children)
            }
            out
          },
          "http://www.opengis.net/cat/csw/3.0" = {
            out <- NULL
            warnMsg <- sprintf("R Dublin Core binding not yet supported for '%s'", outputSchema)
            warnings(warnMsg)
            self$WARN(warnMsg)
            self$WARN("Dublin Core returned as R list...")
            recordsXML <- getNodeSet(private$response, "//csw30:Record", private$xmlNamespace[1])
            if(length(recordsXML)>0){
              recordXML <- recordsXML[[1]]
              children <- xmlChildren(recordXML)
              out <- lapply(children, xmlValue)
              names(out) <- names(children)
            }
            out
          },
          "http://www.w3.org/ns/dcat#" = {
            warnings(sprintf("R binding not yet supported for '%s'", outputSchema))
            private$response
          }
        )
      }
    )
)