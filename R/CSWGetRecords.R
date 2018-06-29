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
    xmlElement = "GetRecords",
    xmlNamespace = c(csw = "http://www.opengis.net/cat/csw"),
    defaultAttrs = list(
      service = "CSW",
      version = "2.0.2",
      resultType = "results",
      startPosition = "1",
      maxRecords = "5",
      outputFormat="application/xml",
      outputSchema= "http://www.opengis.net/cat/csw"
    )
  ),
  public = list(
    Query = NULL,
    initialize = function(op, url, version = "2.0.2", query = NULL, logger = NULL, ...) {
      super$initialize(op, "POST", url, request = private$xmlElement,
                       contentType = "text/xml", mimeType = "text/xml",
                       logger = logger, ...)
      
      nsName <- names(private$xmlNamespace)
      private$xmlNamespace = paste(private$xmlNamespace, version, sep="/")
      names(private$xmlNamespace) <- nsName
      
      self$attrs <- private$defaultAttrs
      
      #version
      self$attrs$version = version
      
      #resultsType
      resultType <- list(...)$resultType
      if(!is.null(resultType)){
        self$attrs$resultType = resultType
      }
      
      #startPosition
      startPosition <- list(...)$startPosition
      if(!is.null(startPosition)){
        self$attrs$startPosition = startPosition
      }
      
      #maxRecords
      maxRecords <- list(...)$maxRecords
      if(!is.null(maxRecords)){
        self$attrs$maxRecords <- maxRecords
      }
      
      #outputFormat
      outputFormat <- list(...)$outputFormat
      if(!is.null(outputFormat)){
        self$attrs$outputFormat = outputFormat
      }
      
      #output schema
      self$attrs$outputSchema = paste(self$attrs$outputSchema, version, sep="/")
      outputSchema <- list(...)$outputSchema
      if(!is.null(outputSchema)){
        self$attrs$outputSchema = outputSchema
      }
      
      #typeNames value to pass to CSWQuery
      typeNames <- switch(self$attrs$outputSchema,
        "http://www.isotc211.org/2005/gmd" = "gmd:MD_Metadata",
        "http://www.isotc211.org/2005/gfc" = "gfc:FC_FeatureCatalogue",
        "http://www.opengis.net/cat/csw/2.0.2" = "csw:Record",
        "http://www.opengis.net/cat/csw/3.0" = "csw:Record",
        "http://www.w3.org/ns/dcat#" = "dcat"
      )
      if(typeNames != "csw:Record"){
        private$xmlNamespace = c(private$xmlNamespace, ns = self$attrs$outputSchema)
        names(private$xmlNamespace)[2] <- unlist(strsplit(typeNames,":"))[1]
      }
      
      if(!is.null(query)){
        if(!is(query, "CSWQuery")){
          stop("The argument 'query' should be an object of class 'CSWQuery'")
        }
        query$attrs$typeNames = typeNames
        self$Query = query
      }
      
      #execute
      self$execute()
      
      #bindings
      private$response <- switch(self$attrs$outputSchema,
        "http://www.isotc211.org/2005/gmd" = {
          out <- NULL
          xmlObjs <- getNodeSet(private$response, "//ns:MD_Metadata", c(ns = outputSchema))
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
          xmlObjs <- getNodeSet(private$response, "//ns:FC_FeatureCatalogue", c(ns = outputSchema))
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
          warnMsg <- sprintf("R Dublin Core binding not yet supported for '%s'", outputSchema)
          warnings(warnMsg)
          self$WARN(warnMsg)
          self$WARN("Dublin Core returned as R lists...")
          out <- private$response
          if(query$ElementSetName == "full"){
            out <- list()
            recordsXML <- getNodeSet(private$response, "//csw:GetRecordsResponse/csw:SearchResults/csw:Record", private$xmlNamespace[1])
            if(length(recordsXML)>0){
              out <- lapply(recordsXML, function(recordXML){
                children <- xmlChildren(recordXML)
                out.obj <- lapply(children, xmlValue)
                names(out.obj) <- names(children)
                return(out.obj)
              })
            }
          }
          out
        },
        "http://www.opengis.net/cat/csw/3.0" = {
          warnMsg <- sprintf("R Dublin Core binding not yet supported for '%s'", outputSchema)
          self$WARN(warnMsg); warnings(warnMsg)
          self$WARN("Dublin Core records returned as R lists...")
          out <- private$response
          if(query$ElementSetName == "full"){
            out <- list()
            recordsXML <- getNodeSet(private$response, "//csw:GetRecordsResponse/csw:SearchResults/csw:Record", private$xmlNamespace[1])
            if(length(recordsXML)>0){
              out <- lapply(recordsXML, function(recordXML){
                children <- xmlChildren(recordXML)
                out.obj <- lapply(children, xmlValue)
                names(out.obj) <- names(children)
                return(out.obj)
              })
            }
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