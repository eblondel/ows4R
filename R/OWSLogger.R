#' OWSLogger
#'
#' @docType class
#' @importFrom R6 R6Class
#' @return Object of \code{\link{R6Class}} to provide logs to \pkg{ows4R}
#' @format \code{\link{R6Class}} object.
#' 
#' @note Internal class only.
#'
#' @field loggerType the type of logger
#' @field verbose.info if basic logs have to be printed
#' @field verbose.debug if verbose logs have to be printed
#'
#' @section Methods:
#' \describe{
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
#'  \item{\code{getClassName()}}{
#'    Retrieves the name of the class instance
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OWSLogger <- R6Class("OWSLogger",
   public = list(
     #logger
     verbose.info = FALSE,
     verbose.debug = FALSE,
     loggerType = NULL,
     logger = function(type, text){
       if(self$verbose.info){
         cat(sprintf("[ows4R][%s] %s - %s \n", type, self$getClassName(), text))
       }
     },
     INFO = function(text){self$logger("INFO", text)},
     WARN = function(text){self$logger("WARN", text)},
     ERROR = function(text){self$logger("ERROR", text)},

     #initialize
     initialize = function(logger = NULL) {
       
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
     },
    
     #getClassName
     getClassName = function(){
       return(class(self)[1])
     }
   )
)

