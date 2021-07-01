#' WPSParameter
#'
#' @docType class
#' @export
#' @keywords OGC WPS Parameter
#' @return Object of \code{\link{R6Class}} modelling a WPS parameter
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, version, logger)}}{
#'    This method is used to instantiate a \code{WPSParameter} object
#'  }
#'  \item{\code{getIdentifier()}}{
#'    Get input identifier
#'  }
#'  \item{\code{getTitle()}}{
#'    Get input title
#'  }
#'  \item{\code{getAbstract()}}{
#'    Get input abstract
#'  }
#' }
#' 
#' @note Abstract class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSParameter <- R6Class("WPSParameter",
   inherit = OGCAbstractObject,                       
   private = list(
     version = NA,
     identifier = NA,
     title = NA,
     abstract= NA,
    
     #fetchParameter
     fetchParameter = function(xmlObj, version){
       
       children <- xmlChildren(xmlObj)
       
       processIdentifier <- NULL
       if(!is.null(children$Identifier)){
         processIdentifier <- xmlValue(children$Identifier)
       }
       
       processTitle <- NULL
       if(!is.null(children$Title)){
         processTitle <- xmlValue(children$Title)
       }
       
       processAbstract <- NULL
       if(!is.null(children$Abstract)){
         processAbstract <- xmlValue(children$Abstract)
       }
       
       processInput <- list(
         identifier = processIdentifier,
         title = processTitle,
         abstract = processAbstract
       )
       
       return(processInput)
     }
     
   ),
   public = list(
     initialize = function(xmlObj = NULL, version, logger = NULL, ...){
       super$initialize(logger = logger)
       private$version = version
       if(!is.null(xmlObj)){
         processInput = private$fetchParameter(xmlObj, version)
         private$identifier = processInput$identifier
         private$title = processInput$title
         private$abstract = processInput$abstract
       }
     },
     
     #getIdentifier
     getIdentifier = function(){
       return(private$identifier)
     },
     
     #getTitle
     getTitle = function(){
       return(private$title)
     },
     
     #getAbstract
     getAbstract = function(){
       return(private$abstract)
     }
     
   )
)