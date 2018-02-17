#' OWSClient
#'
#' @docType class
#' @importFrom R6 R6Class
#' @import httr
#' @import XML
#' @import sf
#' @import rgdal
#' @import geometa
#' @export
#' @keywords OGC Common OWS
#' @return Object of \code{\link{R6Class}} with methods for interfacing
#' a Common OGC web-service.
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#' \dontrun{
#'    OWSClient$new("http://localhost:8080/geoserver/ows", version = "1.1.0")
#' }
#'
#' @field url the Base url of OWS service
#' @field version the version of OWS service
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, service, version, user, pwd, logger)}}{
#'    This method is used to instantiate a OWSClient with the \code{url} of the
#'    OGC service. Authentication (\code{user}/\code{pwd}) is not yet supported and will
#'    be added with the support of service transactional modes. By default, the \code{logger}
#'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
#'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
#'  }
#'  \item{\code{getUrl()}}{
#'    Get the service URL
#'  }
#'  \item{\code{getVersion()}}{
#'    Get the service version
#'  }
#'  \item{\code{getCapabilities()}}{
#'    Get the service capabilities
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OWSClient <- R6Class("OWSClient",
  inherit = OWSLogger,               
  lock_objects = FALSE,
             
  #TODO for support of transactional operations
  #TODO provider specific formatter to prevent these fields to be printable
  private = list(
    user = NA,
    pwd = NA
  ),

  public = list(

    #fields
    url = NA,
    version = NA,
    capabilities = NA,
    
    #initialize
    initialize = function(url, service = NULL, version,
                          user = NULL, pwd = NULL,
                          logger = NULL) {
      
      #logger
      super$initialize(logger = logger)
       
      #fields
      if (!missing(url)) self$url <- url
      if (substring(self$url, nchar(self$url)) != "?"){
        self$url <- paste(self$url, "?", sep = "")
      }
      if(!is.null(service)){
        if(any(attr(regexpr(tolower(service), self$url),"match.length") == -1,
               attr(regexpr(service, self$url), "match.length") == -1)){
          self$url <- paste(self$url, "service=", service, sep = "")
        }
      }
      if (!missing(version)) self$version <- version
    },
     
    #getUrl
    getUrl = function(){
      return(self$url)
    },
    
    #getVersion
    getVersion = function(){
      return(self$version)
    },

    #getCapabilities     
    getCapabilities = function() {
      return(self$capabilities)
    }
  )
)

