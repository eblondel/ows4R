#' OWSClient
#'
#' @docType class
#' @importFrom R6 R6Class
#' @import httr
#' @import openssl
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
#'    OWSClient$new("http://localhost:8080/geoserver/ows", serviceVersion = "1.1.0")
#' }
#'
#' @field url the Base url of OWS service
#' @field version the version of OWS service
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, service, serviceVersion, user, pwd, logger)}}{
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
  inherit = OGCAbstractObject,               
  lock_objects = FALSE,
             
  #TODO for support of transactional operations
  #TODO provider specific formatter to prevent these fields to be printable
  private = list(
    user = NULL,
    pwd = NULL
  ),

  public = list(

    #fields
    url = NA,
    version = NA,
    capabilities = NA,
    
    #initialize
    initialize = function(url, service, serviceVersion,
                          user = NULL, pwd = NULL,
                          logger = NULL) {
      
      #logger
      super$initialize(logger = logger)
       
      #fields
      if (!missing(url)) self$url <- url
      if (!missing(serviceVersion)) self$version <- serviceVersion
      
      #authentication
      private$user <- user
      private$pwd <- pwd
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
    },
    
    #getUser
    getUser = function(){
      return(private$user)
    },
    
    #getPwd
    getPwd = function(){
      return(private$pwd)
    }
    
  )
)

