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
    }
    
  )
)