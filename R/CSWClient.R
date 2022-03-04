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
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWClient <- R6Class("CSWClient",
   inherit = OWSClient,
   private = list(
     serviceName = "CSW"
   ),
   public = list(
      
     #'@description This method is used to instantiate a CSWClient with the \code{url} of the
      #'    OGC service. Authentication is supported using basic auth (using \code{user}/\code{pwd} arguments), 
      #'    bearer token (using \code{token} argument), or custom (using \code{headers} argument). By default, the \code{logger}
      #'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
      #'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
      #'@param url url
      #'@param serviceVersion CSW service version
      #'@param user user
      #'@param pwd password
      #'@param token token
      #'@param headers headers
      #'@param cas_url Central Authentication Service (CAS) URL
      #'@param logger logger
     initialize = function(url, serviceVersion = NULL, 
                           user = NULL, pwd = NULL, token = NULL, headers = c(), cas_url = NULL,
                           logger = NULL) {
       if(startsWith(serviceVersion, "3.0")) serviceVersion <- "3.0.0"
       super$initialize(url, service = private$serviceName, serviceVersion = serviceVersion, 
                        user = user, pwd = pwd, token = token, headers = headers, cas_url = cas_url, 
                        logger = logger)
       self$capabilities = CSWCapabilities$new(self$url, self$version, 
                                               user = user, pwd = pwd, token = token, headers = headers,
                                               logger = logger)
       self$capabilities$setClient(self)
     },
     
     #'@description Get CSW capabilities
     #'@return an object of class \link{CSWCapabilities}
     getCapabilities = function(){
       return(self$capabilities)
     },
     
     #'@description Reloads CSW capabilities
     reloadCapabilities = function(){
      self$capabilities = CSWCapabilities$new(self$url, self$version, 
                                              user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                              logger = self$loggerType)
      self$capabilities$setClient(self)
     },
     
     #'@description Describe records. Retrieves the XML schema for CSW records. By default, returns the XML schema 
     #'    for the CSW records (http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the
     #'    \code{outputSchema} required, e.g. http://www.isotc211.org/2005/gmd for ISO 19115/19139 schema
     #'@param namespace namespace
     #'@param ... any other parameter to pass to the \link{CSWDescribeRecord} service request
     #'@return the service record description
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
       request <- CSWDescribeRecord$new(self$capabilities, op, self$getUrl(), self$getVersion(), 
                                        user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                        namespace = namespace, logger = self$loggerType, ...)
       return(request$getResponse())
     },
     
     #'@description Get a record by Id. By default, the record will be returned following the CSW schema 
     #'    (http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the \code{outputSchema} 
     #'    required,  e.g. http://www.isotc211.org/2005/gmd for ISO 19115/19139 records.
     #'    The parameter \code{elementSetName} should among values "full", "brief", "summary". The default
     #'    "full" corresponds to the full metadata sheet returned. "brief" and "summary" will contain only
     #'    a subset of the metadata content.
     #' @param id record id
     #' @param elementSetName element set name. Default is "full"
     #' @param ... any other parameter to pass to \link{CSWGetRecordById} service request
     #' @return the fetched record, \code{NULL} otherwise
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
       request <- CSWGetRecordById$new(self$capabilities, op, self$getUrl(), self$getVersion(),
                                       user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
                                       id = id, elementSetName = elementSetName,
                                       logger = self$loggerType, ...)
       return(request$getResponse())
     },
     
     #'@description Get records based on a query, object of class \code{CSWQuery}. The maximum number of records can be
     #'    set either for the full query (\code{maxRecords}) or per request (\code{maxRecordsPerRequest}, default set to 10 records)
     #'    considering this operation is paginated. By default, the record will be returned following the CSW schema 
     #'    (http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the \code{outputSchema} 
     #'    required,  e.g. http://www.isotc211.org/2005/gmd for ISO 19115/19139 records.
     #'@param query an object of class \link{CSWQuery}. By default, an empty query is set.
     #'@param maxRecords max number of total records. Default is \code{NULL} meaning all records are returned.
     #'@param maxRecordsPerRequest max number of records to return per request. Default set to 10.
     #'@param ... any other parameter to be passed to \link{CSWGetRecords} service request
     #'@return the list of records. By default each record will be returned as Dublin Core \code{list} object. In case 
     #'  ISO 19115/19139 is set as \code{outputSchema}, each record will be object of class \code{ISOMetadata} from 
     #'  \pkg{geometa}.
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
       
       firstRequest <- CSWGetRecords$new(self$capabilities, op, self$getUrl(), self$getVersion(),
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
         nextRequest <- CSWGetRecords$new(self$capabilities, op, self$getUrl(), self$getVersion(),
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
     
     #'@description Generic transaction method. Used for inserting, updating or deleting metadata using the transactional CSW service.
     #'    The \code{type} gives the type of transaction (Insert, Update, or Delete). The record
     #'@param type of transaction either "Insert", "Update" or "Delete"
     #'@param record the record subject of the transaction
     #'@param recordProperty record property, object of class \link{CSWRecordProperty}
     #'@param constraint constraint, object of class \link{CSWConstraint}
     #'@param ... any other parameter to pass to \link{CSWTransaction} service request
     #'@return \code{TRUE} if transaction succeeded, \code{FALSE} otherwise
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
       transaction <- CSWTransaction$new(self$capabilities, op, cswt_url, self$getVersion(), type = type,
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
     
     #'@description Inserts a new record
     #'@param record record subject of the Insertion
     #'@param ... any other parameter to pass to the transaction
     #'@return \code{TRUE} if insertion succeeded, \code{FALSE} otherwise
     insertRecord = function(record, ...){
       return(self$transaction("Insert", record = record, constraint = NULL, ...))
     },
     
     #'@description Updates an existing record
     #'@param record record subject of the Insertion
     #'@param recordProperty record property, object of class \link{CSWRecordProperty}
     #'@param constraint constraint, object of class \link{CSWConstraint}
     #'@param ... any other parameter to pass to the transaction
     #'@return \code{TRUE} if update succeeded, \code{FALSE} otherwise
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
     
     #'@description Deletes an existing (set of) record(s).  A constraint (object of class \code{CSWConstraint}) 
     #' can be specified to limit the deletion to some records.
     #'@param record record subject of the Insertion
     #'@param constraint constraint, object of class \link{CSWConstraint}
     #'@param ... any other parameter to pass to the transaction
     #'@return \code{TRUE} if deletion succeeded, \code{FALSE} otherwise
     deleteRecord = function(record = NULL, constraint = NULL, ...){
       if(!is.null(constraint)) constraint$setServiceVersion(self$getVersion())
       return(self$transaction("Delete", record = record, constraint = constraint, ...))
     },
     
     #'@description Deletes an existing record by identifier (constraint used to identify the record based on its identifier).
     #'@param id record id
     #'@return \code{TRUE} if deletion succeeded, \code{FALSE} otherwise
     deleteRecordById = function(id){
       ogcFilter = OGCFilter$new( PropertyIsEqualTo$new("apiso:Identifier", id) )
       cswConstraint = CSWConstraint$new(filter = ogcFilter)
       cswConstraint$setServiceVersion(self$getVersion())
       return(self$deleteRecord(constraint = cswConstraint))
     },
     
     #'@description Harvests a single record from a \code{sourceUrl}, given a \code{resourceType} (by default "http://www.isotc211.org/2005/gmd").
     #'@param sourceUrl source URL
     #'@param resourceType resource type. Default is "http://www.isotc211.org/2005/gmd"
     #'@return \code{TRUE} if harvesting succeeded, \code{FALSE} otherwise
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
       harvest <- CSWHarvest$new(self$capabilities, op, self$getUrl(), self$getVersion(),
                                 user = self$getUser(), pwd = self$getPwd(), token = self$getToken(), headers = self$getHeaders(),
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
     
     #'@description Harvests a CSW node (having its endpoint defined by an  \code{url}). A \code{query} (object of class \code{CSWQuery}) can be
     #'    specificed if needed to restrain the harvesting to a subset. The \code{resourceType} defines the type of resources to be harvested
     #'    (by default "http://www.isotc211.org/2005/gmd")
     #'@param url CSW node URL
     #'@param query a CSW query, object of class \link{CSWQuery}
     #'@param resourceType resource type. Default is "http://www.isotc211.org/2005/gmd"
     #'@param sourceBaseUrl source base URL
     #'@return an object of class \code{list} giving the number of records \code{found} and those actually \code{harvested}
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
