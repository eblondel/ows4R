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
#' \dontrun{
#'    CSWClient$new("http://localhost:8080/geonetwork/srv/eng/csw", serviceVersion = "2.0.2")
#' }
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, serviceVersion, user, pwd, logger)}}{
#'    This method is used to instantiate a CSWClient with the \code{url} of the
#'    OGC service. Authentication (\code{user}/\code{pwd}) is not yet supported and will
#'    be added with the support of service transactional modes. By default, the \code{logger}
#'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
#'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
#'  }
#'  \item{\code{getCapabilities()}}{
#'    Get service capabilities. Inherited from OWS Client
#'  }
#'  \item{\code{describeRecord(namespace, ...)}}{
#'    Describe records. Retrieves the XML schema for CSW records. By default, returns the XML schema 
#'    for the CSW records (http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the
#'    \code{outputSchema} required, e.g. http://www.isotc211.org/2005/gmd for ISO 19115/19139 schema
#'  }
#'  \item{\code{getRecordById(id, ...)}}{
#'    Get a record by Id. By default, the record will be returned following the CSW schema 
#'    (http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the
#'    \code{outputSchema} required,  e.g. http://www.isotc211.org/2005/gmd for ISO 19115/19139 records.
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
     initialize = function(url, serviceVersion = NULL, user = NULL, pwd = NULL, logger = NULL) {
       super$initialize(url, service = private$serviceName, serviceVersion, user, pwd, logger)
       self$capabilities = CSWCapabilities$new(self$url, self$version, logger = logger)
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
       request <- CSWDescribeRecord$new(op, self$getUrl(), self$getVersion(), namespace = namespace, logger = self$loggerType, ...)
       return(request$getResponse())
     },
     
     #getRecordById
     getRecordById = function(id, ...){
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
       request <- CSWGetRecordById$new(op, self$getUrl(), self$getVersion(), id = id, logger = self$loggerType, ...)
       return(request$getResponse())
     },
     
     #getRecords
     getRecords = function(query = NULL, ...){
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
       request <- CSWGetRecords$new(op, self$getUrl(), self$getVersion(),
                                    query = query, logger = self$loggerType, ...)
       return(request$getResponse())
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
       transaction <- CSWTransaction$new(op, cswt_url, self$getVersion(), type = type, user = self$getUser(), pwd = self$getPwd(),
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
         result <- getNodeSet(transaction$getResponse(),paste0("//csw:total",summaryKey),
                                c(csw = xmlNamespaces(transaction$getResponse())$csw$uri))
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
       return(self$transaction("Update", record = record, recordProperty = recordProperty, constraint = constraint, ...))
     },
     
     #deleteRecord
     deleteRecord = function(record = NULL, constraint = NULL, ...){
       return(self$transaction("Delete", record = record, constraint = constraint, ...))
     },
     
     #deleteRecordById
     deleteRecordById = function(id){
       ogcFilter = OGCFilter$new( PropertyIsEqualTo$new("apiso:Identifier", id) )
       cswConstraint = CSWConstraint$new(filter = ogcFilter)
       return(self$deleteRecord(constraint = cswConstraint))
     }
   )
)

