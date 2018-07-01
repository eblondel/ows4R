#' OWSRequest
#'
#' @docType class
#' @export
#' @keywords OGC OWS Request
#' @return Object of \code{\link{R6Class}} for modelling a generic OWS request
#' @format \code{\link{R6Class}} object.
#'
#' @field request
#' @field status
#' @field response
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, namedParams, mimeType)}}{
#'    This method is used to instantiate a object for doing an OWS request
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSRequest <- R6Class("OWSRequest",
  inherit = OGCAbstractObject,                    
  #private methods
  private = list(
    xmlElement = NULL,
    xmlNamespace = c(ows = "http://www.opengis.net/ows"),
    url = NA,
    type = NA,
    request = NA,
    namedParams = list(),
    contentType = "text/xml",
    mimeType = "text/xml",
    status = NA,
    response = NA,
    exception = NA,
    result = NA,
    
    #GET
    #---------------------------------------------------------------
    GET = function(url, request, namedParams, mimeType){
      namedParams <- c(namedParams, request = request)
      params <- paste(names(namedParams), namedParams, sep = "=", collapse = "&")
      req <- url
      if(!endsWith(url,"?")) req <- paste0(req, "?")
      req <- paste0(req, params)
      self$INFO(sprintf("Fetching %s", req))
      r <- NULL
      if(self$verbose.debug){
        r <- with_verbose(GET(req))
      }else{
        r <- GET(req)
      }
      responseContent <- NULL
      if(is.null(mimeType)){
        responseContent <- content(r, encoding = "UTF-8")
      }else{
        if(regexpr("xml",mimeType)>0){
          text <- content(r, type = "text", encoding = "UTF-8")
          text <- gsub("<!--.*?-->", "", text)
          responseContent <- xmlParse(text)
        }else{
          responseContent <- content(r, type = mimeType, encoding = "UTF-8")
        }
      }
      response <- list(request = request, status = status_code(r), response = responseContent)
      return(response)
    },
    
    #POST
    #---------------------------------------------------------------    
    POST = function(url, contentType = "text/xml", mimeType = "text/xml"){
      
      #XML encoding
      outXML <- self$encode()
      
      #send request
      if(self$verbose.debug){
        r <- with_verbose(httr::POST(
          url = url,
          add_headers(
            "Content-type" = contentType
          ),    
          body = as(outXML, "character")
        ))
      }else{
        r <- httr::POST(
          url = url,
          add_headers(
            "Content-type" = contentType
          ),    
          body = as(outXML, "character")
        )
      }
      
      responseContent <- NULL
      if(is.null(mimeType)){
        responseContent <- content(r, encoding = "UTF-8")
      }else{
        if(regexpr("xml",mimeType)>0){
          text <- content(r, type = "text", encoding = "UTF-8")
          text <- gsub("<!--.*?-->", "", text)
          responseContent <- xmlParse(text)
        }else{
          responseContent <- content(r, type = mimeType, encoding = "UTF-8")
        }
      }
      response <- list(request = outXML, status = status_code(r), response = responseContent)
      return(response)
    }
  ),
  #public methods
  public = list(
    #initialize
    initialize = function(op, type, url, request,
                          namedParams = NULL, attrs = NULL,
                          contentType = "text/xml", mimeType = "text/xml",
                          logger = NULL, ...) {
      super$initialize(logger = logger)
      private$type = type
      private$url = url
      private$request = request
      private$namedParams = namedParams
      private$contentType = contentType
      private$mimeType = mimeType
      
      vendorParams <- list(...)
      #if(!is.null(op)){
      #  for(param in names(vendorParams)){
      #    if(!(param %in% names(op$getParameters()))){
      #      errorMsg <- sprintf("Parameter '%s' is not among allowed parameters [%s]",
      #                          param, paste(paste0("'",names(op$getParameters()),"'"), collapse=","))
      #      self$ERROR(errorMsg)
      #      stop(errorMsg)
      #    }
      #    value <- vendorParams[[param]]
      #    paramAllowedValues <- op$getParameter(param)
      #    if(!(value %in% paramAllowedValues)){
      #      errorMsg <- sprintf("'%s' parameter value '%s' is not among allowed values [%s]",
      #                          param, value, paste(paste0("'",paramAllowedValues,"'"), collapse=","))
      #      self$ERROR(errorMsg)
      #      stop(errorMsg)
      #    }
      #  }
      #}
      vendorParams <- vendorParams[!sapply(vendorParams, is.null)]
      vendorParams <- lapply(vendorParams, curl::curl_escape)
      namedParams <- c(namedParams, vendorParams)
    },
    
    #execute
    execute = function(){
      
      req <- switch(private$type,
                    "GET" = private$GET(private$url, private$request, private$namedParams, private$mimeType),
                    "POST" = private$POST(private$url, private$contentType, private$mimeType)
      )
      
      private$request <- req$request
      private$status <- req$status
      private$response <- req$response
      
      if(private$type == "GET"){
        if(private$status != 200){
          private$exception <- sprintf("Error while executing request '%s'", req$request)
        }
      }
      if(private$type == "POST"){
        if(!is.null(xmlNamespaces(req$response)$ows)){
          exception <- getNodeSet(req$response, "//ows:ExceptionText", c(ows = xmlNamespaces(req$response)$ows$uri))
          if(length(exception)>0){
            exception <- exception[[1]]
            private$exception <- xmlValue(exception)
            self$ERROR(private$exception)
          }
        }
      }
    },
    
    #getRequest
    getRequest = function(){
      return(private$request)
    },
    
    #getStatus
    getStatus = function(){
      return(private$status)
    },
    
    #getResponse
    getResponse = function(){
      return(private$response)
    },
    
    #getException
    getException = function(){
      return(private$exception)
    },
    
    #getResult
    getResult = function(){
      return(private$result)
    },
    
    #setResult
    setResult = function(result){
      private$result = result
    }
    
  )
)