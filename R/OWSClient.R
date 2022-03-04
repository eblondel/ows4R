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
#' @import raster
#' @import geometa
#' @import keyring
#' @import parallel
#' @export
#' @keywords OGC Common OWS
#' @return Object of \code{\link{R6Class}} with methods for interfacing a Common OGC web-service.
#' @format \code{\link{R6Class}} object.
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
    headers = list(),
    cas_url = NULL
  ),

  public = list(
    #'@field url Base url of the OWS service
    url = NA,
    #'@field version version of the OWS service
    version = NA,
    #'@field capabilities object giving the OWS service capabilities
    capabilities = NA,
    
    #'@description This method is used to instantiate a OWSClient with the \code{url} of the
    #'    OGC service. Authentication is supported using basic auth (using \code{user}/\code{pwd} arguments), 
    #'    bearer token (using \code{token} argument), or custom (using \code{headers} argument). 
    #'    By default, the \code{logger} argument will be set to \code{NULL} (no logger). This argument accepts two possible 
    #'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
    #'@param url url
    #'@param service service name
    #'@param serviceVersion CSW service version
    #'@param user user
    #'@param pwd password
    #'@param token token
    #'@param headers headers
    #'@param cas_url Central Authentication Service (CAS) URL
    #'@param logger logger
    initialize = function(url, service, serviceVersion,
                          user = NULL, pwd = NULL, token = NULL, headers = c(), cas_url = NULL,
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
      private$cas_url <- cas_url
      
      #CAS authentication
      if(!is.null(cas_url)){
        cas <- CASClient$new(url = cas_url)
        cas_logged_in <- cas$login(user = user, pwd = pwd)
        if(cas_logged_in){
          self$INFO(sprintf("User '%s' successfully logged in through CAS endpoint '%s'", user, cas_url))
          self$url <- paste0(cas_url, "?service=", URLencode(self$url, reserved = TRUE))
        }else{
          self$WARNsprintf("Error during CAS login, check your user/password!")
        }
      }
    },
     
    #'@description Get URL
    #'@return the url of the service, object of class \code{character}
    getUrl = function(){
      return(self$url)
    },
    
    #'@description Get version
    #'@return the version of the service, object of class \code{character}
    getVersion = function(){
      return(self$version)
    },

    #'@description Get capabilities
    #'@return the capabilities, object of class \link{OWSCapabilities}     
    getCapabilities = function() {
      return(self$capabilities)
    },
    
    #'@description Get user
    #'@return the user, object of class \code{character}
    getUser = function(){
      return(private$user)
    },
    
    #'@description Get password
    #'@return the password, object of class \code{character}
    getPwd = function(){
      return(private$pwd)
    },
    
    #'@description Get token
    #'@return the token, object of class \code{character}
    getToken = function(){
      return(private$token)
    },
    
    #'@description Get headers
    #'@return the headers, object of class \code{character}
    getHeaders = function(){
      return(private$headers)
    },
    
    #'@description Get CAS URL
    #'@return a CAS URL
    getCASUrl = function(){
      return(private$cas_url)
    }
    
  )
)

