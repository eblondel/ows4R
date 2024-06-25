#' OWSServiceIdentification
#'
#' @docType class
#' @export
#' @keywords OGC OWS Service Identification
#' @return Object of \code{\link[R6]{R6Class}} for modelling an OGC Service Identification
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Abstract class used internally by \pkg{ows4R}
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
     fetchServiceIdentification = function(xmlObj, owsVersion, serviceVersion){
       
       namespaces <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
       }
       namespaces <- as.data.frame(namespaces)
       
       serviceXML <- NULL
       if(nrow(namespaces) > 0){
          namespaceURI <- NULL
          if(any(sapply(namespaces$uri, endsWith, "ows"))){
             namespaceURI <- paste(namespaces[which(sapply(namespaces$uri, endsWith, "ows")), "uri"], owsVersion, sep ="/")
          }else{
             namespaceURI <- paste(namespaces[1L, "uri"])
          }
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
      
     #'@description Initializes an object of class \link{OWSServiceIdentification}
      #'@param xmlObj object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
      #'@param owsVersion OWS version
      #'@param serviceVersion service version
     initialize = function(xmlObj, owsVersion, serviceVersion){
       serviceIdentification <- private$fetchServiceIdentification(xmlObj, owsVersion, serviceVersion)
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
     
     #'@description Get service identification - name
     #'@return the name, object of class \code{character}
     getName = function(){
       return(private$name)
     },
     
     #'@description Get service identification - title
     #'@return the title, object of class \code{character}
     getTitle = function(){
       return(private$title)
     },
     
     #'@description Get service identification - abstract
     #'@return the abstract, object of class \code{character}
     getAbstract = function(){
       return(private$abstract)
     },
     
     #'@description Get service identification - keywords
     #'@return the keywords, object of class \code{character}
     getKeywords = function(){
       return(private$keywords)
     },
     
     #'@description Get service identification - online resource
     #'@return the online resource, object of class \code{character}
     getOnlineResource = function(){
       return(private$onlineResource)
     },
     
     #'@description Get service identification - service type
     #'@return the service type, object of class \code{character}
     getServiceType = function(){
       return(private$serviceType)
     },
     
     #'@description Get service identification - service type version
     #'@return the service type version, object of class \code{character}
     getServiceTypeVersion = function(){
       return(private$serviceTypeVersion)
     },
     
     #'@description Get service identification - fees
     #'@return the fees, object of class \code{character}
     getFees = function(){
       return(private$fees)
     },
     
     #'@description Get service identification - access constraints
     #'@return the access constraints, object of class \code{character}
     getAccessConstraints = function(){
       return(private$accessConstraints)
     }
   )
)