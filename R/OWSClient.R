#' OWSClient
#'
#' @docType class
#' @import methods
#' @importFrom R6 R6Class
#' @import httr
#' @import openssl
#' @import XML
#' @import sf
#' @import rgdal
#' @import geometa
#' @import parallel
#' @export
#' @keywords OGC Common OWS
#' @return Object of \code{\link{R6Class}} with methods for interfacing
#' a Common OGC web-service.
#' @format \code{\link{R6Class}} object.
#'
#' @field url the Base url of OWS service
#' @field version the version of OWS service
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, service, serviceVersion, user, pwd, logger)}}{
#'    This method is used to instantiate a OWSClient with the \code{url} of the
#'    OGC service. Authentication is supported using basic auth (using \code{user}/\code{pwd} arguments), 
#'    bearer token (using \code{token} argument), or custom (using \code{headers} argument). 
#'    By default, the \code{logger} argument will be set to \code{NULL} (no logger). This argument accepts two possible 
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
#'  \item{\code{getUser()}}{
#'    Get user
#'  }
#'  \item{\code{getPwd()}}{
#'    Get password
#'  }
#'  \ìtem{\code{getToken()}}{
#'    Get token
#'  }
#'  \item{\code{getHeaders()}}{
#'    Get headers
#'  }
#' }
#' 
#' @note Abstract class used internally by \pkg{ows4R}
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
    pwd = NULL,
    token = NULL,
    headers = list()
  ),

  public = list(

    #fields
    url = NA,
    version = NA,
    capabilities = NA,
    
    #initialize
    initialize = function(url, service, serviceVersion,
                          user = NULL, pwd = NULL, token = NULL, headers = c(),
                          logger = NULL) {
      
      #logger
      super$initialize(logger = logger)
       
      #fields
      if (!missing(url)) self$url <- url
      if (!missing(serviceVersion)) self$version <- serviceVersion
      
      #authentication
      private$user <- user
      private$pwd <- pwd
      private$token <- token
      private$headers <- headers
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
    },
    
    #getToken
    getToken = function(){
      return(private$token)
    },
    
    #getHeaders
    getHeaders = function(){
      return(private$headers)
    }
    
  )
)

