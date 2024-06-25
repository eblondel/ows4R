#' WCSGridCRS
#'
#' @docType class
#' @export
#' @keywords OGC WCS Coverage grid crs
#' @return Object of \code{\link[R6]{R6Class}} modelling a WCS grid CRS
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSGridCRS <- R6Class("WCSGridCRS",
  inherit = OGCAbstractObject,                       
  private = list(
    
    #fetchGridCRS
    fetchGridCRS = function(xmlObj, serviceVersion, owsVersion){
      children <- xmlChildren(xmlObj)
      gridcrs <- list(
        GridBaseCRS = xmlValue(children$GridBaseCRS),
        GridType = xmlValue(children$GridType),
        GridOrigin = as.numeric(unlist(strsplit(xmlValue(children$GridOrigin), " "))),
        GridOffsets = as.numeric(unlist(strsplit(xmlValue(children$GridOffsets), " "))),
        GridCS = xmlValue(children$GridCS)
      )
      return(gridcrs)
    }
    
  ),
  public = list(
    #'@field GridBaseCRS grid base CRS
    GridBaseCRS = NULL,
    #'@field GridType grid type
    GridType = NULL,
    #'@field GridOrigin grid origin
    GridOrigin = NULL,
    #'@field GridOffsets grid offsets
    GridOffsets = NULL,
    #'@field GridCS grid CS
    GridCS = NULL,
    
    #'@description Initializes an object of class \link{WCSGridCRS}
    #'@param xmlObj an object of class \link[XML]{XMLInternalNode-class} to initialize from XML
    #'@param serviceVersion service version
    #'@param owsVersion OWS version
    #'@param logger logger
    initialize = function(xmlObj, serviceVersion, owsVersion, logger = NULL){
      super$initialize(logger = logger)
      gridcrs <- private$fetchGridCRS(xmlObj, serviceVersion, owsVersion)
      self$GridBaseCRS <- gridcrs$GridBaseCRS
      self$GridType <- gridcrs$GridType
      self$GridOrigin <- gridcrs$GridOrigin
      self$GridOffsets <- gridcrs$GridOffsets
      self$GridCS <- gridcrs$GridCS
    }
    
  )
)