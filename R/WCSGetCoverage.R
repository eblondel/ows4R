#' WCSGetCoverage
#'
#' @docType class
#' @export
#' @keywords OGC WCS GetCoverage
#' @return Object of \code{\link{R6Class}} for modelling a WCS GetCoverage request
#' @format \code{\link{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSGetCoverage <- R6Class("WCSGetCoverage",
  inherit = OWSHttpRequest,
  private = list(
    xmlElement = "GetCoverage",
    xmlNamespacePrefix = "WCS"
  ),
  public = list(
    
    #'@description Initializes a \link{WCSGetCoverage} service request
    #'@param capabilities an object of class \link{WCSCapabilities}
    #'@param op object of class \link{OWSOperation} as retrieved from capabilities
    #'@param url url
    #'@param serviceVersion serviceVersion
    #'@param coverageId coverage ID
    #'@param envelope envelope
    #'@param crs crs
    #'@param time time
    #'@param format format
    #'@param rangesubset range subset
    #'@param gridbaseCRS grid base CRS
    #'@param gridtype grid type
    #'@param gridCS grid CS
    #'@param gridorigin grid origin
    #'@param gridoffsets grid offsets
    #'@param logger logger
    #'@param ... any parameter to pass to the service request
    initialize = function(capabilities, op, url, serviceVersion,
                          coverageId, envelope = NULL, crs = NULL,
                          time = NULL, format = NULL, rangesubset = NULL, 
                          gridbaseCRS = NULL, gridtype = NULL, gridCS = NULL, 
                          gridorigin = NULL, gridoffsets = NULL, 
                          logger = NULL, ...) {
      namedParams <- list(service = "WCS", version = serviceVersion)
      if(startsWith(serviceVersion, "1.0")) namedParams <- c(namedParams, coverage = coverageId)
      if(startsWith(serviceVersion, "1.1")) namedParams <- c(namedParams, identifier = coverageId)
      if(startsWith(serviceVersion, "2.0")) namedParams <- c(namedParams, coverageId = coverageId)
      
      if(startsWith(serviceVersion,"1.0")){
        if(!is.null(envelope)) namedParams$BBOX <- paste0(as(envelope, "character"), collapse=",")
        if(!is.null(crs)) namedParams$CRS <- crs
        if(!is.null(time)) namedParams$Timesequence <- paste0(time, collapse=",")
      }
      if(startsWith(serviceVersion,"1.1")){
        #envelope object as matrix
        #if(!is.null(crs)) if(endsWith(crs, "EPSG::4326")) {
        #  envelope <- rbind(envelope[2,],envelope[1,]) 
        #}
        #if(!is.null(envelope)) namedParams$boundingbox <- paste0(as(envelope, "character"), collapse=",")
        if(!is.null(envelope)){
          namedParams$boundingbox <- paste(c(envelope$lowerCorner, envelope$upperCorner), collapse=",")
          if(!is.null(crs)) if(endsWith(crs, "EPSG::4326")) {
            namedParams$boundingbox <- paste(c(rev(envelope$lowerCorner), rev(envelope$upperCorner)), collapse=",")
          }
        }
        if(!is.null(crs)) namedParams$boundingbox <- paste(namedParams$boundingbox, crs, sep=",")
        if(!is.null(time)) namedParams$Timesequence <- paste0(time, collapse=",")
      }
      if(startsWith(serviceVersion, "2")){
        if(!is.null(envelope)){
          subsetParams <- unlist(strsplit(envelope$attrs$axisLabels, " "))
          #if(!is.null(crs)) if(endsWith(crs, "EPSG::4326")) {
          #   subsetParams <- c(subsetParams[2:1], subsetParams[3:length(subsetParams)])
          #}
          subsets <- lapply(subsetParams, function(subset){
            i <- which(subsetParams == subset)
            subsetKvp <- sprintf("%s(%s,%s)",subset, unlist(envelope$lowerCorner[,i]), unlist(envelope$upperCorner[,i]))
            
            #time is not necessarily handled as character, need to identify with
            #srsName the crs if spatial or temporal
            if(is.character(unlist(envelope$lowerCorner[,i])) & is.character(unlist(envelope$upperCorner[,i]))){
              if(is.null(time)) time <- envelope$upperCorner[,i]
              subsetKvp <- sprintf("%s(\"%s\")",subset, time) 
            }
            URLencode(subsetKvp)
          })
          names(subsets) <- rep("subset", length(subsets))
          namedParams <- c(namedParams, subsets)
        }
      }
      
      if(!is.null(format)) namedParams$format <- format
      if(!is.null(rangesubset)) namedParams$Rangesubset <- rangesubset
      if(!is.null(gridbaseCRS)) namedParams$gridbaseCRS <- gridbaseCRS
      if(!is.null(gridtype)) namedParams$gridtype <- gridtype
      if(!is.null(gridCS)) namedParams$gridCS <- gridCS
      if(!is.null(gridorigin)) namedParams$gridorigin <- gridorigin
      if(!is.null(gridoffsets)) namedParams$gridoffsets <- gridoffsets
      
      vendorParams <- list(...)
      if(length(vendorParams)>0){
        namedParams <- c(namedParams, vendorParams)
      }
      
      mimeType <- format
      if(substr(serviceVersion,1,3)=="1.1") mimeType <- "text/xml"
      
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                       capabilities, op, "GET", url, request = "GetCoverage",
                       namedParams = namedParams, mimeType = mimeType,
                       logger = logger, ...)
      self$execute()
    }
  )
)