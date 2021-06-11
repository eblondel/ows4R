#' OWSServiceProvider
#'
#' @docType class
#' @export
#' @keywords OGC OWS Service Provider
#' @return Object of \code{\link{R6Class}} for modelling an OGC Service Provider
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, owsVersion, serviceVersion)}}{
#'    This method is used to instantiate a OWSServiceProvider object
#'  }
#'  \item{\code{getProviderName()}}{
#'    Get the provider name
#'  }
#'  \item{\code{getProviderSite()}}{
#'    Get the provide site
#'  }
#'  \item{\code{getServiceContact()}}{
#'    Get the service contact, as object of class \code{ISOResponsibleParty}
#'    from package \pkg{geometa}
#'  }
#' }
#' 
#' @note Abstract class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSServiceProvider <-  R6Class("OWSServiceProvider",
   private = list(
     providerName = NA,
     providerSite = NA,
     serviceContact = NA,
     
     #fetchServiceProvider
     fetchServiceProvider = function(xmlObj, owsVersion, serviceVersion){
       
       namespaces <- NULL
       if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
         namespaces <- OWSUtils$getNamespaces(xmlObj)
       }
       namespaces <- as.data.frame(namespaces)
       
       serviceXML <- NULL
       if(nrow(namespaces) > 0){
          namespaceURI <- NULL
          if(endsWith(namespaces[1L, "uri"], "ows")){
             namespaceURI <- paste(namespaces[1L, "uri"], owsVersion, sep ="/")
          }else{
             namespaceURI <- paste(namespaces[1L, "uri"])
          }
         ns <- OWSUtils$findNamespace(namespaces, uri = namespaceURI)
         if(length(ns)>0){
           serviceXML <- getNodeSet(xmlObj, "//ns:ServiceProvider", ns)
         }
         if(length(serviceXML)==0){
           ns <- OWSUtils$findNamespace(namespaces, id = "ows")
           if(length(ns)>0){
             serviceXML <- getNodeSet(xmlObj, "//ns:ServiceProvider", ns)
           }
         }
       }else{
         serviceXML <- getNodeSet(xmlObj, "//ServiceProvider")
       }
       
       providerName <- NULL
       providerSite <- NULL
       serviceContact <- NULL
       if(length(serviceXML) > 0){
         serviceXML <- serviceXML[[1]]
         children <- xmlChildren(serviceXML)
         
         if(!is.null(children$ProviderName)){
           providerName <- xmlValue(children$ProviderName)
         }
         if(!is.null(children$ProviderSite)){
           siteLink <- xmlGetAttr(children$ProviderSite, "xlink:href")
           providerSite <- ISOOnlineResource$new()
           providerSite$setLinkage(siteLink)
         }
         sc <- children$ServiceContact
         if(!is.null(sc)){
           sc.children <- xmlChildren(sc)
           individualName <- xmlValue(sc.children$IndividualName)
           positionName <- xmlValue(sc.children$PositionName)
           serviceContact <- ISOResponsibleParty$new()
           serviceContact$setIndividualName(individualName)
           serviceContact$setPositionName(positionName)
           contactInfo <- sc.children$ContactInfo
           if(!is.null(contactInfo)){
             infos <- xmlChildren(contactInfo)
             contact <- ISOContact$new()
             
             if(!is.null(infos$Phone)){
               phone <- ISOTelephone$new()
               voice <- xmlValue(xmlChildren(infos$Phone)$Voice)
               phone$setVoice(voice)
               facsimile <- xmlValue(xmlChildren(infos$Phone)$Facsimile)
               phone$setFacsimile(facsimile)
               contact$setPhone(phone)
             }
             
             if(!is.null(infos$Address)){
               address <- ISOAddress$new()
               address$setDeliveryPoint(xmlValue(xmlChildren(infos$Address)$DeliveryPoint))
               address$setCity(xmlValue(xmlChildren(infos$Address)$City))
               address$setPostalCode(xmlValue(xmlChildren(infos$Address)$PostalCode))
               address$setCountry(xmlValue(xmlChildren(infos$Address)$Country))
               address$setEmail(xmlValue(xmlChildren(infos$Address)$ElectronicMailAddress))
               contact$setAddress(address)
             }
             
             if(!is.null(infos$OnlineResource)){
               or <- ISOOnlineResource$new()
               or$setLinkage(xmlGetAttr(infos$OnlineResource, "xlink:href"))
               contact$setOnlineResource(or)
             }
             
             serviceContact$setContactInfo(contact)
           }
         }
         
       }
       
       serviceProvider <- list(
         providerName = providerName,
         providerSite = providerSite,
         serviceContact = serviceContact
       )
       
       return(serviceProvider)
     }
   ),
   public = list(
     initialize = function(xmlObj, owsVersion, serviceVersion){
       serviceProvider <- private$fetchServiceProvider(xmlObj, owsVersion, serviceVersion)
       private$providerName <- serviceProvider$providerName
       private$providerSite <- serviceProvider$providerSite
       private$serviceContact <- serviceProvider$serviceContact
     },
     
     #getProviderName
     getProviderName = function(){
       return(private$providerName)
     },
     
     #getProviderSite
     getProviderSite = function(){
       return(private$providerSite)
     },
     
     #getServiceContact
     getServiceContact = function(){
       return(private$serviceContact)
     }

   )
)