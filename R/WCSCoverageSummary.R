#' WCSCoverageSummary
#'
#' @docType class
#' @export
#' @keywords OGC WCS Coverage
#' @return Object of \code{\link{R6Class}} modelling a WCS coverage summary
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSCoverageSummary <- R6Class("WCSCoverageSummary",
  inherit = OGCAbstractObject,                       
  private = list(
    capabilities = NULL,
    url = NA,
    version = NA,
    owsVersion = NA,
    description = NULL,
    dimensions = NULL,
    
    #fetchCoverageSummary
    fetchCoverageSummary = function(xmlObj, serviceVersion, owsVersion){
      
      children <- xmlChildren(xmlObj)
      
      covId <- NULL
      if(substr(serviceVersion,1,3)=="1.0"){
        covId <- xmlValue(children$name)
      }else if(substr(serviceVersion,1,3)=="1.1"){
        covId <- xmlValue(children$Identifier)
      }else if(substr(serviceVersion,1,3)=="2.0"){
        covId <- xmlValue(children$CoverageId)
      }
      
      covSubtype <- NULL
      if(!is.null(children$CoverageSubtype)){
        covSubtype <- xmlValue(children$CoverageSubtype)
      }
      
      covSubtypeParent <- NULL
      if(!is.null(children$CoverageSubtypeParent)){
        recurseChildren <- xmlChildren(children$CoverageSubtypeParent)
        covSubtypeParent <- list()
        covSubtypeParent <- c(covSubtypeParent, xmlValue(recurseChildren$CoverageSubtype))
        while(!is.null(recurseChildren$CoverageSubtypeParent)){
          recurseChildren <- xmlChildren(recurseChildren$CoverageSubtypeParent)
          covSubtypeParent <- c(covSubtypeParent, xmlValue(recurseChildren$CoverageSubtype))
        }
      }
      covSubtypeParent <- unlist(covSubtypeParent)
      
      #list of OWSWGS84BoundingBox
      covWgs84BoundingBox <- NULL
      if(substr(serviceVersion,1,3)=="1.0"){
        lonlatEnvXML <- children[names(children)=="lonLatEnvelope"]
        if(!is.null(lonlatEnvXML)){
          if(!is.list(lonlatEnvXML)) lonlatEnvXML <- list(lonlatEnvXML)
          covWgs84BoundingBox <- lapply(lonlatEnvXML, function(xml){ 
            return(OWSWGS84BoundingBox$new(xml, owsVersion = owsVersion, serviceVersion = serviceVersion)) 
          })
        }
      }else{
        wgs84BboxXML <- children[names(children)=="WGS84BoundingBox"]
        if(!is.null(wgs84BboxXML)){
          if(!is.list(wgs84BboxXML)) wgs84BboxXML <- list(wgs84BboxXML)
          covWgs84BoundingBox <- lapply(wgs84BboxXML, function(xml){ 
            return(OWSWGS84BoundingBox$new(xml, owsVersion = owsVersion, serviceVersion = serviceVersion)) 
          })
        }
      }
      
      #list of OWSBoundingBox
      covBoundingBox <- NULL
      bboxXML <- children[names(children)=="BoundingBox"]
      if(!is.null(bboxXML)){
        if(!is.list(bboxXML)) bboxXML <- list(bboxXML)
        covBoundingBox <- lapply(bboxXML, function(xml){ return(
          OWSBoundingBox$new(xml,owsVersion = owsVersion, serviceVersion = serviceVersion)) 
        })
      }
      
      coverageSummary <- list(
        CoverageId = covId,
        CoverageSubtype = covSubtype,
        CoverageSubtype = covSubtypeParent,
        WGS84BoundingBox = covWgs84BoundingBox,
        BoundingBox = covBoundingBox
      )
      
      return(coverageSummary)
      
    }
    
  ),
  public = list(
    #'@field CoverageId coverage id
    CoverageId = NA,
    #'@field CoverageSubtype coverage subtype
    CoverageSubtype = NA,
    #'@field CoverageSubtypeParent coverage subtype parent
    CoverageSubtypeParent = list(),
    #'@field WGS84BoundingBox WGS84 bounding box
    WGS84BoundingBox = list(),
    #'@field BoundingBox bounding box
    BoundingBox = list(),
    
    #'@description Initializes a \link{WCSCoverageSummary} object
    #'@param xmlObj object of class \link{XMLInternalNode-class} from \pkg{XML}
    #'@param capabilities object of class \link{WCSCapabilities}
    #'@param serviceVersion WCS service version
    #'@param owsVersion version
    #'@param logger logger type \code{NULL}, "INFO" or "DEBUG"
    initialize = function(xmlObj, capabilities, serviceVersion, owsVersion, logger = NULL){
      super$initialize(logger = logger)
      
      private$capabilities = capabilities
      private$url = capabilities$getUrl()
      private$version = serviceVersion
      private$owsVersion = owsVersion
      
      covSummary = private$fetchCoverageSummary(xmlObj, serviceVersion, owsVersion)
      self$CoverageId = covSummary$CoverageId
      self$CoverageSubtype = covSummary$CoverageSubtype
      self$CoverageSubtypeParent = covSummary$CoverageSubtypeParent
      self$WGS84BoundingBox = covSummary$WGS84BoundingBox
      self$BoundingBox = covSummary$BoundingBox
    },
    
    #'@description Get coverage ID
    #'@return an object of class \code{character}
    getId = function(){
      return(self$CoverageId)
    },
    
    #'@description Get sub type
    #'@return an object of class \code{character}
    getSubtype = function(){
      return(self$CoverageSubtype)
    },
    
    #'@description Get sub type parent
    #'@return an object of class \code{character}
    getSubtypeParent = function(){
      return(self$CoverageSubtypeParent)
    },
    
    #'@description Get bounding box
    #'@return an object of class \link{OWSWGS84BoundingBox}
    getWGS84BoundingBox = function(){
      return(self$WGS84BoundingBox)
    },
    
    #'@description Get WGS84 bounding box
    #'@return an object of class \link{OWSBoundingBox}
    getBoundingBox = function(){
      return(self$BoundingBox)
    },
    
    #'@description Get description
    #'@return an object of class \link{WCSCoverageDescription}
    getDescription = function(){
      if(!is.null(private$description)) return(private$description)
      
      op <- NULL
      operations <- private$capabilities$getOperationsMetadata()$getOperations()
      if(length(operations)>0){
        op <- operations[sapply(operations,function(x){x$getName()=="DescribeCoverage"})]
        if(length(op)>0){
          op <- op[[1]]
        }else{
          stop("Operation 'DescribeCoverage' not supported by this service")
        }
      }
      covDescription <- WCSDescribeCoverage$new(capabilities = private$capabilities, op = op, url = private$url, 
                                                serviceVersion = private$version, coverageId = self$CoverageId, 
                                                logger = self$loggerType)
      xmlObj <- covDescription$getResponse()
      wcsNs <- NULL
      if(all(class(xmlObj) == c("XMLInternalDocument","XMLAbstractDocument"))){
        namespaces <- OWSUtils$getNamespaces(xmlObj)
        wcsNs <- OWSUtils$findNamespace(namespaces, id = "wcs")
      }
      covDesXML <- list()
      if(substr(private$version,1,3)=="1.0"){
        covDesXML <- getNodeSet(xmlObj, "//ns:CoverageOffering", wcsNs)
      }else{
        covDesXML <- getNodeSet(xmlObj, "//ns:CoverageDescription", wcsNs)
      }
      if(length(covDesXML)>0) covDesXML <- covDesXML[[1]]
      description <- WCSCoverageDescription$new(covDesXML, private$version, private$owsVersion,
                                                logger = self$loggerType)
      private$description = description
      return(description)
    },
    
    #'@description Get dimensions
    #'@return
    getDimensions = function(){
      dimensions <- NULL
      des <- self$getDescription()
      if(!is.null(private$dimensions)) return(private$dimensions)
      if(!is.null(des$boundedBy)){
        self$INFO("Fetching Coverage envelope dimensions by CRS interpretation")
        srsName <- des$boundedBy$attrs$srsName
        if(is.null(srsName)){
          self$ERROR("No 'srsName' envelope attribute for CRS interpretation")
          return(NULL)
        }
        srsNameXML <- try(XML::xmlParse(srsName))
        if(is(srsNameXML,"try-error")){
          self$ERROR("Error during srsName CRS interpretation")
          return(NULL)
        }
        gmlCRSClass <- geometa::ISOAbstractObject$getISOClassByNode(srsNameXML)
        if(is.null(gmlCRSClass)){
          self$ERROR(sprintf("No GML CRS class recognized for srsName '%s'", srsName))
          return(NULL)
        }else{
          
          #fetchRemoteCRS function
          fetchRemoteCRS <- function(thecrs){
            out_crs <- thecrs
            crsHref <- thecrs$attrs[["xlink:href"]]
            if(!is.null(crsHref)){
              self$INFO(sprintf("Try to parse CRS from '%s'", crsHref))
              crsXML <- try(XML::xmlParse(crsHref))
              if(is(crsXML, "try-error")){
                self$ERROR(sprintf("Error during parsing CRS '%s'", crsHref))
                return(NULL)
              }
              outCrsClass <- geometa::ISOAbstractObject$getISOClassByNode(crsXML)
              out_crs <- outCrsClass$new(xml = crsXML)
            }
            return(out_crs)
          }
          
          crs <- gmlCRSClass$new(xml = srsNameXML)
          if(gmlCRSClass$classname == "GMLCompoundCRS"){
            comprs <- crs$componentReferenceSystem
            crs <- lapply(comprs, fetchRemoteCRS)
          }else{
            crs <- fetchRemoteCRS(crs)
            crs <- list(crs)
          }
          
          axisLabels <- unlist(strsplit(des$boundedBy$attrs$axisLabels, " "))
          uomLabels <- unlist(strsplit(des$boundedBy$attrs$uomLabels, " "))
          dimensions <- lapply(1:length(axisLabels), function(i){
            dimension <- list(label = axisLabels[i], uom = uomLabels[i])
            dimension$type <- "geographic"
            invisible(lapply(crs, function(singlecrs){
              csp <- names(singlecrs)[sapply(names(singlecrs), function(x){inherits(singlecrs[[x]], "GMLAbstractCoordinateSystem")})]
              if(length(csp)>0){
                cs <- singlecrs[[csp]]
                axis_match <- cs$axis[sapply(cs$axis, function(axis){
                  axisValue <- axis$axisAbbrev$value
                  if(axisValue == "Lon" & axisLabels[i] == "Long") axisValue <- "Long"
                  axisValue == axisLabels[i]
                })]
                if(length(axis_match)>0){
                  axis_match <- axis_match[[1]]
                  dimension$identifier <<- axis_match$identifier$value
                  dimension$direction <<- axis_match$axisDirection$value
                  dimension$gmlclass <<- singlecrs$getClassName()
                  dimension$type <<- switch(singlecrs$getClassName(),
                                            "GMLTemporalCRS" = "temporal",
                                            "GMLVerticalCRS" = "vertical",
                                            "GMLImageCRS" = "vertical",
                                            "geographic"
                  )
                  
                  if(!is.null(des$domainSet$generalGridAxis)){
                    coeffs <- des$domainSet$generalGridAxis[[i]]$coefficients
                    if(is.matrix(coeffs)){
                      dimension$coefficients <<- coeffs
                    }else{
                      dimension$coefficients <<- NA
                    }
                  }
                }
              }
            }))
            if(i==length(axisLabels) & is(des$boundedBy, "GMLEnvelopeWithTimePeriod")){
              #resolve temporal diemnsion in case of GMLEnvelopeWithTimePeriod
              dimension$type <- "temporal"
            }
            if(is.null(dimension$coefficients)){
              if(!is.null(des$metadata)){
                
                if(dimension$type == "temporal"){
                  timeDomain <- des$metadata$TimeDomain
                  if(!is.null(timeDomain) & is(timeDomain, "WCSGSTimeDomain")){
                    dimension$coefficients <- as.matrix(des$metadata$TimeDomain$TimeInstant)   
                  }
                }
                if(dimension$type == "vertical"){
                  elevationDomain <- des$metadata$ElevationDomain
                  if(!is.null(elevationDomain) & is(elevationDomain, "WCSGSElevationDomain")){
                    dimension$coefficients <- as.matrix(des$metadata$ElevationDomain$SingleValue)
                  }
                }
              }
            }
            
            return(dimension)
          })
        }
      }
      
      private$dimensions <- dimensions
      return(dimensions)
    },
    
    #'@description Get coverage data
    #'@param bbox bbox. Default is \code{NULL}
    #'@param crs crs. Default is \code{NULL}
    #'@param time time. Default is \code{NULL}
    #'@param elevation elevation. Default is \code{NULL}
    #'@param format format. Default is "image/tiff"
    #'@param rangesubset rangesubset. Default is \code{NULL}
    #'@param gridbaseCRS grid base CRS. Default is \code{NULL}
    #'@param gridtype grid type. Default is \code{NULL}
    #'@param gridCS grid CS. Default is \code{NULL}
    #'@param gridorigin grid origin. Default is \code{NULL}
    #'@param gridoffsets grid offsets. Default is \code{NULL}
    #'@param ... any other argument to \link{WCSGetCoverage}
    #'@return an object of class \link{raster} from \pkg{raster}
    getCoverage = function(bbox = NULL, crs = NULL, 
                           time = NULL, elevation = NULL,
                           format = "image/tiff", rangesubset = NULL, 
                           gridbaseCRS = NULL, gridtype = NULL, gridCS = NULL, 
                           gridorigin = NULL, gridoffsets = NULL, ...){
      coverage_data <- NULL
      op <- NULL
      operations <- private$capabilities$getOperationsMetadata()$getOperations()
      if(length(operations)>0){
        op <- operations[sapply(operations,function(x){x$getName()=="GetCoverage"})]
        if(length(op)>0){
          op <- op[[1]]
        }else{
          stop("Operation 'GetCoverage' not supported by this service")
        }
      }
      if(!is.null(format)){
        if(substr(private$version,1,3)=="1.1"){
          if(!(format %in% self$getDescription()$getSupportedFormats())){
            stop(sprintf("Format should be one of the allowed values [%s]",
                         paste0(self$getDescription()$getSupportedFormats())))
          }
        }else if(substr(private$version,1,3)=="2.0"){
          #TODO check format in case of WCS2
        }
        
      }
      
      #crs
      if(!is.null(crs)){
        if(substr(private$version,1,3)=="1.0"){
          domainCRS <- self$getDescription()$getSupportedCRS()
          if(!(crs %in% domainCRS)){
            stop(sprintf("CRS should be one of the allowed domain CRS [%s]", paste(domainCRS, collapse=",")))
          }
        }else if(substr(private$version,1,3)=="1.1"){
          domainCRS <- sapply(self$getDescription()$getDomain()$getSpatialDomain()$BoundingBox, function(x){x$attrs$crs})
          if(!(crs %in% domainCRS)){
            stop(sprintf("CRS should be one of the allowed domain CRS [%s]", paste(domainCRS, collapse=",")))
          }
        }else if(substr(private$version,1,3)=="2.0"){
          #TODO check crs in case of WCS2
        }
      }else{
        if(substr(private$version,1,3)=="1.0"){
          domainCRS <- self$getDescription()$getSupportedCRS()
          crs <- domainCRS[1]
        }else if(substr(private$version,1,3)=="1.1"){
          domainCRS <- sapply(self$getDescription()$getDomain()$getSpatialDomain()$BoundingBox, function(x){x$attrs$crs})
          crs <- domainCRS[domainCRS == self$getDescription()$getSupportedCRS()[1]]
        }else if(substr(private$version,1,3)=="2.0"){
          srsName <- self$getDescription()$boundedBy$attrs[["srsName"]]
          srs_elems <- unlist(strsplit(srsName,"/"))
          srid <- srs_elems[length(srs_elems)]
          crs <- paste0("urn:ogc:def:crs:EPSG::",srid)
        }
      }
      
      #envelope
      envelope = NULL
      if(is.null(bbox)){
        envelope <- switch(substr(private$version,1,3),
           "1.0" = {
             owsbbox <- self$getWGS84BoundingBox()[[1]]
             OWSUtils$toBBOX(owsbbox$LowerCorner[1], owsbbox$UpperCorner[1], owsbbox$LowerCorner[2], owsbbox$UpperCorner[2]) 
           },
           "1.1" = {
             bboxes <- self$getDescription()$getDomain()$getSpatialDomain()$BoundingBox
             owsbbox <- bboxes[sapply(bboxes, function(x){return(x$attrs$crs == crs)})][[1]]
             xorder <- 1; yorder <- 2;
             if(endsWith(crs, "EPSG::4326")){
               xorder <- 2; yorder <- 1;
             }
             OWSUtils$toBBOX(owsbbox$LowerCorner[xorder], owsbbox$UpperCorner[xorder], owsbbox$LowerCorner[yorder], owsbbox$UpperCorner[yorder]) 
           },
           "2.0" = {
             env <- self$getDescription()$boundedBy
             envattrs <- env$attrs
             #normalize as Envelope based on bbox matrix
             if(is(env, "GMLEnvelopeWithTimePeriod")){
               beginPosition <- env$beginPosition
               endPosition <- env$endPosition
               bbox <- matrix(c(env$lowerCorner,env$beginPosition$value, env$upperCorner, env$endPosition$value),length(env$lowerCorner)+1,2)
               env <- GMLEnvelope$new(bbox = bbox)
               env$attrs <- envattrs
               env <- OWSUtils$checkEnvelopeDatatypes(env)
             }
             env
           }
        )
      }else{
        if(substr(private$version,1,3) == "1.1"){
          envelope <- GMLEnvelope$new(bbox = bbox)
        }
        if(substr(private$version,1,3)=="2.0"){
          refEnvelope <- self$getDescription()$boundedBy
          axisLabels <- unlist(strsplit(refEnvelope$attrs$axisLabels, " "))
          if(axisLabels[1]=="Lat") bbox <- rbind(bbox[2,],bbox[1,])
          envelope <- GMLEnvelope$new(bbox = bbox)
          if(as.numeric(refEnvelope$attrs$srsDimension)>2){
            #TODO and what if geo coordinates are not the first dims defined in envelope?
            envelope$lowerCorner <- cbind(envelope$lowerCorner, refEnvelope$lowerCorner[,3:length(refEnvelope$lowerCorner)])
            envelope$upperCorner <- cbind(envelope$upperCorner, refEnvelope$upperCorner[,3:length(refEnvelope$upperCorner)])
          }
          if(is(refEnvelope, "GMLEnvelopeWithTimePeriod")){
            envelope$lowerCorner <- cbind(envelope$lowerCorner, refEnvelope$beginPosition$value)
            envelope$upperCorner <- cbind(envelope$upperCorner, refEnvelope$endPosition$value)
          }
          envelope$attrs <- self$getDescription()$boundedBy$attrs
          envelope <- OWSUtils$checkEnvelopeDatatypes(envelope)
        }
      }
      
      #dimensions
      dims <- self$getDimensions() #TODO and for other versions of WCS?
      if(!is.null(dims)){
        
        #TODO geographic dimension checks?
        
        #temporal dimension checks
        timeDim <- dims[sapply(dims, function(x){x$type == "temporal"})]
        hasTemporalDimension <- length(timeDim) > 0
        if(!hasTemporalDimension){
          self$WARN("Coverage without temporal dimension: 'time' argument is ignored")
        }else{
          timeDim <- timeDim[[1]]
          if(is.null(time)){
            defaultTime <- timeDim$coefficients[[length(timeDim$coefficients)]]
            self$INFO(sprintf("Using default 'time' value '%s'", defaultTime)) 
          }else{
            if(!(time %in% timeDim$coefficients)){
              error <- sprintf("The 'time' specified value is not valid. Allowed values for this coverage are [%s]",
                               paste(timeDim$coefficients, collapse=","))
              self$ERROR(error)
              stop(errorMsg)
            }
          }
        }
        
        #vertical dimension checks
        vertDim <- dims[sapply(dims, function(x){x$type == "vertical"})]
        hasVerticalDimension <- length(vertDim) > 0
        
        if(!hasVerticalDimension){
          self$WARN("Coverage without vertical dimension: 'elevation' argument is ignored")
        }else{
          vertDim <- vertDim[[1]]
          if(is.null(elevation)){
            defaultElevation <- vertDim$coefficients[[length(vertDim$coefficients)]]
            self$INFO(sprintf("Using default 'elevation' value '%s'", defaultElevation)) 
          }else{
            if(!(elevation %in% vertDim$coefficients)){
              errorMsg <- sprintf("The 'elevation' specified value is not valid. Allowed values for this coverage are [%s]",
                                  paste(vertDim$coefficients, collapse=","))
              self$ERROR(error)
              stop(errorMsg)
            }
          }
        }
        
      }
      
      print(envelope)
      
      #GetCoverage request
      getCoverageRequest <- WCSGetCoverage$new(op = op, private$url, 
                                               private$version, private$owsVersion,
                                               coverageId = self$CoverageId, logger = self$loggerType,
                                               envelope = envelope, crs = crs, time = time, format = format, rangesubset = rangesubset, 
                                               gridbaseCRS = gridbaseCRS, gridtype = gridtype, gridCS = gridCS, 
                                               gridorigin = gridorigin, gridoffsets = gridoffsets, ...)
      resp <- getCoverageRequest$getResponse()
      
      if(!is(resp, "raw")){
        hasError <- xmlName(xmlRoot(resp)) == "ExceptionReport"
        if(hasError){
          errMsg <- sprintf("Error while getting coverage: %s", xpathSApply(resp, "//ows:ExceptionText", xmlValue))
          self$ERROR(errMsg)
          return(NULL)
        }
      }
      
      #response handling
      if(substr(private$version,1,3)=="1.1"){
        #for WFS 1.1, wrap with WCSCoverage object and get data
        namespaces <- OWSUtils$getNamespaces(xmlRoot(resp))
        namespaces <- as.data.frame(namespaces)
        nsVersion <- ""
        if(startsWith(private$owsVersion, "1.0")) nsVersion <- "1.0"
        if(startsWith(private$owsVersion, "1.1")) nsVersion <- "1.1.1"
        if(startsWith(private$owsVersion, "2.0")) nsVersion <- "2.0"
        wcsNamespaceURI <- paste("http://www.opengis.net/wcs", nsVersion, sep ="/")
        wcsNs <- OWSUtils$findNamespace(namespaces, uri = wcsNamespaceURI)
        if(is.null(wcsNs)) wcsNs <- OWSUtils$findNamespace(namespaces, id = "wcs")
        print(wcsNs)
        xmlObj <- getNodeSet(resp, "//ns:Coverage", wcsNs)[[1]]
        coverage <- WCSCoverage$new(xmlObj = xmlObj, private$version, private$owsVersion, logger = self$loggerType)
        coverage_data <- coverage$getData()
      }else if(substr(private$version,1,3)=="2.0"){
        #for WCS 2.0.x take directly the data
        tmp <- tempfile()
        writeBin(resp, tmp)
        coverage_data <- raster::raster(tmp)
      }
      
      #add raster attributes
      name <- self$getId()
      if(!is.null(bbox)) name <- paste(name, "_bbox-", paste(as(bbox,"character"), collapse=","))
      if(!is.null(time)) name <- paste(name, "_time-:", time)
      names(coverage_data) <- name
      title <- self$getId()
      if(!is.null(bbox)) title <- paste(title, "| BBOX:", paste(as(bbox,"character"), collapse=","))
      if(!is.null(time)) title <- paste(title," | TIME:", time)
      attr(coverage_data,"title") <- title
      cov_values <- raster::getValues(coverage_data)
      if(!all(is.na(cov_values))){
        slot(attr(coverage_data, "data"),"min") <- min(cov_values, na.rm = TRUE)
        slot(attr(coverage_data, "data"),"max") <- max(cov_values, na.rm = TRUE)
      }
      
      return(coverage_data)
    },
    
    #'@description Get a spatio-temporal coverage data cubes as coverage \link{stack}
    #'@param time time
    #'@param elevation elevation
    #'@param bbox bbox
    #'@return an object of class \link{stack} from \pkg{raster}
    getCoverageStack = function(time = NULL, elevation = NULL, bbox = NULL){
      out <- NULL
      dims <- self$getDimensions()
      timeDim <- dims[sapply(dims, function(x){x$type == "temporal"})]
      hasTemporalDimension <- length(timeDim) > 0
      if(hasTemporalDimension){
        timeDim <- timeDim[[1]]
        if(is.null(time)){
          time <- timeDim$coefficients
        }
      }
      vertDim <- dims[sapply(dims, function(x){x$type == "vertical"})]
      hasVerticalDimension <- length(vertDim) > 0
      if(hasVerticalDimension){
        vertDim <- vertDim[[1]]
        if(is.null(elevation)){
          elevation <- vertDim$coefficients
        }
      }
      
      stack_kvps <- list()
      if(!is.null(time) & !is.null(elevation)){
        self$INFO("Fetching coverage stack with both 'temporal' and 'vertical' dimensions")
        cj <- expand.grid(time = time, elevation = elevation)
        stack_kvps <- lapply(1:nrow(cj), function(i){
          kvps <- list()
          cj_kvps <- as.list(as.character(unlist(cj[i,])))
          names(cj_kvps) <- names(cj)
          kvps <- c(kvps, cj_kvps)
          return(kvps)
        })
      }else{
        if(!is.null(time)){
          self$INFO("Fetching coverage stack with 'temporal' dimension")
          stack_kvps <- lapply(time, function(x){
            kvps <- list()
            kvps$time <- x
            return(kvps)
          })
        }else if(!is.null(elevation)){
          self$INFO("Fetching coverage stack with 'vertical' dimension")
          stack_kvps <- lapply(elevation, function(x){
            kvps <- list()
            kvps$elevation <- x
            return(kvps)
          })
        }else{
          self$WARN("No multi-dimensions. Returning a simple coverage")
          return(self$getCoverage(bbox = bbox))
        }
      }
      
      if(length(stack_kvps)>0){
        coverage_list <- lapply(stack_kvps, function(stack_kvp){
          self$INFO(stack_kvp)
          coverage <- self$getCoverage(bbox = bbox, time = stack_kvp$time, elevation = stack_kvp$elevation)
          return(coverage)
        })
        out <- raster::stack(coverage_list)
      }
      return(out)
    }
    
  )
)