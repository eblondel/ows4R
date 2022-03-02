#' WPSDescribeProcess
#'
#' @docType class
#' @export
#' @keywords OGC WPS DescribeProcess
#' @return Object of \code{\link{R6Class}} for modelling a WPS DescribeProcess request
#' @format \code{\link{R6Class}} object.
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WPS DescribeProcess request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSDescribeProcess <- R6Class("WPSDescribeProcess",
  inherit = OWSHttpRequest,
  private = list(
    xmlElement = "DescribeProcess",
    xmlNamespacePrefix = "WPS"
  ),
  public = list(
    
    #'@description  Initializes a \link{WPSDescribeProcess} service request
    #'@param capabilities object of class \link{WPSCapabilities}
    #'@param op object of class \link{OWSOperation}
    #'@param url url
    #'@param serviceVersion WPS service version
    #'@param identifier process identifier
    #'@param user user
    #'@param pwd password
    #'@param token token
    #'@param headers headers
    #'@param logger logger
    #'@param ... any other parameter to pass to the request
    initialize = function(capabilities, op, url, serviceVersion, identifier, 
                          user = NULL, pwd = NULL, token = NULL, headers = c(),
                          logger = NULL, ...) {
      namedParams <- list(service = "WPS", version = serviceVersion, identifier = identifier)
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix,
                       capabilities, op, "GET", url, request = "DescribeProcess",
                       user = user, pwd = pwd, token = token, headers = headers,
                       namedParams = namedParams, mimeType = "text/xml", logger = logger,
                       ...)
      self$execute()
    }
  )
)