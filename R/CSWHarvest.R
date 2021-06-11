#' CSWHarvest
#'
#' @docType class
#' @export
#' @keywords OGC CSW Harvest
#' @return Object of \code{\link{R6Class}} for modelling a CSW Harvest request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(op, url, serviceVersion, user, pwd, source, resourceType, resourceFormat, logger, ...)}}{
#'    This method is used to instantiate a CSWHarvest object
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R} to trigger a CSW Harvest request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
CSWHarvest <- R6Class("CSWHarvest",
   inherit = OWSHttpRequest,
   private = list(
     xmlElement = "Harvest",
     xmlNamespace = c(csw = "http://www.opengis.net/cat/csw"),
     defaultAttrs = list(
       service = "CSW",
       version = "2.0.2"
     )
   ),
   public = list(
     Source = NULL,
     ResourceType = "http://www.isotc211.org/2005/gmd",
     ResourceFormat = "application/xml",
     initialize = function(op, url, serviceVersion = "2.0.2", 
                           user = NULL, pwd = NULL, token = NULL,
                           source = NULL,
                           resourceType = "http://www.isotc211.org/schemas/2005/gmd/",
                           resourceFormat = "application/xml",
                           logger = NULL, ...) {
       super$initialize(op, "POST", url, request = private$xmlElement,
                        user = user, pwd = pwd, token = token,
                        contentType = "text/xml", mimeType = "text/xml",
                        logger = logger, ...)
       nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
       private$xmlNamespace = paste(private$xmlNamespace, nsVersion, sep="/")
       names(private$xmlNamespace) <- ifelse(serviceVersion=="3.0.0", "csw30", "csw")
       
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