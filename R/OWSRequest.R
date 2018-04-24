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
    #buildRequest
    buildRequest = function(url, namedParams, mimeType){
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
    }
  ),
  #public methods
  public = list(
    request = NA,
    status = NA,
    response = NA,
    #initialize
    initialize = function(op, url, namedParams, mimeType = "text/xml", logger = NULL, ...) {
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
      namedParams <- c(namedParams, vendorParams)
      req <- private$buildRequest(url, namedParams, mimeType)
      self$request <- req$request
      self$status <- req$status
      self$response <- req$response
    }
  )
)