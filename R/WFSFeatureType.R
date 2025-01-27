#' WFSFeatureType
#'
#' @docType class
#' @export
#' @keywords OGC WFS FeatureType
#' @return Object of \code{\link[R6]{R6Class}} modelling a WFS feature type
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a WFS DescribeFeatureType request
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
    features = NULL,
    
    supportedGeomPossibleNames = c("the_geom", "geom", "wkt", "geom_wkt", "wkb", "geom_wkb"),
    supportedXPossibleNames = c("x","lon","long","longitude","decimalLongitude"),
    supportedYPossibleNames = c("y","lat","lati","latitude","decimalLatitude"),
    
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
    #'@field description description
    description = list(),
    
    #'@description Initializes an object of class \link{WFSFeatureType}
    #'@param xmlObj an object of class \link[XML]{XMLInternalNode-class} to initialize from XML
    #'@param capabilities object of class \link{WFSCapabilities}
    #'@param version service version
    #'@param logger logger
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
    
    #'@description Get feature type name
    #'@param object of class \code{character}
    getName = function(){
      return(private$name)
    },
    
    #'@description Get feature type title
    #'@param object of class \code{character}
    getTitle = function(){
      return(private$title)
    },
    
    #'@description Get feature type abstract
    #'@param object of class \code{character}
    getAbstract = function(){
      return(private$abstract)
    },
    
    #'@description Get feature type keywords
    #'@param object of class \code{character}
    getKeywords = function(){
      return(private$keywords)
    },
    
    #'@description Get feature type default CRS
    #'@param object of class \code{character}
    getDefaultCRS = function(){
      return(private$defaultCRS)
    },
    
    #'@description Get feature type bounding box
    #'@param object of class \code{matrix}
    getBoundingBox = function(){
      return(private$WGS84BoundingBox)
    },
    
    #'@description Describes a feature type
    #'@param pretty pretty whether to return a prettified \code{data.frame}. Default is \code{FALSE}
    #'@return a \code{list} of \link{WFSFeatureTypeElement} or \code{data.frame}
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
      ftDescription <- WFSDescribeFeatureType$new(private$capabilities, op = op, private$url, private$version, private$name, 
                                                  user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), headers = client$getHeaders(), 
                                                  config = self$getConfig(),
                                                  logger = self$loggerType)
      #exception handling
      if(ftDescription$hasException()){
        return(ftDescription$getException())
      }

      #response handling
      xmlObj <- ftDescription$getResponse()
      namespaces <- OWSUtils$getNamespaces(xmlObj)
      xsdNs <- OWSUtils$findNamespace(namespaces, "XMLSchema")
      elementXML <- getNodeSet(xmlObj, "//ns:sequence/ns:element", xsdNs)
      elements <- lapply(elementXML, WFSFeatureTypeElement$new, namespaces)
      self$description <- elements
      out <- self$description
      if(pretty){
        out <- do.call("rbind", lapply(elements, function(element){
          out_element <- data.frame(
            name = ifelse(!is.null(element$getName()), element$getName(), NA),
            type = ifelse(!is.null(element$getType()), element$getType(), NA),
            minOccurs = ifelse(!is.null(element$getMinOccurs()), element$getMinOccurs(), NA),
            maxOccurs = ifelse(!is.null(element$getMaxOccurs()), element$getMaxOccurs(), NA),
            nillable = ifelse(!is.null(element$isNillable()), element$isNillable(), NA),
            geometry = element$isGeometry(),
            stringsAsFactors = FALSE
          )
          return(out_element)
        }))
      }
      return(out)
    },
    
    #'@description Indicates with feature type has a geometry
    #'@return object of class \link{logical}
    hasGeometry = function(){
      if(length(self$description)==0) self$description = self$getDescription()
      any(sapply(self$description, function(x){x$isGeometry()}))
    },
    
    #'@description Get geometry type
    #'@return object of class \link{character} representing the geometry tpe
    getGeometryType = function(){
      if(length(self$description)==0) self$description = self$getDescription()
      geomType <- NULL
      if(self$hasGeometry()){
        geomType <- self$description[sapply(self$description, function(x){x$isGeometry()})][[1]]$getType() 
      }
      return(geomType)
    },
    
    #'@description Inherits features CRS
    #'@param obj features object
    #'@return object of class \link{integer}
    getFeaturesCRS = function(obj){
      crs <- NA
      if(is(obj, "XMLInternalDocument")){
        geomType <- self$getGeometryType()
        if(!is.null(geomType)){
          geoms <- XML::getNodeSet(obj, paste0("//gml:", geomType))
          if(length(geoms)>0){
            srsName <- XML::xmlGetAttr(geoms[[1]], "srsName")
            if(startsWith(srsName, "EPSG")){
              crs <- as(unlist(strsplit(srsName, "EPSG:"))[2], "integer")
            }else if(startsWith(srsName, "http://www.opengis.net/gml/srs/epsg.xml#")){
              crs <- as(unlist(strsplit(srsName,"http://www.opengis.net/gml/srs/epsg.xml#"))[2],"integer")
            }else if(startsWith(srsName, "urn:x-ogc:def:crs:EPSG:")){
              crs <- as(unlist(strsplit(srsName,"urn:x-ogc:def:crs:EPSG:"))[2],"integer")
            }else if(startsWith(srsName, "urn:ogc:def:crs:EPSG::")){
              crs <- as(unlist(strsplit(srsName, "urn:ogc:def:crs:EPSG::"))[2],"integer")
            }else{
              if(regexpr(srsName, "/") > 0){
                srsName_parts <- unlist(strsplit(srsName, "/"))
                crs <- srsName_parts[length(srsName_parts)]
              }
            }
          }
        }
      }
      crs_obj <- suppressWarnings(try(sf::st_crs(paste0("EPSG:", crs)), silent = TRUE))
      if(is(crs_obj, "try-error")) crs_obj <- suppressWarnings(try(sf::st_crs(paste0("ESRI:", crs)), silent = TRUE))
      if(is(crs_obj, "try-error")) crs_obj <- NA
      return(crs_obj)
    },
    
    #'@description Get features
    #'@param typeName the name of the feature type
    #'@param ... any other parameter to pass to the \link{WFSGetFeature} request
    #'@param validate Whether features have to be validated vs. the feature type description. Default is \code{TRUE}
    #'@param outputFormat output format
    #'@param paging paging. Default is \code{FALSE}
    #'@param paging_length number of features to request per page. Default is 1000
    #'@param parallel whether to get features using parallel multicore strategy. Default is \code{FALSE}
    #'@param parallel_handler Handler function to parallelize the code. eg \link{mclapply}
    #'@param cl optional cluster object for parallel cluster approaches using eg. \code{parallel::makeCluster}
    #'@return features as object of class \code{sf}
    getFeatures = function(..., 
                           validate = TRUE,
                           outputFormat = NULL,
                           paging = FALSE, paging_length = 1000,
                           parallel = FALSE, parallel_handler = NULL, cl = NULL
                           ){
      #getdescription
      if(length(self$description)==0){
        self$description = self$getDescription()
      }
      if(is(self$description, "OWSException")){
        stop("Feature type could not be described, aborting getting features...")
      }
      vendorParams <- list(...)
      if(startsWith(private$version, "2.0")) if("maxfeatures" %in% tolower(names(vendorParams))){
        names(vendorParams)[tolower(names(vendorParams)) == "maxfeatures"] <- "count"
      }
      
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
      ftFeatures <- do.call(
        WFSGetFeature$new,
        c(
          capabilities = private$capabilities, op = op, url = private$url, version = private$version, typeName = private$name, outputFormat = outputFormat, 
          user = client$getUser(), pwd = client$getPwd(), token = client$getToken(), headers = client$getHeaders(), 
          config = client$getConfig(),
          logger = self$loggerType,
          vendorParams
        )
      )
      #exception handling
      if(ftFeatures$hasException()){
        return(ftFeatures$getException())
      }
      
      #response handling
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
      
      read_features = TRUE
      
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
            lcolnames = tolower(colnames(obj))
            if(self$getGeometryType() %in% colnames(obj)){
              sf::st_write(obj[,!duplicated(lcolnames)], destfile)
            }else{
              readr::write_csv(obj[,!duplicated(lcolnames)], destfile)
              read_features = FALSE
            }
          }
        )
      }
      
      if(!read_features){
        private$features = obj
        return(private$features)
      }
      
      #read features
      if(!is.null(outputFormat)){
        ftFeatures <- switch(tolower(outputFormat),
          "csv" = sf::st_read(destfile, quiet = TRUE,
            options = c(
              sprintf("GEOM_POSSIBLE_NAMES=%s", paste0(private$supportedGeomPossibleNames, collapse=",")),
              sprintf("X_POSSIBLE_NAMES=%s", paste0(private$supportedXPossibleNames, collapse=",")),
              sprintf("Y_POSSIBLE_NAMES=%s", paste0(private$supportedYPossibleNames, collapse=","))
            )
          ),      
          sf::st_read(destfile, quiet = TRUE)
        )
      }else{
        ftFeatures <- sf::st_read(destfile, quiet = TRUE)
      }
      if(self$hasGeometry()) if(self$getGeometryType() %in% colnames(ftFeatures)){
        if(is.na(st_crs(ftFeatures))) st_crs(ftFeatures) <- self$getFeaturesCRS(obj)
        if(is.na(st_crs(ftFeatures))) st_crs(ftFeatures) <- self$getDefaultCRS()
      }
        
      #validating attributes vs. schema
      if(validate) for(element in self$description){
        attrName = element$getName()
        attrType <- element$getType()
        if(!is.null(attrName) & !is.null(attrType) & !element$isGeometry()){
          test = ftFeatures[[attrName]]
          if(!is.null(ftFeatures[[attrName]])){
            if(attrType != "character"){
              ftFeatures[[attrName]] <- switch(attrType,
                "Date" = as.Date(ftFeatures[[attrName]]),
                "POSIXct" = as.POSIXct(ftFeatures[[attrName]]),
                as(ftFeatures[[attrName]], attrType)
              )
            }
          }
        }
      }
      private$features <- ftFeatures
      return(private$features)
    }
  )
)