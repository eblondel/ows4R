#' WFSFeatureType
#'
#' @docType class
#' @export
#' @keywords OGC WFS FeatureType
#' @return Object of \code{\link{R6Class}} modelling a WFS feature type
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, capabilities, version, logger)}}{
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
#'  \item{\code{getDescription(pretty)}}{
#'    Get feature type description. If \code{pretty} is TRUE,
#'    the output will be an object of class \code{data.frame}
#'  }
#'  \item{\code{getFeatures()}}{
#'    Get features.
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSFeatureType <- R6Class("WFSFeatureType",
  inherit = OGCAbstractObject,                       
  private = list(
    gmlIdAttributeName = "gml_id",
    
    capabilities = NULL,
    url = NA,
    version = NA,
    
    name = NA,
    title = NA,
    abstract = NA,
    keywords = NA,
    defaultCRS = NA,
    WGS84BoundingBox = NA,
    
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
      if(!is.null(ftDefaultCRS)) ftDefaultCRS <- OWSUtils$toCRS(ftDefaultCRS)
      
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
    getDescription = function(pretty = FALSE){
      op <- NULL
      operations <- private$capabilities$getOperationsMetadata()$getOperations()
      if(length(operations)>0){
        op <- operations[sapply(operations,function(x){x$getName()=="DescribeFeatureType"})]
        if(length(op)>0){
          op <- op[[1]]
        }else{
          stop("Operation 'DescribeFeatureType' not supported by this service")
        }
      }
      client = private$capabilities$getClient()
      ftDescription <- WFSDescribeFeatureType$new(op = op, private$url, private$version, private$name, 
                                                  user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), headers = client$getHeaders(),
                                                  logger = self$loggerType)
      xmlObj <- ftDescription$getResponse()
      namespaces <- OWSUtils$getNamespaces(xmlObj)
      xsdNs <- OWSUtils$findNamespace(namespaces, "XMLSchema")
      elementXML <- getNodeSet(xmlObj, "//ns:sequence/ns:element", xsdNs)
      elements <- lapply(elementXML, WFSFeatureTypeElement$new)
      self$description <- elements
      out <- self$description
      if(pretty){
        out <- do.call("rbind", lapply(elements, function(element){
          out_element <- data.frame(
            name = element$getName(),
            type = element$getType(),
            minOccurs = ifelse(!is.null(element$getMinOccurs()), element$getMinOccurs(), NA),
            maxOccurs = ifelse(!is.null(element$getMaxOccurs()), element$getMaxOccurs(), NA),
            nillable = ifelse(!is.null(element$isNillable()), element$isNillable(), NA),
            stringsAsFactors = FALSE
          )
          return(out_element)
        }))
      }
      return(out)
    },
    
    #getFeatures
    getFeatures = function(..., 
                           outputFormat = NULL,
                           paging = FALSE, paging_length = 1000,
                           parallel = FALSE, parallel_handler = NULL, cl = NULL){
      
      #getdescription
      if(is.null(self$description)){
        self$description = self$getDescription()
      }
      
      vendorParams <- list(...)
      
      if(paging){
        hitParams <- vendorParams
        hitParams$resulttype <- "hits"
        hits <- do.call(self$getFeatures, hitParams)
        numberMatched <- as.integer(hits$numberMatched)
        startIndexes <- seq(from = 0, to = numberMatched, by = paging_length)
        getFeaturesPaging <- function(startIndex, self){
          pageParams <- vendorParams
          pageParams$startIndex <- startIndex
          pageParams$sortBy <- self$description[sapply(self$description, function(x){x$getType()!="geometry"})][[1]]$getName()
          pageParams$count <- paging_length
          pageParams$outputFormat <- outputFormat
          do.call(self$getFeatures, pageParams)
        }
        out <- NULL
        if(parallel){
          if(is.null(parallel_handler)){
            errMsg = "No 'parallel_handler' defined to get features in parallel"
            self$ERROR(errMsg)
            stop(errMsg)
          }
          if(!is.null(cl)){
            out <- do.call("rbind", parallel_handler(cl, startIndexes, getFeaturesPaging, self))
          }else{
            out <- do.call("rbind", parallel_handler(startIndexes, getFeaturesPaging, self))
          }
        }else{
          out <- do.call("rbind", lapply(startIndexes, getFeaturesPaging, self))
        }
        return(out)
      }
      
      op <- NULL
      operations <- private$capabilities$getOperationsMetadata()$getOperations()
      if(length(operations)>0){
        op <- operations[sapply(operations,function(x){x$getName()=="GetFeature"})]
        if(length(op)>0){
          op <- op[[1]]
        }else{
          stop("Operation 'GetFeature' not supported by this service")
        }
      }
      client = private$capabilities$getClient()
      ftFeatures <- WFSGetFeature$new(op = op, private$url, private$version, private$name, outputFormat = outputFormat, 
                                      user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), headers = client$getHeaders(),
                                      logger = self$loggerType, ...)
      obj <- ftFeatures$getResponse()
      
      if(length(vendorParams)>0){
        names(vendorParams) <- tolower(names(vendorParams))
        if("resulttype" %in% names(vendorParams)){
          resultType = vendorParams[["resulttype"]]
          if(resultType == "hits"){
            hits <- xmlAttrs(xmlRoot(obj))
            hits <- as.list(hits)
            hits <- hits[sapply(names(hits), function(x){x %in% c("numberOfFeatures", "numberMatched", "numberReturned", "timeStamp")})]
            return(hits)
          }
        }
      }
      
      #write the file to disk
      tempf = tempfile()
      if(is.null(outputFormat)){
        destfile = paste0(tempf,".gml")
        saveXML(obj, destfile)
      }else{
        switch(tolower(outputFormat),
          "gml2" = {
            destfile = paste0(tempf,".gml")
            saveXML(obj, destfile)
          },
          "gml3" = {
            destfile = paste0(tempf,".gml")
            saveXML(obj, destfile)
          },
          "application/json" = {
            destfile = paste0(tempf,".json")
            write(obj, destfile)
          },
          "json" = {
            destfile = paste0(tempf,".json")
            write(obj, destfile)
          },
          "csv" = {
            destfile = paste0(tempf,".csv")
            write(obj, destfile)
          }
        )
      }
      
      #read features
      ftFeatures <- sf::st_read(destfile, quiet = TRUE)
      if(is.null(st_crs(ftFeatures))){
        st_crs(ftFeatures) <- self$getDefaultCRS()
      }
      
      #validating attributes vs. schema
      for(element in self$description){
        attrType <- element$getType()
        if(!is.null(attrType) && attrType != "geometry"){
          attrName = element$getName()
          if(!is.null(ftFeatures[[attrName]])){
            ftFeatures[[attrName]] <- switch(attrType,
              "Date" = as.Date(ftFeatures[[attrName]]),
              "POSIXct" = as.POSIXct(ftFeatures[[attrName]]),
              as(ftFeatures[[attrName]], attrType)
            )
          }
        }
      }
      self$features <- ftFeatures
      return(self$features)
    }
  )
)