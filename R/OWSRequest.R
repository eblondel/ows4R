#' @export
OWSRequest <- R6Class("OWSRequest",
  #private methods
  private = list(
    #buildRequest
    buildRequest = function(baseUrl, namedParams, mimeType){
      params <- paste(names(namedParams), namedParams, sep = "=", collapse = "&")
      request <- paste(baseUrl, "&", params, sep = "")
      message("Fetching ", request)
      r <- GET(request)
      responseContent <- NULL
      if(is.null(mimeType)){
        responseContent <- content(r)
      }else{
        if(regexpr("xml",mimeType)>0){
          responseContent <- xmlParse(content(r, type = "text"))
        }else{
          responseContent <- content(r, type = mimeType)
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
    initialize = function(baseUrl, namedParams, mimeType = "text/xml") {
      req <- private$buildRequest(baseUrl, namedParams, mimeType)
      self$request <- req$request
      self$status <- req$status
      self$response <- req$response
    }
  ),
  
)