#' OWSHttpRequest
#'
#' @docType class
#' @export
#' @keywords OGC OWS HTTP Request
#' @return Object of \code{\link{R6Class}} for modelling a generic OWS http request
#' @format \code{\link{R6Class}} object.
#' 
#' @note Abstract class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSHttpRequest <- R6Class("OWSHttpRequest",
  inherit = OGCAbstractObject,                    
  #private methods
  private = list(
    xmlElement = NULL,
    xmlNamespacePrefix = NULL,
    capabilities = NULL,
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
    headers = c(),
    auth_scheme = NULL,

    #GET
    #---------------------------------------------------------------
    GET = function(url, request, namedParams, mimeType){
      namedParams <- c(namedParams, request = request)
      params <- paste(names(namedParams), namedParams, sep = "=", collapse = "&")
      req <- url
      if(!endsWith(url,"?") && nzchar(params)) req <- paste0(req, "?")
      req <- paste0(req, params)
      self$INFO(sprintf("Fetching %s", req))
      
      #headers
      headers <- private$headers
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
          responseContent <- content(r, type = "text", encoding = "UTF-8")
        }
      }
      response <- list(request = request, requestHeaders = httr::headers(r),
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
      headers <- c(private$headers, "Accept" = "application/xml", "Content-Type" = contentType)
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
    
    #'@description Initializes an OWS HTTP request
    #'@param element element
    #'@param namespacePrefix namespace prefix
    #'@param capabilities object of class or extending \link{OWSCapabilities}
    #'@param op object of class \link{OWSOperation}
    #'@param type type of request, eg. GET, POST
    #'@param url url
    #'@param request request name
    #'@param user user
    #'@param pwd password
    #'@param token token
    #'@param headers headers
    #'@param namedParams a named \code{list}
    #'@param attrs attributes
    #'@param contentType content type. Default value is "text/xml"
    #'@param mimeType mime type. Default value is "text/xml"
    #'@param logger logger
    #'@param ... any other parameter
    initialize = function(element, namespacePrefix,
                          capabilities, op, type, url, request,
                          user = NULL, pwd = NULL, token = NULL, headers = c(), 
                          namedParams = NULL, attrs = NULL,
                          contentType = "text/xml", mimeType = "text/xml",
                          logger = NULL, ...) {
      super$initialize(element = element, namespacePrefix = namespacePrefix, logger = logger)
      private$capabilities = capabilities
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
      private$headers = headers
        
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
      private$namedParams <- c(private$namedParams, vendorParams)
    },
    
    #'@description Executes the request
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
    
    #'@description Get capabilities
    #'@return an object of class or extending \link{OWSCapabilities}
    getCapabilities = function(){
      return(private$capabilities)
    },
    
    #'@description Get request
    #'@return the request
    getRequest = function(){
      return(private$request)
    },
    
    #'@description Get request headers
    #'@return the request headers
    getRequestHeaders = function(){
      return(private$requestHeaders)
    },
    
    #'@description get status code
    #'@return the request status code
    getStatus = function(){
      return(private$status)
    },
    
    #'@description get request response
    #'@return the request response
    getResponse = function(){
      return(private$response)
    },
    
    #'@description get request exception
    #'@return the request exception
    getException = function(){
      return(private$exception)
    },
    
    #'@description Get the result \code{TRUE} if the request is successful, \code{FALSE} otherwise
    #'@return the result, object of class \code{logical}
    getResult = function(){
      return(private$result)
    },
    
    #'@description Set the result
    #'@param result object of class \code{logical}
    setResult = function(result){
      private$result = result
    }
    
  )
)