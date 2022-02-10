#' WPSParameter
#'
#' @docType class
#' @export
#' @keywords OGC WPS Parameter
#' @return Object of \code{\link{R6Class}} modelling a WPS parameter
#' @format \code{\link{R6Class}} object.
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
     fetchParameter = function(xml, version){
       
       children <- xmlChildren(xml)
       
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
      
     #'@description Initializes an object of class \link{WPSParameter}
     #'@param xml an object of class \link{XMLInternalNode-class} to initialize from XML
     #'@param version WPS service version
     #'@param logger logger
     #'@param ... any additional parameter
     initialize = function(xml = NULL, version, logger = NULL, ...){
       super$initialize(logger = logger)
       private$version = version
       if(!is.null(xml)){
         processInput = private$fetchParameter(xml, version)
         private$identifier = processInput$identifier
         private$title = processInput$title
         private$abstract = processInput$abstract
       }
     },
     
     #'@description Get identifier
     #'@return object of class \code{character}
     getIdentifier = function(){
       return(private$identifier)
     },
     
     #'@description Get title
     #'@return object of class \code{character}
     getTitle = function(){
       return(private$title)
     },
     
     #'@description Get abstract
     #'@return object of class \code{character}
     getAbstract = function(){
       return(private$abstract)
     }
     
   )
)