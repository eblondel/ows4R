#' OWSClient
#'
#' @docType class
#' @importFrom R6 R6Class
#' @import httr
#' @import XML
#' @import sf
#' @import rgdal
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
#' @field loggerType the type of logger
#' @field verbose.info if basic logs have to be printed
#' @field verbose.debug if verbose logs have to be printed
#' @field url the Base url of OWS service
#' @field version the version of OWS service
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, version, user, pwd, logger)}}{
#'    This method is used to instantiate a OWSClient with the \code{url} of the
#'    OGC service. Authentication (\code{user}/\code{pwd}) is not yet supported and will
#'    be added with the support of service transactional modes. By default, the \code{logger}
#'    argument will be set to \code{NULL} (no logger). This argument accepts two possible 
#'    values: \code{INFO}: to print only \pkg{ows4R} logs, \code{DEBUG}: to print more verbose logs
#'  }
#'  \item{\code{logger(type, text)}}{
#'    Basic logger to report logs. Used internally
#'  }
#'  \item{\code{INFO(text)}}{
#'    Logger to report information. Used internally
#'  }
#'  \item{\code{WARN(text)}}{
#'    Logger to report warnings. Used internally
#'  }
#'  \item{\code{ERROR(text)}}{
#'    Logger to report errors. Used internally
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
#'  \item{\code{getClassName()}}{
#'    Retrieves the name of the class instance
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OWSClient <- R6Class("OWSClient",
                     
  lock_objects = FALSE,
             
  #TODO for support of transactional operations
  #TODO provider specific formatter to prevent these fields to be printable
  private = list(
    user = NA,
    pwd = NA
  ),

  public = list(
    #logger
    verbose.info = FALSE,
    verbose.debug = FALSE,
    loggerType = NULL,
    logger = function(type, text){
      if(self$verbose.info){
        cat(sprintf("[ows4R][%s] %s \n", type, text))
      }
    },
    INFO = function(text){self$logger("INFO", text)},
    WARN = function(text){self$logger("WARN", text)},
    ERROR = function(text){self$logger("ERROR", text)},

    #fields
    url = NA,
    version = NA,
    capabilities = NA,
    
    #initialize
    initialize = function(url, version, user = NULL, pwd = NULL, logger = NULL) {
      
      #logger
      if(!missing(logger)){
        if(!is.null(logger)){
          self$loggerType <- toupper(logger)
          if(!(self$loggerType %in% c("INFO","DEBUG"))){
            stop(sprintf("Unknown logger type '%s", logger))
          }
          if(self$loggerType == "INFO"){
            self$verbose.info = TRUE
          }else if(self$loggerType == "DEBUG"){
            self$verbose.info = TRUE
            self$verbose.debug = TRUE
          }
        }
      }
       
      #fields
      if (!missing(url)) self$url <- url
      if (substring(self$url, nchar(self$url)) != "?"){
        self$url <- paste(self$url, "?", sep = "")
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
    },
    
    #getClassName
    getClassName = function(){
      return(class(self)[1])
    }
  )
)

