#' WCSGetCoverage
#'
#' @docType class
#' @export
#' @keywords OGC WCS GetCoverage
#' @return Object of \code{\link[R6]{R6Class}} for modelling a WCS GetCoverage request
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a WCS GetCoverage request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSGetCoverage <- R6Class("WCSGetCoverage",
  lock_objects = FALSE,
  inherit = OWSHttpRequest,
  private = list(
    xmlElement = "GetCoverage",
    xmlNamespacePrefix = "WCS"
  ),
  public = list(
    
    #'@field CoverageId coverage identifier
    CoverageId = NULL,
    #'@field format coverage format
    format = NULL,
    
    #'@description Initializes a \link{WCSGetCoverage} service request
    #'@param capabilities an object of class \link{WCSCapabilities}
    #'@param op object of class \link{OWSOperation} as retrieved from capabilities
    #'@param url url
    #'@param serviceVersion serviceVersion
    #'@param coverage coverage, object of class \link{WCSCoverageSummary}
    #'@param envelope envelope
    #'@param crs crs
    #'@param time time
    #'@param elevation elevation
    #'@param format format
    #'@param rangesubset range subset
    #'@param gridbaseCRS grid base CRS
    #'@param gridtype grid type
    #'@param gridCS grid CS
    #'@param gridorigin grid origin
    #'@param gridoffsets grid offsets
    #'@param user user
    #'@param pwd password
    #'@param token token
    #'@param headers headers
    #'@param config config
    #'@param method method
    #'@param logger logger
    #'@param ... any parameter to pass to the service request
    initialize = function(capabilities, op, url, serviceVersion,
                          coverage, envelope = NULL, crs = NULL,
                          time = NULL, elevation = NULL, format = NULL, rangesubset = NULL, 
                          gridbaseCRS = NULL, gridtype = NULL, gridCS = NULL, 
                          gridorigin = NULL, gridoffsets = NULL,
                          user = NULL, pwd = NULL, token = NULL, headers = c(), config = httr::config(),
                          method = "GET",
                          logger = NULL, ...) {
      
      coverageId <- coverage$getId()
      
      #For WCS 1.x we still do a GET request
      if(startsWith(serviceVersion, "1")) method <- "GET"
      
      if(method == "GET"){
        #GET WCS GetCoverage
        namedParams <- list(service = "WCS", version = serviceVersion)
        
        #coverageId
        if(startsWith(serviceVersion, "1.0")) namedParams <- c(namedParams, coverage = coverageId)
        if(startsWith(serviceVersion, "1.1")) namedParams <- c(namedParams, identifier = coverageId)
        if(startsWith(serviceVersion, "2")) namedParams <- c(namedParams, coverageId = coverageId)
        
        if(startsWith(serviceVersion,"1.0")){
          if(!is.null(envelope)) namedParams$BBOX <- paste0(as(envelope, "character"), collapse=",")
          if(!is.null(crs)) namedParams$CRS <- crs
          if(!is.null(time)) namedParams$time <- paste0(time, collapse=",")
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
            print(envelope)
            dims <- coverage$getDimensions()
            subsetParams <- unlist(strsplit(envelope$attrs$axisLabels, " "))
            subsets <- lapply(subsetParams, function(subset){
              i <- which(subsetParams == subset)
              dimension <- dims[sapply(dims, function(x){x$label == subset})][[1]]
              subsetKvp <- NULL
              if(!is.null(dimension)){
                if(dimension$type == "geographic"){
                  subsetKvp <- sprintf("%s(%s,%s)",subset,
                                       base::format(unlist(envelope$lowerCorner[,i]), scientific = FALSE), 
                                       base::format(unlist(envelope$upperCorner[,i]), scientific = FALSE))
                }else{
                  value <- switch(dimension$type,
                                  "temporal" = time,
                                  "elevation" = elevation,
                                  envelope$lowerCorner[,i]
                  )
                  if(!is.null(value)){
                    if(is(value, "numeric")){
                      if(length(value)==1){
                        subsetKvp <- sprintf("%s(%s)",subset, base::format(value, scientific = FALSE)) 
                      }else if(length(value)==2){
                        subsetKvp <- sprintf("%s(%s,%s)",subset, base::format(value, scientific = FALSE), base::format(value, scientific = FALSE))
                      }
                      
                    }else{
                      if(length(value)==1){
                        subsetKvp <- sprintf("%s(\"%s\")",subset, value)
                      }else if(length(value)==2){
                        subsetKvp <- sprintf("%s(\"%s\",\"%s\")",subset, value, value) 
                      }
                    }
                  }
                }
              }else{
                subsetKvp <- sprintf("%s(%s,%s)",subset, unlist(envelope$lowerCorner[,i]), unlist(envelope$upperCorner[,i]))
                if(tolower(subset) %in% c("time","elevation")){
                  value <- NULL
                  if(tolower(subset)=="time") value <- time
                  if(tolower(subset)=="elevation") value <- elevation
                  if(is.null(value)) value <- envelope$lowerCorner[,i]
                  if(!is.null(value)){
                    if(is(value, "numeric")){
                      if(length(value)==1){
                        subsetKvp <- sprintf("%s(%s)",subset, value) 
                      }else if(length(value)==2){
                        subsetKvp <- sprintf("%s(%s,%s)",subset, value, value)
                      }
                      
                    }else{
                      if(length(value)==1){
                        subsetKvp <- sprintf("%s(\"%s\")",subset, value)
                      }else if(length(value)==2){
                        subsetKvp <- sprintf("%s(\"%s\",\"%s\")",subset, value, value) 
                      }
                    }
                  }
                }
              }
              
              if(!is.null(subsetKvp)) subsetKvp = URLencode(subsetKvp)
              return(subsetKvp)
            })
            subsets <- subsets[!sapply(subsets, is.null)]
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
        
        #vendorParams <- list(...)
        #if(length(vendorParams)>0){
        #  namedParams <- c(namedParams, vendorParams)
        #}
        
        mimeType <- format
        if(substr(serviceVersion,1,3)=="1.1") mimeType <- "text/xml"
        
        super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                         capabilities = capabilities, op = op, type = "GET", url = url, request = private$xmlElement,
                         user = user, pwd = pwd, token = token, headers = headers, config = config,
                         namedParams = namedParams, mimeType = mimeType,
                         logger = logger, ...)
        
      }else if(method == "POST"){
        #for WCS 2.x we support POST request
        nsVersion <- substr(serviceVersion,1,3)
        private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", nsVersion), sep="_")
        super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                         capabilities = capabilities, op = op, type = "POST", url = url, request = private$xmlElement,
                         user = user, pwd = pwd, token = token, headers = headers, config = config,
                         contentType = "text/xml", mimeType = format,
                         logger = logger, ...)
        self$wrap <- TRUE
        self$attrs <- list(service = "WCS", version = serviceVersion)
        self$CoverageId <- coverageId
        self$format <- format
      }
        
      self$execute()
    }
  )
)