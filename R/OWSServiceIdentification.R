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
#'  \item{\code{new(xmlObj, serviceVersion)}}{
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
     fetchServiceIdentification = function(xmlObj, serviceVersion){
       
       namespaces <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
       }
       namespaces <- as.data.frame(namespaces)
       namespaceURI <- paste("http://www.opengis.net/ows", serviceVersion, sep ="/")
       
       serviceXML <- NULL
       if(nrow(namespaces) > 0){
          ns <- OWSUtils$findNamespace(namespaces, uri = namespaceURI)
          if(length(ns)>0){
              serviceXML <- getNodeSet(xmlObj, "//ns:Service", ns)
              if(length(serviceXML)==0) serviceXML <- getNodeSet(xmlObj, "//ns:ServiceIdentification", ns)
          }
          if(length(serviceXML)==0){
            ns <- OWSUtils$findNamespace(namespaces, id = "ows")
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
             serviceKeywords <- sapply(serviceKeywordListXML, function(x){
               if(xmlName(x)=="Keyword") return(xmlValue(x))})
             serviceKeywords <- serviceKeywords[!sapply(serviceKeywords, is.null)]
             serviceKeywords <- as.vector(unlist(serviceKeywords))
           }
           
         }
         if(!is.null(children$OnlineResource)){
           serviceOnlineResource <- xmlValue(children$OnlineResource)
         }
         if(!is.null(children$ServiceType)){
           serviceType <- xmlValue(children$ServiceType)
         }
         if(!is.null(children$ServiceTypeVersion)){
           serviceTypeVersions <- getNodeSet(serviceXML, "//ns:ServiceTypeVersion", ns)
           serviceTypeVersion <- sapply(serviceTypeVersions, xmlValue)
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
     initialize = function(xmlObj, serviceVersion){
       serviceIdentification <- private$fetchServiceIdentification(xmlObj, serviceVersion)
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