#' OWSRequest
#'
#' @docType class
#' @export
#' @keywords OGC OWS Request
#' @return Object of \code{\link{R6Class}} for modelling a generic OWS request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(op, type, url, request, user, pwd, namedParams, attrs, 
#'                  contentType, mimeType, logger)}}{
#'    This method is used to instantiate a object for doing an OWS request
#'  }
#'  \item{\code{getRequest()}}{
#'    Get the request payload
#'  }
#'  \item{\code{getRequestHeaders()}}{
#'    Get the request headers
#'  }
#'  \item{\code{getStatus()}}{
#'    Get the request status code
#'  }
#'  \item{\code{getResponse()}}{
#'    Get the request response
#'  }
#'  \item{\code{getException()}}{
#'    Get the exception (in case of request failure)
#'  }
#'  \item{\code{getResult()}}{
#'    Get the result \code{TRUE} if the request is successful, \code{FALSE} otherwise
#'  }
#' }
#' 
#' @note Abstract class used internally by \pkg{ows4R}
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
    requestHeaders = NA,
    namedParams = list(),
    contentType = "text/xml",
    mimeType = "text/xml",
    status = NA,
    response = NA,
    exception = NA,
    result = NA,
    
    user = NULL,
    pwd = NULL,
    token = NULL,
    auth_scheme = NULL,

    #GET
    #---------------------------------------------------------------
    GET = function(url, request, namedParams, mimeType){
      namedParams <- c(namedParams, request = request)
      params <- paste(names(namedParams), namedParams, sep = "=", collapse = "&")
      req <- url
      if(!endsWith(url,"?")) req <- paste0(req, "?")
      req <- paste0(req, params)
      self$INFO(sprintf("Fetching %s", req))
      
      #headers
      headers <- c()
      if(!is.null(private$token)){
        headers <- c(headers, "Authorization" = paste(private$auth_scheme, private$token))
      }
      
      r <- NULL
      if(self$verbose.debug){
        r <- with_verbose(GET(req, add_headers(headers)))
      }else{
        r <- GET(req, add_headers(headers))
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
      response <- list(request = request, requestHeaders = headers(r),
                       status = status_code(r), response = responseContent)
      return(response)
    },
    
    #POST
    #---------------------------------------------------------------    
    POST = function(url, contentType = "text/xml", mimeType = "text/xml"){
      
      #vendor params
      geometa_validate <- if(!is.null(private$namedParams$geometa_validate)) as.logical(private$namedParams$geometa_validate) else TRUE
      geometa_inspire <- if(!is.null(private$namedParams$geometa_inspire)) as.logical(private$namedParams$geometa_inspire) else FALSE
      
      #XML encoding
      outXML <- self$encode(
        geometa_validate = geometa_validate,
        geometa_inspire = geometa_inspire
      )
      
      #headers
      headers <- c("Accept" = "application/xml", "Content-Type" = contentType)
      if(!is.null(private$token)){
        headers <- c(headers, "Authorization" = paste(private$auth_scheme, private$token))
      }
      
      #send request
      if(self$verbose.debug){
        r <- with_verbose(httr::POST(
          url = url,
          add_headers(headers),    
          body = as(outXML, "character")
        ))
      }else{
        r <- httr::POST(
          url = url,
          add_headers(headers),    
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
      response <- list(request = outXML, requestHeaders = headers(r),
                       status = status_code(r), response = responseContent)
      return(response)
    }
  ),
  #public methods
  public = list(
    #initialize
    initialize = function(op, type, url, request,
                          user = NULL, pwd = NULL, token = NULL, 
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
      
      #authentication schemes
      if(!is.null(user) && !is.null(pwd)){
        #Basic authentication (user/pwd) scheme
        private$auth_scheme = "Basic"
        private$user = user
        private$pwd = pwd
        private$token = openssl::base64_encode(charToRaw(paste(user, pwd, sep=":")))
      }
      if(!is.null(token)){
        #Token/Bearer authentication
        private$auth_scheme = "Bearer"
        private$token = token
      }
        
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
      print(vendorParams)
      private$namedParams <- c(private$namedParams, vendorParams)
    },
    
    #execute
    execute = function(){
      
      req <- switch(private$type,
                    "GET" = private$GET(private$url, private$request, private$namedParams, private$mimeType),
                    "POST" = private$POST(private$url, private$contentType, private$mimeType)
      )
      
      private$request <- req$request
      private$requestHeaders <- req$requestHeaders
      private$status <- req$status
      private$response <- req$response
      
      if(private$type == "GET"){
        if(private$status != 200){
          private$exception <- sprintf("Error while executing request '%s'", req$request)
          self$ERROR(private$exception)
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
    
    #getRequestHeaders
    getRequestHeaders = function(){
      return(private$requestHeaders)
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