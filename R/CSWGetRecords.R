#' CSWGetRecords
#'
#' @docType class
#' @export
#' @keywords OGC CSW GetRecords
#' @return Object of \code{\link[R6]{R6Class}} for modelling a CSW GetRecords request
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a CSW GetRecords request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWGetRecords <- R6Class("CSWGetRecords",
  inherit = OWSHttpRequest,
  private = list(
    xmlElement = "GetRecords",
    xmlNamespacePrefix = "CSW",
    xmlExtraNamespaces = c(),
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
    #'@field Query query property for request XML encoding
    Query = NULL,
    
    #'@description Initializes a \link{CSWGetRecordById} service request
    #'@param capabilities an object of class \link{CSWCapabilities}
    #'@param op object of class \link{OWSOperation} as retrieved from capabilities
    #'@param url url
    #'@param serviceVersion serviceVersion. Default is "2.0.2
    #'@param user user
    #'@param pwd password
    #'@param token token
    #'@param headers headers
    #'@param config config
    #'@param query object of class \link{CSWQuery}
    #'@param logger logger
    #'@param ... any parameter to pass to the service request, such as \code{resultType}, \code{startPosition},
    #' \code{maxRecords}, \code{outputFormat}, or \code{outputSchema}
    initialize = function(capabilities, op, url, serviceVersion = "2.0.2", 
                          user = NULL, pwd = NULL, token = NULL, headers = list(), config = httr::config(),
                          query = NULL, logger = NULL, ...) {
      nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", nsVersion), sep="_")
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                       capabilities, op, "POST", url, request = private$xmlElement,
                       user = user, pwd = pwd, token = token, headers = headers, config = config,
                       contentType = "text/xml", mimeType = "text/xml",
                       logger = logger, ...)
      
      self$attrs <- private$defaultAttrs
      
      #version
      self$attrs$version = serviceVersion
      
      #resultsType
      resultType <- list(...)$resultType
      if(!is.null(resultType)){
        self$attrs$resultType = resultType
      }
      if(serviceVersion=="3.0.0") self$attrs$resultType = NULL
      
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
      self$attrs$outputSchema = paste(self$attrs$outputSchema, nsVersion, sep="/")
      outputSchema <- list(...)$outputSchema
      if(!is.null(outputSchema)){
        self$attrs$outputSchema = outputSchema
      }
      
      #typeNames value to pass to CSWQuery
      typeNames <- switch(self$attrs$outputSchema,
        "http://www.isotc211.org/2005/gmd" = "gmd:MD_Metadata",
        "http://standards.iso.org/iso/19115/-3/mdb/2.0" = "mdb:MD_Metadata",
        "http://www.isotc211.org/2005/gfc" = "gfc:FC_FeatureCatalogue",
        "http://standards.iso.org/iso/19110/gfc/1.1" = "gfc:FC_FeatureCatalogue",
        "http://www.opengis.net/cat/csw/2.0.2" = "csw:Record",
        "http://www.opengis.net/cat/csw/3.0" = "csw30:Record",
        "http://www.w3.org/ns/dcat#" = "dcat"
      )
      #namespace extension
      ns <- unlist(getOWSNamespace(private$xmlNamespacePrefix)$getDefinition())
      if(!(typeNames %in% c("csw:Record","csw30:Record"))){
        ns = c(ns, ns = self$attrs$outputSchema)
        names(ns)[2] <- unlist(strsplit(typeNames,":"))[1]
        #adding extra namespace
        private$xmlExtraNamespaces <- c(ns = self$attrs$outputSchema)
        names(private$xmlExtraNamespaces) <- unlist(strsplit(typeNames,":"))[1]
      }
      
      if(!is.null(query)){
        if(!is(query, "CSWQuery")){
          stop("The argument 'query' should be an object of class 'CSWQuery'")
        }
        query$attrs$typeNames = typeNames
        if(startsWith(serviceVersion, "3")){
          query$namespace <- getOWSNamespace("CSW_3_0")
        }
        self$Query = query
      }
      
      #execute
      self$execute()
      
      #inherit meta attributes
      searchResults <- getNodeSet(private$response, paste0("//",names(ns)[1],":SearchResults"), namespaces = ns)[[1]]
      searchResultsAttrs <- as.list(xmlAttrs(searchResults))
      searchResultsAttrs$nextRecord <- as.integer(searchResultsAttrs$nextRecord)
      searchResultsAttrs$numberOfRecordsMatched <- as.integer(searchResultsAttrs$numberOfRecordsMatched)
      searchResultsAttrs$numberOfRecordsReturned <- as.integer(searchResultsAttrs$numberOfRecordsReturned)
      
      self$INFO(sprintf("Retrieving records %s to %s ...",
                        as.integer(self$attrs$startPosition),
                        as.integer(self$attrs$startPosition) + (searchResultsAttrs$numberOfRecordsReturned-1)))
      
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
          attributes(out) <- searchResultsAttrs
          out
        },
        "http://standards.iso.org/iso/19115/-3/mdb/2.0" = {
          out <- NULL
          xmlObjs <- getNodeSet(private$response, "//ns:MD_Metadata", c(ns = outputSchema))
          if(length(xmlObjs)>0){
            out <- lapply(xmlObjs,function(xmlObj){
              geometa::setMetadataStandard("19115-3")
              out.obj <- geometa::ISOMetadata$new()
              out.obj$decode(xml = xmlObj)
              return(out.obj)
            })
          }
          attributes(out) <- searchResultsAttrs
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
          attributes(out) <- searchResultsAttrs
          out
        },
        "http://standards.iso.org/iso/19110/gfc/1.1" = {
          out <- NULL
          xmlObjs <- getNodeSet(private$response, "//ns:FC_FeatureCatalogue", c(ns = outputSchema))
          if(length(xmlObjs)>0){
            out <- lapply(xmlObjs,function(xmlObj){
              geometa::setMetadataStandard("19115-3")
              out.obj <- geometa::ISOFeatureCatalogue$new()
              out.obj$decode(xml = xmlObj)
              return(out.obj)
            })
          }
          attributes(out) <- searchResultsAttrs
          out
        },
        "http://www.opengis.net/cat/csw/2.0.2" = {
          warnMsg <- sprintf("R Dublin Core binding not yet supported for '%s'", outputSchema)
          warnings(warnMsg)
          self$WARN(warnMsg)
          self$WARN("Dublin Core returned as R lists...")
          out <- private$response
          resultElement <- switch(query$ElementSetName,
            "full" = "csw:Record",
            "brief" = "csw:BriefRecord",
            "summary" = "csw:SummaryRecord"
          )
          out <- list()
          recordsXML <- getNodeSet(private$response,paste0("//csw:GetRecordsResponse/csw:SearchResults/",resultElement), namespaces = ns)
          if(length(recordsXML)>0){
            out <- lapply(recordsXML, function(recordXML){
              children <- xmlChildren(recordXML)
              out.obj <- lapply(children, xmlValue)
              names(out.obj) <- names(children)
              return(out.obj)
            })
          }
          attributes(out) <- searchResultsAttrs
          out
        },
        "http://www.opengis.net/cat/csw/3.0" = {
          warnMsg <- sprintf("R Dublin Core binding not yet supported for '%s'", outputSchema)
          self$WARN(warnMsg); warnings(warnMsg)
          self$WARN("Dublin Core records returned as R lists...")
          out <- private$response
          resultElement <- switch(query$ElementSetName,
            "full" = "csw30:Record",
            "brief" = "csw30:BriefRecord",
            "summary" = "csw30:SummaryRecord"
          )
          out <- list()
          recordsXML <- getNodeSet(private$response,paste0("//csw30:GetRecordsResponse/csw30:SearchResults/",resultElement), namespaces = ns)
          if(length(recordsXML)>0){
            out <- lapply(recordsXML, function(recordXML){
              children <- xmlChildren(recordXML)
              out.obj <- lapply(children, xmlValue)
              names(out.obj) <- names(children)
              return(out.obj)
            })
          }
          attributes(out) <- searchResultsAttrs
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