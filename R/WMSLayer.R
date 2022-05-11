#' WMSLayer
#'
#' @docType class
#' @export
#' @keywords OGC WMS Layer
#' @return Object of \code{\link{R6Class}} modelling a WMS layer
#' @format \code{\link{R6Class}} object.
#' 
#' @note Abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSLayer <- R6Class("WMSLayer",
  inherit = OGCAbstractObject,                       
  private = list(
    xmlElement = "Layer",
    xmlNamespacePrefix = "WMS",
    capabilities = NULL,
    url = NA,
    version = NA,
    
    name = NA,
    title = NA,
    abstract = NA,
    keywords = NA,
    defaultCRS = NA,
    boundingBox = NA,
    boundingBoxSRS = NA,
    boundingBoxCRS = NA,
    styles = list(),
    dimensions = list(),
    
    #fetchLayer
    fetchLayer = function(xmlObj, version){
      
      children <- xmlChildren(xmlObj)
      
      layerName <- NULL
      if(!is.null(children$Name)){
        layerName <- xmlValue(children$Name)
      }
      
      layerTitle <- NULL
      if(!is.null(children$Title)){
        layerTitle <- xmlValue(children$Title)
      }
      
      layerAbstract <- NULL
      if(!is.null(children$Abstract)){
        layerAbstract <- xmlValue(children$Abstract)
      }
      
      layerKeywords <- NULL
      if(!is.null(children$Keywords)){
        layerKeywords <- xpathSApply(xmlDoc(children$KeywordList), "//Keyword", xmlValue)
      }
      
      layerDefaultCRS <- NULL
      if(startsWith(version, "1.1")){
        if(!is.null(children$SRS)){
          layerDefaultCRS <- xmlValue(children$SRS)
        }
      }else if(version == "1.3.0"){
        if(!is.null(children$CRS)){
          layerDefaultCRS <- xmlValue(children[names(children)=="CRS"][[1]])
        }
      }
      if(!is.null(layerDefaultCRS)){
        layerDefaultCRS <- OWSUtils$toCRS(layerDefaultCRS)
      }
      
      layerSRS <- NULL
      layerCRS <- NULL
      layerBoundingBox <- NULL
      bboxXML <- children$BoundingBox
      if(!is.null(bboxXML)){
        if(startsWith(version, "1.1")){
          layerSRS <- as.character(xmlGetAttr(bboxXML, "SRS"))
        }else if(version == "1.3.0"){
          layerCRS <- as.character(xmlGetAttr(bboxXML, "CRS"))
        }
        layerBoundingBox <- OWSUtils$toBBOX(
          as.numeric(xmlGetAttr(bboxXML,"minx")),
          as.numeric(xmlGetAttr(bboxXML,"maxx")),
          as.numeric(xmlGetAttr(bboxXML,"miny")),
          as.numeric(xmlGetAttr(bboxXML,"maxy"))
        )
      }
      
      layerStyles <- list
      styleXML <- children[names(children)=="Style"]
      if(!is.null(styleXML)){
        layerStyles <- as.character(sapply(styleXML, function(x){xmlValue(xmlChildren(x)$Name)}))
      }
      
      dimensions <- list()
      dimensionXML <- children[names(children)=="Dimension"]
      if(!is.null(dimensionXML)){
        dimensions <- lapply(dimensionXML, function(dimXML){
          return(list(
            name = xmlGetAttr(dimXML, "name"),
            units = xmlGetAttr(dimXML, "units"),
            multipleValues = xmlGetAttr(dimXML, "multipleValues") == "true",
            current = xmlGetAttr(dimXML, "current") == "true",
            default = xmlGetAttr(dimXML, "default"),
            values = unlist(strsplit(gsub("\n", "", gsub(" ", "", xmlValue(dimXML))),","))
          ))
        })
        names(dimensions) <- sapply(dimensionXML, xmlGetAttr, "name")
      }
      
      layer <- list(
        name = layerName,
        title = layerTitle,
        abstract = layerAbstract,
        keywords = layerKeywords,
        defaultCRS = layerDefaultCRS,
        boundingBox = layerBoundingBox,
        boundingBoxSRS = layerSRS,
        boundingBoxCRS = layerCRS,
        styles = layerStyles,
        dimensions = dimensions
      )
      
      return(layer)
      
    }
    
  ),
  public = list(
    #'@field description description
    description = NULL,
    #'@field features features
    features = NULL,
    
    #'@description Initializes an object of class \link{WMSLayer}
    #'@param xmlObj an object of class \link{XMLInternalNode-class} to initialize from XML
    #'@param capabilities object of class \link{WMSCapabilities}
    #'@param version service version
    #'@param logger logger
    initialize = function(xmlObj, capabilities, version, logger = NULL){
      super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix, logger = logger)
      
      private$capabilities = capabilities
      private$url = capabilities$getUrl()
      private$version = version
      
      layer = private$fetchLayer(xmlObj, version)
      private$name = layer$name
      private$title = layer$title
      private$abstract = layer$abstract
      private$keywords = layer$keywords
      private$defaultCRS = layer$defaultCRS
      private$boundingBox = layer$boundingBox
      private$boundingBoxSRS = layer$boundingBoxSRS
      private$boundingBoxCRS = layer$boundingBoxCRS
      private$styles = layer$styles
      private$dimensions = layer$dimensions
      
    },
    
    #'@description Get layer name
    #'@return object of class \code{character}
    getName = function(){
      return(private$name)
    },
    
    #'@description Get layer title
    #'@return object of class \code{character}
    getTitle = function(){
      return(private$title)
    },
    
    #'@description Get layer abstract
    #'@return object of class \code{character}
    getAbstract = function(){
      return(private$abstract)
    },
    
    #'@description Get layer keywords
    #'@return object of class \code{character}
    getKeywords = function(){
      return(private$keywords)
    },
    
    #'@description Get layer default CRS
    #'@return object of class \code{character}
    getDefaultCRS = function(){
      return(private$defaultCRS)
    },
    
    #'@description Get layer bounding box
    #'@return object of class \code{matrix}
    getBoundingBox = function(){
      return(private$boundingBox)
    },
     
    #'@description Get layer bounding box SRS
    #'@return object of class \code{character}
    getBoundingBoxSRS = function(){
      return(private$boundingBoxSRS)
    },
    
    #'@description Get layer bounding box CRS
    #'@return object of class \code{character}
    getBoundingBoxCRS = function(){
      return(private$boundingBoxCRS)
    },
    
    #'@description Get layer styles
    #'@return list of objects of class \code{character}
    getStyles = function(){
      return(private$styles)
    },
    
    #'@description Get layer dimensions
    #'@param time_format time format. Default is \code{character}
    #'@return a \code{list} including default value and listed possible values
    getDimensions = function(time_format = "character"){
      dimensions <- private$dimensions
      if(time_format=="posix"){
        dimensions[["time"]]$default<-as.POSIXct(dimensions[["time"]]$default,format="%Y-%m-%dT%H:%M:%OSZ")
        dimensions[["time"]]$values<-as.POSIXct(dimensions[["time"]]$values,format="%Y-%m-%dT%H:%M:%OSZ")
      }
      return(dimensions)
    },
    
    #'@description Get layer TIME dimensions
    #'@param time_format time format. Default is \code{character}
    #'@return a \code{list} including default value and listed possible values
    getTimeDimension = function(time_format = "character"){
      time_dimensions <- private$dimensions[["time"]]
      if(time_format=="posix"){
        time_dimensions$default<-as.POSIXct(time_dimensions$default,format="%Y-%m-%dT%H:%M:%OSZ")
        time_dimensions$values<-as.POSIXct(time_dimensions$values,format="%Y-%m-%dT%H:%M:%OSZ")
      }
      return(time_dimensions)
    },
    
    #'@description Get layer ELEVATION dimensions
    #'@return a \code{list} including default value and listed possible values
    getElevationDimension = function(){
      return(private$dimensions[["elevation"]])
    },
    
    #'@description Get feature info
    #'@param srs srs
    #'@param styles styles
    #'@param feature_count feature count. Default is 1
    #'@param x x
    #'@param y y
    #'@param width width
    #'@param height height
    #'@param bbox bbox
    #'@param info_format info format. Default is "text/xml"
    #'@param ... any other parameter to pass to a \link{WMSGetFeatureInfo} request
    #'@return an object of class \code{sf} given the feature(s)
    getFeatureInfo = function(srs = NULL, styles = NULL, feature_count = 1,
                              x, y, width, height, bbox, 
                              info_format = "text/xml",
                              ...){
      
      if(is.null(styles)){
        styles <- self$getStyle()
      }
      
      if(is.null(srs)){
        srs <- if(startsWith(private$version, "1.1")){
          self$getBoundingBoxSRS()
        }else if(startsWith(private$version, "1.3")){
          self$getBoundingBoxCRS()
        }
      }
      
      client = private$capabilities$getClient()
      ftFeatures <- WMSGetFeatureInfo$new(
        private$capabilities,
        op = op, url = private$url, version = private$version, 
        layers = private$name, srs = srs, styles = styles,
        feature_count = feature_count,
        x = x, y = y, width = width, height = height, bbox = bbox,
        info_format = info_format,
        user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), 
        headers = client$getHeaders(), config = client$getConfig(),
        logger = self$loggerType, ...)
      obj <- ftFeatures$getResponse()
      
      #write the file to disk
      destext <- switch(info_format,
        "application/vnd.ogc.gml" = "gml",
        "application/vnd.ogc.gml/3.1.1" = "gml",
        "application/json" = "json",
        "text/xml" = "xml",
        "gml"                  
      )
      tempf = tempfile() 
      destfile = paste0(tempf,".", destext)
      if(destext == "gml"){
        saveXML(obj, destfile)
      }else if(destext == "json"){
        write(obj, destfile)
      }else if(destext == "xml"){
        saveXML(obj, destfile)
      }
      
      ftFeatures <- NULL
      if(destext == "xml"){
        xml<- xmlParse(file = destfile)
        rootname <- xmlName(xmlChildren(xml)[[1]])
        if(rootname == "FeatureInfoResponse"){
          xml_list <- xmlToList(xml)
          if("FIELDS" %in% names(xml_list)){
            variables = lapply(xml_list[["FIELDS"]], function(x){
              outvar <- x
              name <- names(x)
              attr(outvar, "description") <- name
              return(outvar)
            })
            ftFeatures<-data.frame(variables)
          }else{
            #THREDDS STRUCTURE
            ftFeatures<-data.frame(xml_list,stringsAsFactors=FALSE)
            names(ftFeatures)<-gsub("^.*\\.","",names(ftFeatures))
            ftFeatures<-sf::st_as_sf(ftFeatures,coords= c("longitude","latitude"))
          }
        }else{
          ftFeatures <- sf::st_read(destfile, quiet = TRUE)
        }
      }else{
        ftFeatures <- sf::st_read(destfile, quiet = TRUE)
      }
      
      if(is.null(st_crs(ftFeatures))){
        st_crs(ftFeatures) <- self$getDefaultCRS()
      }
      return(ftFeatures)
    }
  )
)