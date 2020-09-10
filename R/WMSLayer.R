#' WMSLayer
#'
#' @docType class
#' @export
#' @keywords OGC WMS Layer
#' @return Object of \code{\link{R6Class}} modelling a WMS layer
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, capabilities, version, logger)}}{
#'    This method is used to instantiate a \code{WMSLayer} object
#'  }
#'  \item{\code{getName()}}{
#'    Get layer name
#'  }
#'  \item{\code{getTitle()}}{
#'    Get layer title
#'  }
#'  \item{\code{getAbstract()}}{
#'    Get layer abstract
#'  }
#'  \item{\code{getKeywords()}}{
#'    Get layer keywords
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WMSLayer <- R6Class("WMSLayer",
  inherit = OGCAbstractObject,                       
  private = list(
    
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
    style = NA,
    
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
      
      layerStyle <- NULL
      styleXML <- children$Style
      if(!is.null(styleXML)){
        layerStyle <- xmlValue(xmlChildren(styleXML)$Name)
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
        style = layerStyle
      )
      
      return(layer)
      
    }
    
  ),
  public = list(
    description = NULL,
    features = NULL,
    initialize = function(xmlObj, capabilities, version, logger = NULL){
      super$initialize(logger = logger)
      
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
      private$style = layer$style
      
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
    
    #getDefaultCRS
    getDefaultCRS = function(){
      return(private$defaultCRS)
    },
    
    #getBoundingBox
    getBoundingBox = function(){
      return(private$boundingBox)
    },
    
    #getBoundingBoxSRS
    getBoundingBoxSRS = function(){
      return(private$boundingBoxSRS)
    },
    
    #getBoundingBoxCRS
    getBoundingBoxCRS = function(){
      return(private$boundingBoxCRS)
    },
    
    #getStyle
    getStyle = function(){
      return(private$style)
    },
    
    #getFeatureInfo
    getFeatureInfo = function(srs = NULL, crs = NULL, styles = NULL, feature_count = 1,
                              x, y, width, height, bbox, 
                              info_format = "application/vnd.ogc.gml",
                              ...){
      
      if(is.null(styles)){
        styles <- self$getStyle()
      }
      
      if(is.null(srs)){
        srs <- self$getBoundingBoxSRS()
      }
      if(is.null(crs)){
        crs <- self$getBoundingBoxCRS()
      }
      
      ftFeatures <- WMSGetFeatureInfo$new(
        op = op, url = private$url, version = private$version, 
        layers = private$name, srs = srs, crs = crs, styles = styles,
        feature_count = feature_count,
        x = x, y = y, width = width, height = height, bbox = bbox,
        info_format = info_format,
        logger = self$loggerType, ...)
      obj <- ftFeatures$getResponse()
      
      #write the file to disk
      destext <- switch(info_format,
        "application/vnd.ogc.gml" = "gml",
        "application/vnd.ogc.gml/3.1.1" = "gml",
        "application/json" = "json",
        "gml"                  
      )
      tempf = tempfile() 
      destfile = paste0(tempf,".", destext)
      if(destext == "gml"){
        saveXML(obj, destfile)
      }else if(destext == "json"){
        write(obj, destfile)
      }
      
      ftFeatures <- sf::st_read(destfile, quiet = TRUE)
      if(is.null(st_crs(ftFeatures))){
        st_crs(ftFeatures) <- self$getDefaultCRS()
      }
      return(ftFeatures)
    }
  )
)