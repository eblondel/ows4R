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
  inherit = OWSLogger,                    
  #private methods
  private = list(
    #GET
    GET = function(url, namedParams, mimeType){
      params <- paste(names(namedParams), namedParams, sep = "=", collapse = "&")
      request <- paste(url, "&", params, sep = "")
      self$INFO(sprintf("Fetching %s", request))
      r <- NULL
      if(self$verbose.debug){
        r <- with_verbose(GET(request))
      }else{
        r <- GET(request)
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
    POST = function(url, namedParams, namedAttrs, namespace,
                    contentType = "text/xml", mimeType = "text/xml"){
      
      #Prepare request
      requestName <- namedParams$request
      namedParams <- namedParams[names(namedParams) != "request"]
      rootXML <- xmlOutputDOM(
        tag = requestName,
        nameSpace = names(namespace),
        nsURI = namespace,
        attrs = namedAttrs
      )
      for(param in names(namedParams)){
        wrapperNode <- xmlOutputDOM(tag = param, nameSpace = names(namespace))
        content <- namedParams[[param]]
        if(is(content, "XMLInternalDocument")){
          content <- as(content, "character")
          content <- gsub("<\\?xml.*?\\?>", "", content)
          content <- gsub("<!--.*?-->", "", content)
          content <- xmlRoot(xmlParse(content, encoding = "UTF-8"))
        }else{
          content <- xmlTextNode(as(content,"character"))
        }
        wrapperNode$addNode(content)
        rootXML$addNode(wrapperNode$value())
      }
      outXML <- rootXML$value()
      outXML <- as(outXML, "XMLInternalNode")
      if(length(namedAttrs)>0){
        suppressWarnings(xmlAttrs(outXML) <- namedAttrs)
      }
      outbuf <- xmlOutputBuffer("")
      outbuf$add(as(outXML, "character"))
      outXML <- xmlParse(outbuf$value(), encoding = "UTF-8")
      
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
    request = NA,
    status = NA,
    response = NA,
    #initialize
    initialize = function(op, type, url, namedParams, namedAttrs = NULL, namespace = NULL,
                          contentType = "text/xml", mimeType = "text/xml",
                          logger = NULL, ...) {
      super$initialize(logger = logger)
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
      
      req <- switch(type,
        "GET" = private$GET(url, namedParams, mimeType),
        "POST" = private$POST(url, namedParams, namedAttrs, namespace, contentType, mimeType)
      )
      self$request <- req$request
      self$status <- req$status
      self$response <- req$response
    }
  )
)