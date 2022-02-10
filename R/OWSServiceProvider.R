#' OWSServiceProvider
#'
#' @docType class
#' @export
#' @keywords OGC OWS Service Provider
#' @return Object of \code{\link{R6Class}} for modelling an OGC Service Provider
#' @format \code{\link{R6Class}} object.
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
          if(any(sapply(namespaces$uri, endsWith, "ows"))){
             namespaceURI <- paste(namespaces[which(sapply(namespaces$uri, endsWith, "ows")), "uri"], owsVersion, sep ="/")
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
      
     #'@description Initializes an object of class \link{OWSServiceProvider}
     #'@param xmlObj object of class \link{XMLInternalNode-class} from \pkg{XML}
     #'@param owsVersion OWS version
     #'@param serviceVersion service version
     initialize = function(xmlObj, owsVersion, serviceVersion){
       serviceProvider <- private$fetchServiceProvider(xmlObj, owsVersion, serviceVersion)
       private$providerName <- serviceProvider$providerName
       private$providerSite <- serviceProvider$providerSite
       private$serviceContact <- serviceProvider$serviceContact
     },
     
     #'@description Get provider name
     #'@param the provider name, object of class \code{character}
     getProviderName = function(){
       return(private$providerName)
     },
     
     #'@description Get provider site
     #'@param the provider site, object of class \code{character}
     getProviderSite = function(){
       return(private$providerSite)
     },
     
     #'@description Get provider contact
     #'@param the provider contact, object of class \link{ISOResponsibleParty} from \pkg{geometa}
     getServiceContact = function(){
       return(private$serviceContact)
     }

   )
)