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
  #private methods
  private = list(
    #buildRequest
    buildRequest = function(url, namedParams, mimeType){
      params <- paste(names(namedParams), namedParams, sep = "=", collapse = "&")
      request <- paste(url, "&", params, sep = "")
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
    initialize = function(url, namedParams, mimeType = "text/xml") {
      req <- private$buildRequest(url, namedParams, mimeType)
      self$request <- req$request
      self$status <- req$status
      self$response <- req$response
    }
  ),
  
)