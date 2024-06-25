#' WCSCoverageSpatialDomain
#'
#' @docType class
#' @export
#' @keywords OGC WCS Coverage spatial domain
#' @return Object of \code{\link[R6]{R6Class}} modelling a WCS coverage spatial domain
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSCoverageSpatialDomain <- R6Class("WCSCoverageSpatialDomain",
  inherit = OGCAbstractObject,                       
  private = list(
    
    #fetchSpatialDomain
    fetchSpatialDomain = function(xmlObj, serviceVersion, owsVersion){
      namespaces <- OWSUtils$getNamespaces(xmlDoc(xmlObj))
      namespaces <- as.data.frame(namespaces)
      namespaceURI <- paste("http://www.opengis.net/ows", owsVersion, sep ="/")
      ns <- OWSUtils$findNamespace(namespaces, uri = namespaceURI)
      if(is.null(ns)) ns <- OWSUtils$findNamespace(namespaces, id = "ows")
      
      wcsNamespaceURI <- paste("http://www.opengis.net/wcs", serviceVersion, sep ="/")
      wcsNs <- OWSUtils$findNamespace(namespaces, uri = wcsNamespaceURI)
      if(is.null(wcsNs)) wcsNs <- OWSUtils$findNamespace(namespaces, id = "wcs")
      
      #objects
      envs <- NULL
      grids <-  NULL
      bboxes <- NULL
      gridcrs <- NULL
      
      #WCS 1.0
      if(startsWith(serviceVersion, "1.0")){
        gmlNs <- OWSUtils$findNamespace(namespaces, id = "gml")
        
        envsXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Envelope", gmlNs)
        envs <- lapply(envsXML, function(x){ return(GMLEnvelope$new(xml = x) )})
        if(length(envs)==0){
          env_children <- xmlChildren(xmlObj)
          env_children <- env_children[names(env_children)=="Envelope"]
          envs <- lapply(env_children, function(x){ return(GMLEnvelope$new(xml = x)) })
        }
        envs_with_timeXML <- getNodeSet(xmlDoc(xmlObj), "//ns:EnvelopeWithTimePeriod", gmlNs)
        envs_with_time <- lapply(envs_with_timeXML, function(x){ return(GMLEnvelopeWithTimePeriod$new(xml = x)) })
        if(length(envs_with_time)==0){
          env_children <- xmlChildren(xmlObj)
          env_children <- env_children[names(env_children)=="EnvelopeWithTimePeriod"]
          envs_with_time <- lapply(env_children, function(x){ return(GMLEnvelopeWithTimePeriod$new(xml = x)) })
        }
        envs <- c(envs, envs_with_time)
        
        gridsXML <- getNodeSet(xmlDoc(xmlObj), "//ns:Grid", gmlNs)
        grids <- lapply(gridsXML, function(x){
          return(GMLGrid$new(xml = x))
        })
        recgridsXML <- getNodeSet(xmlDoc(xmlObj), "//ns:RectifiedGrid", gmlNs)
        recgrids <- lapply(recgridsXML, function(x){
          return(GMLRectifiedGrid$new(xml = x))
        })
        grids <- c(grids, recgrids)
      }
        
      #WCS 1.1
      if(startsWith(serviceVersion, "1.1")){
        bboxXML <- getNodeSet(xmlDoc(xmlObj), "//ns:BoundingBox", ns)
        bboxes <- lapply(bboxXML, function(x){
          return(OWSBoundingBox$new(xml = x, owsVersion = owsVersion, serviceVersion = serviceVersion))
        })
        gridcrs <- NULL
        gridcrsXML <- getNodeSet(xmlDoc(xmlObj), "//ns:GridCRS", wcsNs)
        if(length(gridcrsXML)>0){
          gridcrs <- WCSGridCRS$new(gridcrsXML[[1]], serviceVersion, owsVersion)
        }
      }
      
      spatialDomain <- list(
        envelopes = envs,
        BoundingBox = bboxes,
        grids = grids,
        GridCRS = gridcrs
      )
      return(spatialDomain)
    }
    
  ),
  public = list(
    #'@field envelopes envelopes. For WCS 1.0
    envelopes = list(),
    #'@field BoundingBox bounding box. For WCS 1.1
    BoundingBox = list(),
    #'@field grids For WCS 1.0
    grids = list(),
    #'@field GridCRS grid CRS. For WCS 1.1
    GridCRS = list(),
    
    #'@description Initializes an object of class \link{WCSCoverageDomain}
    #'@param xmlObj an object of class \link[XML]{XMLInternalNode-class} to initialize from XML
    #'@param serviceVersion service version
    #'@param owsVersion OWS version
    #'@param logger logger
    initialize = function(xmlObj, serviceVersion, owsVersion, logger = NULL){
      super$initialize(logger = logger)
      spatialDomain = private$fetchSpatialDomain(xmlObj, serviceVersion, owsVersion)
      #WCS 1.0
      self$envelopes <- spatialDomain$envelopes
      self$grids <- spatialDomain$grids
      #WCS 1.1
      self$BoundingBox <- spatialDomain$BoundingBox
      self$GridCRS <- spatialDomain$GridCRS
    },
    
    #'@description Get envelopes. Method that applies to WCS 1.0 only
    #'@return a list of objects of class \link[geometa]{GMLEnvelope} or \link[geometa]{GMLEnvelopeWithTimePeriod}
    getEnvelopes = function(){
      return(self$envelopes)
    },
    
    #'@description Get bounding boxes. Method that applies to WCS 1.1 only
    #'@return a list of objects of class \link{OWSBoundingBox}
    getBoundingBox = function(){
      return(self$BoundingBox)
    },
    
    #'@description Get grids. Method that applies to WCS 1.0 only
    #'@return a list of of objects of class \link[geometa]{GMLGrid} or \link[geometa]{GMLRectifiedGrid}
    getGrids = function(){
      return(self$grids)
    },
    
    #'@description Get Grid CRS. Method that applies to WCS 1.1 only
    #'@return a list of objects of class \link{WCSGridCRS}
    getGridCRS = function(){
      return(self$GridCRS)
    }
  )
)