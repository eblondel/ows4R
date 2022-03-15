#' WCSCoverage
#'
#' @docType class
#' @export
#' @keywords OGC WCS Coverage
#' @return Object of \code{\link{R6Class}} modelling a WCS coverage
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSCoverage <- R6Class("WCSCoverage",
   inherit = OGCAbstractObject,                       
   private = list(
     identifier = NA,
     title = NA,
     abstract = NA,
     reference = NA,
     
     #fetchCoverage
     fetchCoverage = function(xmlObj, serviceVersion, owsVersion){
       children <- xmlChildren(xmlObj)
       covIdentifier <- NULL
       if(!is.null(children$Identifier)){
         covIdentifier <- xmlValue(children$Identifier)
       }
       covTitle <- NULL
       if(!is.null(children$Title)){
         covTitle <- xmlValue(children$Title)
       }
       covAbstract <- NULL
       if(!is.null(children$Abstract)){
         covAbstract <- xmlValue(children$Abstract)
       }
       covRef <- NULL
       if(!is.null(children$Reference)){
         covRef <- xmlGetAttr(children$Reference, "xlink:href")
       }
       
       coverage <- list(
         identifier = covIdentifier,
         title = covTitle,
         abstract = covAbstract,
         reference = covRef
       )
       
       return(coverage)
       
     }
     
   ),
   public = list(
     #'@field description description
     description = NULL,
     
     #'@description Initializes an object of class \link{WCSCoverage}
     #'@param xmlObj object of class \link{XMLInternalNode-class}
     #'@param serviceVersion WCS service version
     #'@param owsVersion OWS version
     #'@param logger logger
     initialize = function(xmlObj, serviceVersion, owsVersion, logger = NULL){
       super$initialize(logger = logger)
       
       coverage = private$fetchCoverage(xmlObj, serviceVersion, owsVersion)
       private$identifier = coverage$identifier
       private$title = coverage$title
       private$abstract = coverage$abstract
       private$reference = coverage$reference
     },
     
     #'@description Get identifier
     #'@return an object of class \code{character}
     getIdentifier = function(){
       return(private$identifier)
     },
     
     #'@description Get title
     #'@return an object of class \code{character}
     getTitle = function(){
       return(private$title)
     },
     
     #'@description Get abstract
     #'@return an object of class \code{character}
     getAbstract = function(){
       return(private$abstract)
     },
     
     #'@description Get reference
     #'@return an object of class \code{character}
     getReference = function(){
       return(private$reference)
     },
     
     #'@description Get data
     #'@param filename filename. Optional file name where to download the coverage
     #'@return an object of class \code{SpatRaster} from \pkg{terra}
     getData = function(filename = NULL){
       covfile <- NULL
       if(!is.null(filename)){ covfile <- filename }else{ covfile <- tempfile() }
       req <- httr::GET(private$reference)
       bin <- content(req, "raw")
       writeBin(bin, covfile)
       r <- terra::rast(covfile)
       return(r)
     }
   )
)