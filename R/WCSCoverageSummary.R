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
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, capabilities, serviceVersion, owsVersion, logger)}}{
#'    This method is used to instantiate a \code{WCSCoverageSummary} object
#'  }
#'  \item{\code{getId()}}{
#'    Get the identifier
#'  }
#'  \item{\code{getSubtype()}}{
#'    Get the coverage subtype
#'  }
#'  \item{\code{getSubtypeParent()}}{
#'    Get the coverage subtype parent type(s)
#'  }
#'  \item{\code{getWGS84BoundingBox()}}{
#'    Get coverage WGS84 bounding box as list of \code{OWSWGS84BoundingBox}
#'  }
#'  \item{\code{getBoundingBox()}}{
#'    Get coverage bounding box as list of \code{OWSBoundingBox}
#'  }
#'  \item{\code{getDescription()}}{
#'    Get coverage description
#'  }
#'  \item{\code{getDimensions()}}{
#'    Get the coverage dimensions, returned as\code{list}. Each element of this list
#'    will reference the axis abbreviation/label used for coverage query based on this
#'    dimension, the \pkg{geometa} GML object and classname, the type of dimension such as
#'    'geographic', 'temporal' or 'vertical', and if applicable: the possible values 
#'    (coefficients) that can be used for querying the coverage on the dimension. 
#'  }
#'  \item{\code{getCoverage(bbox, crs, time, elevation, format, rangesubset, 
#'                          gridbaseCRS, gridtype, gridCS, gridorigin, gridoffsets)}}{
#'    Get the coverage data as object of class \code{RasterLayer} from \pkg{raster}
#'  }
#'  \item{\code{getCoverageStack(time, elevation, bbox)}}{
#'    Get a stack of coverages (also known as 'datacube') for time and/or elevation. Each parameter
#'    can be specified a vector of values (coefficients) as filter. If no value is specified, the function will
#'    consider all coefficients for the given dimension. An additional bbox parameter allows to restrain
#'    the geographic extent of the overall coverage stack/datacube.
#'    
#'    For a spatio-temporal 3D coverage, in case that no time filter is specified, the full temporal coverage stack
#'    will be downloaded. For a spatio/vertical 3D coverage, in case that no elevation filter is specified, the full
#'    vertical coverage stack will be downloaded. Finally, in case of spatio-vertical-temporal 4D coverage, in case
#'    no time/elevation filter is specified, the full coverage stack corressponding to the combinations of temporal
#'    and vertical coefficients will be downloaded.
#'    
#'    This function returns an object of class \code{RasterStack} from \pkg{raster}
#'  }
#' }
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
    }
    
  )
)