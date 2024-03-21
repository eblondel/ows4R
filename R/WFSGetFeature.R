#' WFSGetFeature
#'
#' @docType class
#' @export
#' @keywords OGC WFS GetFeature
#' @return Object of \code{\link{R6Class}} for modelling a WFS GetFeature request
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a WFS GetFeature request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSGetFeature <- R6Class("WFSGetFeature",
  inherit = OWSHttpRequest,
  private = list(
     xmlElement = "GetFeature",
     xmlNamespacePrefix = "WFS"
  ), 
  public = list(
    
    #'@description Initializes a \link{WFSGetFeature} service request
    #'@param capabilities an object of class \link{WFSCapabilities}
    #'@param op object of class \link{OWSOperation} as retrieved from capabilities
    #'@param url url
    #'@param version service version
    #'@param typeName typeName
    #'@param outputFormat output format
    #'@param user user
    #'@param pwd password
    #'@param token token
    #'@param headers headers
    #'@param config config
    #'@param logger logger
    #'@param ... any parameter to pass to the service request
     initialize = function(capabilities, op, url, version, typeName, outputFormat = NULL,
                           user = NULL, pwd = NULL, token = NULL, headers = c(), config = httr::config(),
                           logger = NULL, ...) {
       
       if(is.null(outputFormat)){
         mimeType <- "text/xml"
       }else{
         mimeType <- switch(tolower(outputFormat),
           "application/json" = "text",
           "json" = "text", #for backward compatibility
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
       vendorParamNames <- names(vendorParams)
       vendorParams <- lapply(vendorParamNames, function(param){
         out <- vendorParams[[param]]
         param <- tolower(param)
         if(param == "cql_filter"){
           out <- URLencode(out)
         }else if(param == "filter"){
           if(is(out, "OGCFilter")){
             out <- URLencode(as(out$encode(), "character"))
           }
         }
         return(out)
       })
       names(vendorParams) <- vendorParamNames
       
       if(length(vendorParams)>0) namedParams <- c(namedParams, vendorParams)
       namedParams <- namedParams[!sapply(namedParams, is.null)]
       super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix,
                        capabilities, op, "GET", url, request = "GetFeature",
                        user = user, pwd = pwd, token = token, headers = headers, config = config,
                        namedParams = namedParams, mimeType = mimeType, skipXmlComments = FALSE, logger = logger)
       self$execute()
     }
   )
)