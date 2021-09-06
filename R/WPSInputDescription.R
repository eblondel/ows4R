#' WPSInputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process input description
#' @return Object of \code{\link{R6Class}} modelling a WPS process input description
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, capabilities, version, logger)}}{
#'    This method is used to instantiate a \code{WPSInputDescription} object
#'  }
#'  \item{\code{getMinOccurs()}}{
#'    Get input min occurs
#'  }
#'  \item{\code{getMaxOccurs()}}{
#'    Get input max occurs
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSInputDescription <- R6Class("WPSInputDescription",
   inherit = WPSDescriptionParameter,                       
   private = list(
     minOccurs = NA,
     maxOccurs = NA,
     
     #fetchInputDescription
     fetchInputDescription = function(xml, version){
       
       inputDescription <- list(
         minOccurs = xmlGetAttr(xml, "minOccurs"),
         maxOccurs = xmlGetAttr(xml, "maxOccurs")
       )
       
       return(inputDescription)
     }
     
   ),
   public = list(
     initialize = function(xml = NULL, version, logger = NULL, ...){
       super$initialize(xml = xml, version = version, logger = logger, ...)
       private$version = version
       if(!is.null(xml)){
          inputDescription = private$fetchInputDescription(xml, version)
          private$minOccurs = inputDescription$minOccurs
          private$maxOccurs = inputDescription$maxOccurs
       }
     },
     
     #getMinOccurs
     getMinOccurs = function(){
       return(private$minOccurs)
     },
     
     #getMaxOccurs
     getMaxOccurs = function(){
       return(private$maxOccurs)
     },
     
     #asDataFrame
     asDataFrame = function(){
       return(data.frame(
         identifier = self$getIdentifier(),
         title = self$getTitle(),
         abstract = self$getAbstract(),
         minOccurs = self$getMinOccurs(),
         maxOccurs = self$getMaxOccurs(),
         stringsAsFactors = FALSE
       ))
     }
     
   )
)