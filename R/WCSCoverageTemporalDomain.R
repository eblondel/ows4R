#' WCSCoverageTemporalDomain
#'
#' @docType class
#' @export
#' @keywords OGC WCS Coverage temporal domain
#' @return Object of \code{\link{R6Class}} modelling a WCS coverage temporal domain
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSCoverageTemporalDomain <- R6Class("WCSCoverageTemporalDomain",
  inherit = OGCAbstractObject,                       
  private = list(
    
    #fetchTemporalDomain
    fetchTemporalDomain = function(xmlObj, serviceVersion, owsVersion){
      namespaces <- OWSUtils$getNamespaces(xmlDoc(xmlObj))
      namespaces <- as.data.frame(namespaces)
      namespaceURI <- paste("http://www.opengis.net/ows", owsVersion, sep ="/")
      ns <- OWSUtils$findNamespace(namespaces, uri = namespaceURI)
      if(is.null(ns)) ns <- OWSUtils$findNamespace(namespaces, id = "ows")
      
      wcsNamespaceURI <- paste("http://www.opengis.net/wcs", serviceVersion, sep ="/")
      wcsNs <- OWSUtils$findNamespace(namespaces, uri = wcsNamespaceURI)
      if(is.null(wcsNs)) wcsNs <- OWSUtils$findNamespace(namespaces, id = "wcs")
      
      #objects
      instants <- NULL
      periods <- NULL
      
      #WCS 1.0
      if(startsWith(serviceVersion, "1.0")){
        gmlNs <- OWSUtils$findNamespace(namespaces, id = "gml")
        timeposXML <- getNodeSet(xmlObj, "//ns:timePosition", gmlNs)
        instants <- sapply(timeposXML, xmlValue)
        periodXML <- getNodeSet(xmlObj, "//ns:timePeriod", gmlNs)
        periods <- lapply(periodXML, function(x){
          GMLTimePeriod$new(xml = x)
        })
      }
      
      #WCS 1.1
      if(startsWith(serviceVersion, "1.1")){
        gmlNs <- OWSUtils$findNamespace(namespaces, id = "gml")
        timeposXML <- getNodeSet(xmlObj, "//ns:timePosition", gmlNs)
        instants <- sapply(timeposXML, xmlValue)
        periodXML <- getNodeSet(xmlObj, "//ns:timePeriod", gmlNs)
        periods <- lapply(periodXML, function(x){
          GMLTimePeriod$new(xml = x)
        })
      }
      
      temporalDomain <- list(
        instants = instants,
        periods = periods
      )
      return(temporalDomain)
    }
    
  ),
  public = list(
    #'@field instants instants
    instants = list(),
    #'@field periods periods
    periods = list(),
    
    #'@description Initializes an object of class \link{WCSCoverageTemporalDomain}
    #'@param xmlObj an object of class \link{XMLInternalNode-class} to initialize from XML
    #'@param serviceVersion service version
    #'@param owsVersion OWS version
    #'@param logger logger
    initialize = function(xmlObj, serviceVersion, owsVersion, logger = NULL){
      super$initialize(logger = logger)
      temporalDomain = private$fetchTemporalDomain(xmlObj, serviceVersion, owsVersion)
      self$instants <- temporalDomain$instants
      self$periods <- temporalDomain$periods
    },
    
    #'@description Get time instants
    #'@return a list of objects of class \code{POSIXct}
    getInstants = function(){
      return(self$instants)
    },
    
    #'@description Get time periods
    #'@return a list of objects of class \link{GMLTimePeriod}
    getPeriods = function(){
      return(self$periods)
    }
  )
)