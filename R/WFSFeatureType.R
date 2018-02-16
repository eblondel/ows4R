#' WFSFeatureType
#'
#' @docType class
#' @export
#' @keywords OGC WFS FeatureType
#' @return Object of \code{\link{R6Class}} modelling a WFS feature type
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, url, version)}}{
#'    This method is used to instantiate a \code{WFSFeatureType} object
#'  }
#'  \item{\code{getName()}}{
#'    Get feature type name
#'  }
#'  \item{\code{getTitle()}}{
#'    Get feature type title
#'  }
#'  \item{\code{getAbstract()}}{
#'    Get feature type abstract
#'  }
#'  \item{\code{getKeywords()}}{
#'    Get feature type keywords
#'  }
#'  \item{\code{getDefaultCRS()}}{
#'    Get feature type default CRS
#'  }
#'  \item{\code{getBoundingBox()}}{
#'    Get feature type bounding box
#'  }
#'  \item{\code{getDescription()}}{
#'    Get feature type description
#'  }
#'  \item{\code{getFeatures()}}{
#'    Get features
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSFeatureType <- R6Class("WFSFeatureType",
                          
  private = list(
    gmlIdAttributeName = "gml_id",
    
    url = NA,
    version = NA,
    
    name = NA,
    title = NA,
    abstract = NA,
    keywords = NA,
    defaultCRS = NA,
    WGS84BoundingBox = NA,
    
    description = NA,
    features = NULL,
    
    #fetchFeatureType
    fetchFeatureType = function(xmlObj, version){
      
      children <- xmlChildren(xmlObj)
      
      ftName <- NULL
      if(!is.null(children$Name)){
        ftName <- xmlValue(children$Name)
      }
      
      ftTitle <- NULL
      if(!is.null(children$Title)){
        ftTitle <- xmlValue(children$Title)
      }
      
      ftAbstract <- NULL
      if(!is.null(children$Abstract)){
        ftAbstract <- xmlValue(children$Abstract)
      }
      
      ftKeywords <- NULL
      if(!is.null(children$Keywords)){
        if(version == "1.0.0"){
          ftKeywords <- strsplit(gsub(" ", "", xmlValue(children$Keywords)), ",")[[1]]
        }else{
          ftKeywordListXML <- xmlChildren(children$Keywords)
          ftKeywords <- as.vector(sapply(ftKeywordListXML, xmlValue))
        }
      }
      
      ftDefaultCRS <- NULL
      if(version == "1.0.0"){
        if(!is.null(children$SRS)){
          ftDefaultCRS <- xmlValue(children$SRS)
        }
      }else if(version == "1.1.0"){
        if(!is.null(children$DefaultSRS)){
          ftDefaultCRS <- xmlValue(children$DefaultSRS)
        }
      }else {
        if(!is.null(children$DefaultCRS)){
          ftDefaultCRS <- xmlValue(children$DefaultCRS)
        }
      }
      ftDefaultCRS <- OWSUtils$toCRS(ftDefaultCRS)
      
      ftBoundingBox <- NULL
      if(version == "1.0.0"){
        bboxXML <- children$LatLongBoundingBox
        if(!is.null(bboxXML)){
          ftBoundingBox <- OWSUtils$toBBOX(
            as.numeric(xmlGetAttr(bboxXML,"minx")),
            as.numeric(xmlGetAttr(bboxXML,"maxx")),
            as.numeric(xmlGetAttr(bboxXML,"miny")),
            as.numeric(xmlGetAttr(bboxXML,"maxy"))
          )
          
        }
      }else{
        bboxXML <- children$WGS84BoundingBox
        if(!is.null(bboxXML)){
          corners <- xmlChildren(bboxXML)
          lc <- as.numeric(unlist(strsplit(xmlValue(corners$LowerCorner)," ")))
          uc <- as.numeric(unlist(strsplit(xmlValue(corners$UpperCorner)," ")))
          ftBoundingBox <- OWSUtils$toBBOX(lc[1], uc[1], lc[2], uc[2])
        }
      }
      
      featureType <- list(
        name = ftName,
        title = ftTitle,
        abstract = ftAbstract,
        keywords = ftKeywords,
        defaultCRS = ftDefaultCRS,
        WGS84BoundingBox = ftBoundingBox
      )
      
      return(featureType)
      
    },
    
    #fetchDescription
    fetchDescription = function(){
      ftDescription <- WFSDescribeFeatureType$new(private$url, private$version, private$name)
      return(ftDescription);
    },
    
    #fetchFeatures
    fetchFeatures = function(){
      
      description <- self$getDescription()
      ftFeatures <- WFSGetFeature$new(private$url, private$version, private$name)
      xmlObj <- ftFeatures$getRequest()$response
      
      #write the file to disk
      tempf = tempfile() 
      destfile = paste(tempf,".gml",sep='')
      saveXML(xmlObj, destfile)
      
      #hasGeometry?
      hasGeometry = FALSE
      for(element in description$getContent()){
        if(element$getType() == "geometry"){
          hasGeometry = TRUE
          break
        }
      }
      
      #ftFeatures
      if(hasGeometry){
        ftFeatures <- sf::st_read(destfile, quiet = TRUE)
        st_crs(ftFeatures) <- self$getDefaultCRS()
      }else{
        if(private$version == "1.0.0"){
          membersContent <- sapply(getNodeSet(xmlObj, "//gml:featureMember"), function(x) xmlChildren(x))
          fid <- sapply(membersContent, function(x) xmlAttrs(x))
          membersAttributes <- xmlToDataFrame(
            nodes = getNodeSet(xmlObj, "//gml:featureMember/*[@*]"),
            stringsAsFactors = FALSE
          )
          
        }else if(private$version == "1.1.0"){
          membersContent <- xmlChildren(getNodeSet(xmlObj, "//gml:featureMembers")[[1]])
          fid <- sapply(membersContent, function(x) xmlAttrs(x))
          membersAttributes <- xmlToDataFrame(
            nodes = getNodeSet(xmlObj, "//gml:featureMembers/*[@*]"),
            stringsAsFactors = FALSE
          )
          
        }else if(private$version == "2.0.0"){
          membersContent <- sapply(getNodeSet(xmlObj, "//wfs:member"), function(x) xmlChildren(x))
          fid <- sapply(membersContent, function(x) xmlAttrs(x))
          membersAttributes <- xmlToDataFrame(
            nodes = getNodeSet(xmlObj, "//wfs:member/*[@*]"),
            stringsAsFactors = FALSE
          )
        }
        
        ftFeatures <- cbind(fid, membersAttributes, stringsAsFactors = FALSE)
      }
      
      #validating attributes vs. schema
      for(element in description$getContent()){
        attrType <- element$getType()
        if(!is.null(attrType) && attrType != "geometry"){
          attrName = element$getName()
          ftFeatures[[attrName]] <- as(ftFeatures[[attrName]],attrType)
        }
      }
      return(ftFeatures);
    }
    
  ),
  public = list(
    
    initialize = function(xmlObj, url, version){
      
      private$url = url
      private$version = version
      
      featureType = private$fetchFeatureType(xmlObj, version)
      private$name = featureType$name
      private$title = featureType$title
      private$abstract = featureType$abstract
      private$keywords = featureType$keywords
      private$defaultCRS = featureType$defaultCRS
      private$WGS84BoundingBox = featureType$WGS84BoundingBox
      
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
      return(private$WGS84BoundingBox)
    },
    
    #getDescription
    getDescription = function(){
      if(typeof(private$description) != "environment"){
        message("Fetching FeatureType description...")
        private$description <- private$fetchDescription()
      }
      return(private$description)
    },
    
    #getFeatures
    getFeatures = function(){
      if(is.null(private$features)){
        message("Fetching FeatureType data...")
        private$features <- private$fetchFeatures()
      }
      return(private$features)
    }
    
  )
)