#' CSWClient
#'
#' @docType class
#' @export
#' @keywords OGC CSW catalogue service web
#' @return Object of \code{\link{R6Class}} with methods for interfacing an OGC
#' Catalogue Service for the Web.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \donttest{
#'    #example based on CSW endpoint responding at http://localhost:8000/csw
#'    csw <- CSWClient$new("http://localhost:8000/csw", serviceVersion = "2.0.2")
#'    
#'    #get capabilities
#'    caps <- csw$getCapabilities()
#'    
#'    #get records
#'    records <- csw$getRecords()
#'    
#'    #get record by id
#'    record <- csw$getRecordById("my-metadata-id")
#'    
#'    #Advanced examples at https://github.com/eblondel/ows4R/wiki#csw
#'  }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, serviceVersion, user, pwd, token, logger)}}{
#'    This method is used to instantiate a CSWClient with the \code{url} of the
#'    OGC service. Authentication is supported using basic auth (using \code{user}/\code{pwd} arguments), 
#'    bearer token (using \code{token} argument), or custom (using \code{headers} argument). By default, the \code{logger}
#'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
#'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
#'  }
#'  \item{\code{getCapabilities()}}{
#'    Get service capabilities. Inherited from OWS Client
#'  }
#'  \item{\code{reloadCapabilities()}}{
#'    Reload service capabilities
#'  }
#'  \item{\code{describeRecord(namespace, ...)}}{
#'    Describe records. Retrieves the XML schema for CSW records. By default, returns the XML schema 
#'    for the CSW records (http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the
#'    \code{outputSchema} required, e.g. http://www.isotc211.org/2005/gmd for ISO 19115/19139 schema
#'  }
#'  \item{\code{getRecordById(id, elementSetName, ...)}}{
#'    Get a record by Id. By default, the record will be returned following the CSW schema 
#'    (http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the \code{outputSchema} 
#'    required,  e.g. http://www.isotc211.org/2005/gmd for ISO 19115/19139 records.
#'    The parameter \code{elementSetName} should among values "full", "brief", "summary". The default
#'    "full" corresponds to the full metadata sheet returned. "brief" and "summary" will contain only
#'    a subset of the metadata content.
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWClient <- R6Class("CSWClient",
   inherit = OWSClient,
   private = list(
     serviceName = "CSW"
   ),
   public = list(
     #initialize
     initialize = function(url, serviceVersion = NULL, 
                           user = NULL, pwd = NULL, token = NULL, headers = c(),
                           logger = NULL) {
       if(startsWith(serviceVersion, "3.0")) serviceVersion <- "3.0.0"
       super$initialize(url, service = private$serviceName, serviceVersion, user, pwd, token, headers, logger)
       self$capabilities = CSWCapabilities$new(self$url, self$version, 
                                               user = user, pwd = pwd, token = token, headers = headers,
                                               logger = logger)
     },
     
     #getCapabilities
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #reloadCapabilities
     reloadCapabilities = function(){
      self$capabilities = CSWCapabilities$new(self$url, self$version, 
                                              user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                              logger = self$loggerType)
     },
     
     #describeRecord
     describeRecord = function(namespace, ...){
       self$INFO("Fetching schema...")
       operations <- self$capabilities$getOperationsMetadata()$getOperations()
       op <- operations[sapply(operations,function(x){x$getName()=="DescribeRecord"})]
       if(length(op)>0){
         op <- op[[1]]
       }else{
         errorMsg <- "Operation 'DescribeRecord' not supported by this service"
         self$ERROR(errorMsg)
         stop(errorMsg)
       }
       request <- CSWDescribeRecord$new(op, self$getUrl(), self$getVersion(), 
                                        user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                        namespace = namespace, logger = self$loggerType, ...)
       return(request$getResponse())
     },
     
     #getRecordById
     getRecordById = function(id, elementSetName = "full", ...){
       self$INFO(sprintf("Fetching record '%s' ...", id))
       operations <- self$capabilities$getOperationsMetadata()$getOperations()
       op <- operations[sapply(operations,function(x){x$getName()=="GetRecordById"})]
       if(length(op)>0){
         op <- op[[1]]
       }else{
         errorMsg <- "Operation 'GetRecordById' not supported by this service"
         self$ERROR(errorMsg)
         stop(errorMsg)
       }
       request <- CSWGetRecordById$new(op, self$getUrl(), self$getVersion(),
                                       user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                       id = id, elementSetName = elementSetName,
                                       logger = self$loggerType, ...)
       return(request$getResponse())
     },
     
     #getRecords
     getRecords = function(query = CSWQuery$new(), maxRecords = NULL, maxRecordsPerRequest = 10L, ...){
       self$INFO("Fetching records ...")
       operations <- self$capabilities$getOperationsMetadata()$getOperations()
       op <- operations[sapply(operations,function(x){x$getName()=="GetRecords"})]
       if(length(op)>0){
         op <- op[[1]]
       }else{
         errorMsg <- "Operation 'GetRecords' not supported by this service"
         self$ERROR(errorMsg)
         stop(errorMsg)
       }
       query$setServiceVersion(self$getVersion())
       
       hasMaxRecords <- !is.null(maxRecords)
       if(hasMaxRecords) if(maxRecords < maxRecordsPerRequest) maxRecordsPerRequest <- maxRecords
       
       firstRequest <- CSWGetRecords$new(op, self$getUrl(), self$getVersion(),
                                    user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                    query = query, logger = self$loggerType, 
                                    maxRecords = maxRecordsPerRequest, ...)
       records <- firstRequest$getResponse()
       
       numberOfRecordsMatched <- attr(records, "numberOfRecordsMatched")
       numberOfRecordsMatchedSafe <- numberOfRecordsMatched
       
       if(hasMaxRecords){
         numberOfRecordsMatched <- maxRecords
         if(length(records) >= maxRecords){
          records <- records[1:maxRecords]
          return(records)
         }
       }
       nextRecord <- attr(records, "nextRecord")
       while(nextRecord != 0L){
         if(hasMaxRecords) {
           if(maxRecords - length(records) < maxRecordsPerRequest){
            maxRecordsPerRequest <- maxRecords - length(records)
           }
         }else{
           if(numberOfRecordsMatched - length(records) < maxRecordsPerRequest){
             maxRecordsPerRequest <- numberOfRecordsMatched - length(records)
           }
         }
         nextRequest <- CSWGetRecords$new(op, self$getUrl(), self$getVersion(),
                                          user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                          query = query, logger = self$loggerType, 
                                          startPosition = nextRecord, 
                                          maxRecords = maxRecordsPerRequest, ...)
         nextRecords <- nextRequest$getResponse()
         records <- c(records, nextRecords)
         if(length(records) == numberOfRecordsMatched) break
         nextRecord <- attr(nextRecords, "nextRecord")
         if(nextRecord > numberOfRecordsMatchedSafe) nextRecord <- 0L
       }
       return(records)
     },
     
     #transaction
     transaction = function(type, record = NULL, recordProperty = NULL, constraint = NULL, ...){
       self$INFO(sprintf("Transaction (%s) ...", type))
       operations <- self$capabilities$getOperationsMetadata()$getOperations()
       op <- operations[sapply(operations,function(x){x$getName()=="Transaction"})]
       if(length(op)>0){
         op <- op[[1]]
       }else{
         errorMsg <- "Operation 'Transaction' not supported by this service"
         self$ERROR(errorMsg)
         stop(errorMsg)
       }
       cswt_url <- self$getUrl()
       #special check for Geonetwork url
       if(regexpr("geonetwork",cswt_url) > 0){
         cswt_url <- paste0(cswt_url, "-publication")
         if(is.null(self$getUser()) || is.null(self$getPwd())){
           stop("Geonetwork CSW Transaction service requires user authentication")
         }
       }
       #transation
       transaction <- CSWTransaction$new(op, cswt_url, self$getVersion(), type = type,
                                         user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                         record = record, recordProperty = recordProperty, constraint = constraint, 
                                         logger = self$loggerType, ...)
       
       summaryKey <- switch(type,
         "Insert" = "Inserted",
         "Update" = "Updated",
         "Delete" = "Deleted"
       )
       transaction$setResult(FALSE)
       if(is.null(xmlNamespaces(transaction$getResponse())$csw)){
         return(transaction)
       }else{
         ns <- ifelse(self$getVersion()=="3.0.0", "csw30", "csw")
         nsUri <- xmlNamespaces(transaction$getResponse())[[ns]]$uri
         names(nsUri) <- ifelse(self$getVersion()=="3.0.0", "csw30", "csw")
         result <- getNodeSet(transaction$getResponse(),paste0("//",ns,":total",summaryKey), nsUri)
         if(length(result)>0){
           result <- result[[1]]
           if(xmlValue(result)>0) transaction$setResult(TRUE)
         }
         if(transaction$getResult()){
           self$INFO(sprintf("Successful transaction (%s)!", type))
         }
       }
       return(transaction)
     },
     
     #insertRecord
     insertRecord = function(record, ...){
       return(self$transaction("Insert", record = record, constraint = NULL, ...))
     },
     
     #updateRecord
     updateRecord = function(record = NULL, recordProperty = NULL, constraint = NULL, ...){
       if(!is.null(recordProperty)) if(!is(recordProperty, "CSWRecordProperty")){
         stop("The argument recordProperty should be an object of class 'CSWRecordProperty'")
       }
       if(!is.null(constraint)) if(!is(constraint, "CSWConstraint")){
         stop("The argument constraint should be an object of class 'CSWConstraint'")
       }
       if(!is.null(constraint)) constraint$setServiceVersion(self$getVersion())
       return(self$transaction("Update", record = record, recordProperty = recordProperty, constraint = constraint, ...))
     },
     
     #deleteRecord
     deleteRecord = function(record = NULL, constraint = NULL, ...){
       if(!is.null(constraint)) constraint$setServiceVersion(self$getVersion())
       return(self$transaction("Delete", record = record, constraint = constraint, ...))
     },
     
     #deleteRecordById
     deleteRecordById = function(id){
       ogcFilter = OGCFilter$new( PropertyIsEqualTo$new("apiso:Identifier", id) )
       cswConstraint = CSWConstraint$new(filter = ogcFilter)
       cswConstraint$setServiceVersion(self$getVersion())
       return(self$deleteRecord(constraint = cswConstraint))
     },
     
     #harvestRecord
     harvestRecord = function(sourceUrl, resourceType = "http://www.isotc211.org/2005/gmd"){
       operations <- self$capabilities$getOperationsMetadata()$getOperations()
       op <- operations[sapply(operations,function(x){x$getName()=="Harvest"})]
       if(length(op)>0){
         op <- op[[1]]
       }else{
         errorMsg <- "Operation 'Harvest' not supported by this service"
         self$ERROR(errorMsg)
         stop(errorMsg)
       }
       self$INFO(sprintf("Harvesting '%s' ...", sourceUrl))
       harvest <- CSWHarvest$new(op, self$getUrl(), self$getVersion(), 
                                 source = sourceUrl, resourceType = resourceType, resourceFormat = "application/xml",
                                 logger = self$loggerType)
       
       harvest$setResult(FALSE)
       if(is.null(xmlNamespaces(harvest$getResponse())$csw)){
         return(harvest)
       }else{
         ns <- ifelse(self$getVersion()=="3.0.0", "csw30", "csw")
         nsUri <- xmlNamespaces(harvest$getResponse())[[ns]]$uri
         names(nsUri) <- ifelse(self$getVersion()=="3.0.0", "csw30", "csw")
         inserted <- getNodeSet(harvest$getResponse(),paste0("//",ns,":totalInserted"), nsUri)[[1]]
         updated <- getNodeSet(harvest$getResponse(),paste0("//",ns,":totalUpdated"), nsUri)[[1]]
         deleted <- getNodeSet(harvest$getResponse(),paste0("//",ns,":totalDeleted"), nsUri)[[1]]
         if(xmlValue(inserted)>0 || xmlValue(updated)>0 || xmlValue(deleted)>0){
           harvest$setResult(TRUE)
         }
         if(harvest$getResult()){
           self$INFO("Successful record harvesting (%s)!")
         }
       }
       return(harvest)
     },
     
     #harvestNode
     harvestNode = function(url,
                            query = CSWQuery$new(), resourceType = "http://www.isotc211.org/2005/gmd",
                            sourceBaseUrl){
       nodeHarvest <- NULL
       csw <- CSWClient$new(url = url, serviceVersion = self$getVersion(), 
                            user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                            logger = self$loggerType)
       if(!is.null(csw)){
         records <- csw$getRecords(query = query)
         nodeHarvest$found <- length(records)
         nodeHarvest$harvested <- 0
         for(record in records){
           sourceUrl <- paste0(sourceBaseUrl, record$identifier)
           recHarvest <- self$harvestRecord(sourceUrl, resourceType = resourceType)
           if(recHarvest$getResult()) nodeHarvest$harvested <- nodeHarvest$harvested+1
         }
       }
       return(nodeHarvest)
     }
   )
)
