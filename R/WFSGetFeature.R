#' WFSGetFeature
#'
#' @docType class
#' @export
#' @keywords OGC WFS GetFeature
#' @return Object of \code{\link{R6Class}} for modelling a WFS GetFeature request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(op, url, version, typeName, outputFormat, logger, ...)}}{
#'    This method is used to instantiate a WFSGetFeature object
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WFS DescribeFeatureType request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSGetFeature <- R6Class("WFSGetFeature",
  inherit = OWSRequest,
  private = list(
     name = "GetFeature"
  ), 
  public = list(
     initialize = function(op, url, version, typeName, outputFormat = NULL, logger = NULL, ...) {
       
       if(is.null(outputFormat)){
         mimeType <- "text/xml"
       }else{
         mimeType <- switch(tolower(outputFormat),
           "application/json" = "application/json",
           "json" = "application/json", #for backward compatibility
           "csv" = "text/csv",
           "text/plain"
         )
       }

       namedParams <- list(service = "WFS", version = version)
       if(startsWith(version, "1")){
         namedParams <- c(namedParams, typeName = typeName)
       }else if(startsWith(version, "2.0")){
         namedParams <- c(namedParams, typeNames = typeName)
       }
       namedParams <- c(namedParams, outputFormat = outputFormat)
       vendorParams <- list(...)
       if(length(vendorParams)>0) namedParams <- c(namedParams, vendorParams)
       namedParams <- namedParams[!sapply(namedParams, is.null)]
       super$initialize(op, "GET", url, request = private$name, 
                        namedParams = namedParams, mimeType = mimeType, logger = logger)
       self$execute()
     }
   )
)