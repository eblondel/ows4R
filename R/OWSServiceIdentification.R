#' OWSServiceIdentification
#'
#' @docType class
#' @export
#' @keywords OGC OWS Service Identification
#' @return Object of \code{\link{R6Class}} for modelling an OGC Service Identification
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, url, service)}}{
#'    This method is used to instantiate a OWSServiceIdentification object
#'  }
#'  \item{\code{getName()}}{
#'    Get service name
#'  }
#'  \item{\code{getTitle()}}{
#'    Get service title
#'  }
#'  \item{\code{getAbstract()}}{
#'    Get service abstract
#'  }
#'  \item{\code{getKeywords()}}{
#'    Get service keywords
#'  }
#'  \item{\code{getOnlineResource()}}{
#'    Get service online resource
#'  }
#'  \item{\code{getServiceType}}{
#'    Get service type
#'  }
#'  \item{\code{getServiceTypeVersion}}{
#'   Get service type version
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSServiceIdentification <-  R6Class("OWSServiceIdentification",
   private = list(
     name = NA,
     title = NA,
     abstract = NA,
     keywords = NA,
     onlineResource = NA,
     serviceType = NA,
     serviceTypeVersion = NA,
     fees = NA,
     accessConstraints = NA,
     
     #fetchServiceIdentification
     fetchServiceIdentification = function(xmlObj, service, version){
       
       namespaces <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
       }
       namespaces <- as.data.frame(namespaces)
       namespace <- tolower(service)
       
       serviceXML <- NULL
       if(nrow(namespaces) > 0){
          ns <- OWSUtils$findNamespace(namespaces, namespace)
          if(length(ns)>0){
            serviceXML <- getNodeSet(xmlObj, "//ns:Service", ns)
            if(length(serviceXML)==0) serviceXML <- getNodeSet(xmlObj, "//ns:ServiceIdentification", ns)
          }
          if(length(serviceXML)==0){
            ns <- OWSUtils$findNamespace(namespaces, "ows")
            if(length(ns)>0){
              serviceXML <- getNodeSet(xmlObj, "//ns:Service", ns)
              if(length(serviceXML)==0) serviceXML <- getNodeSet(xmlObj, "//ns:ServiceIdentification", ns)
            }
          }
       }else{
         serviceXML <- getNodeSet(xmlObj, "//Service")
         if(length(serviceXML)==0) serviceXML <- getNodeSet(xmlObj, "//ServiceIdentification")
       }
       
       serviceName <- NULL
       serviceTitle <- NULL
       serviceAbstract <- NULL
       serviceKeywords <- NULL
       serviceOnlineResource <- NULL
       serviceType <- NULL
       serviceTypeVersion <- NULL
       serviceFees <- NULL
       serviceAccessConstraints <- NULL
       if(length(serviceXML) > 0){
         
         serviceXML <- serviceXML[[1]]
         
         children <- xmlChildren(serviceXML)
         
         if(!is.null(children$Name)){
           serviceName <- xmlValue(children$Name)
         }
         if(!is.null(children$Title)){
           serviceTitle <- xmlValue(children$Title)
         }
         if(!is.null(children$Abstract)){
           serviceAbstract <- xmlValue(children$Abstract)
         }
         if(!is.null(children$Keywords)){
           
           if(is.character(children$Keywords)){
             serviceKeywords <- strsplit(gsub(" ", "", xmlValue(children$Keywords)), ",")[[1]]
           }else{
             serviceKeywordListXML <- xmlChildren(children$Keywords)
             serviceKeywords <- as.vector(sapply(serviceKeywordListXML, xmlValue))
           }
           
         }
         if(!is.null(children$OnlineResource)){
           serviceOnlineResource <- xmlValue(children$OnlineResource)
         }
         if(!is.null(children$ServiceType)){
           serviceType <- xmlValue(children$ServiceType)
         }
         if(!is.null(children$ServiceTypeVersion)){
           serviceTypeVersion <- xmlValue(children$ServiceTypeVersion)
         }
         if(!is.null(children$Fees)){
           serviceFees <- xmlValue(children$Fees)
         }
         if(!is.null(children$AccessConstraints)){
           serviceAccessConstraints <- xmlValue(children$AccessConstraints)
         }
         
       }
       
       serviceIdentification <- list(
         name = serviceName,
         title = serviceTitle,
         abstract = serviceAbstract,
         keywords = serviceKeywords,
         onlineResource = serviceOnlineResource,
         serviceType = serviceType,
         serviceTypeVersion = serviceTypeVersion,
         fees = serviceFees,
         accessConstraints = serviceAccessConstraints
       )
       
       return(serviceIdentification)
     }
   ),
   public = list(
     initialize = function(xmlObj, service, version){
       serviceIdentification <- private$fetchServiceIdentification(xmlObj, service, version)
       private$name <- serviceIdentification$name
       private$title <- serviceIdentification$title
       private$abstract <- serviceIdentification$abstract
       private$keywords <- serviceIdentification$keywords
       private$onlineResource <- serviceIdentification$onlineResource
       private$serviceType <- serviceIdentification$serviceType
       private$serviceTypeVersion <- serviceIdentification$serviceTypeVersion
       private$fees <- serviceIdentification$fees
       private$accessConstraints <- serviceIdentification$accessConstraints
     },
     
     #getName
     getName = function(){
       return(private$name)
     },
     
     #getTitle
     getTitle = function(){
       return(private$title)
     },
     
     #getAbstract
     getAbstract = function(){
       return(private$abstract)
     },
     
     #getKeywords
     getKeywords = function(){
       return(private$keywords)
     },
     
     #getOnlineResource
     getOnlineResource = function(){
       return(private$onlineResource)
     },
     
     #getServiceType
     getServiceType = function(){
       return(private$serviceType)
     },
     
     #getServiceTypeVersion
     getServiceTypeVersion = function(){
       return(private$serviceTypeVersion)
     },
     
     #getFees
     getFees = function(){
       return(private$fees)
     },
     
     #getAccessConstraints
     getAccessConstraints = function(){
       return(private$accessConstraints)
     }
   )
)