#' WPSInputDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process input description
#' @return Object of \code{\link[R6]{R6Class}} modelling a WPS process input description
#' @format \code{\link[R6]{R6Class}} object.
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
      
      #'@description Initializes a \link{WPSInputDescription}
      #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
      #'@param version WPS service version
      #'@param logger logger
      #'@param ... any other parameter
     initialize = function(xml = NULL, version, logger = NULL, ...){
       super$initialize(xml = xml, version = version, logger = logger, ...)
       private$version = version
       if(!is.null(xml)){
          inputDescription = private$fetchInputDescription(xml, version)
          private$minOccurs = inputDescription$minOccurs
          private$maxOccurs = inputDescription$maxOccurs
       }
     },
     
     #'@description Get min occurs
     #'@return the min occurs
     getMinOccurs = function(){
       return(private$minOccurs)
     },
     
     #'@description Get max occurs
     #'@return the max occurs
     getMaxOccurs = function(){
       return(private$maxOccurs)
     },
     
     #'@description Get intput description as \code{data.frame}
     #'@return object of class \code{character}
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