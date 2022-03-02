#' WFSDescribeFeatureType
#'
#' @docType class
#' @export
#' @keywords OGC WFS DescribeFeatureType
#' @return Object of \code{\link{R6Class}} for modelling a WFS DescribeFeatureType request
#' @format \code{\link{R6Class}} object.
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WFS DescribeFeatureType request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WFSDescribeFeatureType <- R6Class("WFSDescribeFeatureType",
  inherit = OWSHttpRequest,
  private = list(
    xmlElement = "DescribeFeatureType",
    xmlNamespacePrefix = "WFS"
  ),
  public = list(
 
    #'@description Initializes a \link{WFSDescribeFeatureType} service request
    #'@param capabilities an object of class \link{WFSCapabilities}
    #'@param op object of class \link{OWSOperation} as retrieved from capabilities
    #'@param url url
    #'@param version service version
    #'@param typeName typeName
    #'@param user user
    #'@param pwd pwd
    #'@param token token
    #'@param headers headers
    #'@param logger logger
    #'@param ... any parameter to pass to the service request
    initialize = function(capabilities, op, url, version, typeName, 
                          user = NULL, pwd = NULL, token = NULL, headers = c(),
                          logger = NULL, ...) {
      namedParams <- list(service = "WFS", version = version, typeName = typeName)
      super$initialize(element = private$xmlElement, namespacePrefix = private$namespacePrefix,
                       capabilities, op, "GET", url, request = "DescribeFeatureType",
                       user = user, pwd = pwd, token = token, headers = headers,
                       namedParams = namedParams, mimeType = "text/xml", logger = logger,
                       ...)
      self$execute()
    }
  )
)