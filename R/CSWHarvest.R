#' CSWHarvest
#'
#' @docType class
#' @export
#' @keywords OGC CSW Harvest
#' @return Object of \code{\link{R6Class}} for modelling a CSW Harvest request
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a CSW Harvest request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWHarvest <- R6Class("CSWHarvest",
   inherit = OWSHttpRequest,
   private = list(
     xmlElement = "Harvest",
     xmlNamespacePrefix = "CSW",
     defaultAttrs = list(
       service = "CSW",
       version = "2.0.2"
     )
   ),
   public = list(
     #'@field Source source property for request XML encoding
     Source = NULL,
     #'@field ResourceType resource type property for request XML encoding
     ResourceType = "http://www.isotc211.org/2005/gmd",
     #'@field ResourceFormat resource format property for request XML encoding
     ResourceFormat = "application/xml",
     
     #'@description Initializes a \link{CSWHarvest} service request
     #'@param capabilities an object of class \link{CSWCapabilities}
     #'@param op object of class \link{OWSOperation} as retrieved from capabilities
     #'@param url url
     #'@param serviceVersion serviceVersion. Default is "2.0.2
     #'@param user user
     #'@param pwd password
     #'@param token token
     #'@param headers headers
     #'@param source source
     #'@param resourceType resource type. Default is "http://www.isotc211.org/schemas/2005/gmd/"
     #'@param resourceFormat resource format. Default is "application/xml"
     #'@param logger logger
     #'@param ... any parameter to pass to the service request
     initialize = function(capabilities, op, url, serviceVersion = "2.0.2", 
                           user = NULL, pwd = NULL, token = NULL, headers = list(),
                           source = NULL,
                           resourceType = "http://www.isotc211.org/schemas/2005/gmd/",
                           resourceFormat = "application/xml",
                           logger = NULL, ...) {
       nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
       private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", nsVersion), sep="_")
       super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
                        capabilities, op, "POST", url, request = private$xmlElement,
                        user = user, pwd = pwd, token = token, headers = headers,
                        contentType = "text/xml", mimeType = "text/xml",
                        logger = logger, ...)
       
       self$attrs <- private$defaultAttrs
       
       #version
       self$attrs$version = serviceVersion
       
       #fields
       self$Source = source
       self$ResourceType = resourceType
       self$ResourceFormat = resourceFormat
       
       #execute
       self$execute()
       
       return(private$response)
     }
   )
)