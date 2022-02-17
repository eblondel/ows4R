#' WCSGSElevationDomain
#'
#' @docType class
#' @export
#' @keywords WCS GeoServer elevation domain
#' @return Object of \code{\link{R6Class}} modelling a WCS geoserver elevation domain object
#' @format \code{\link{R6Class}} object.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSGSElevationDomain <- R6Class("WCSGSElevationDomain",
  inherit = ISOAbstractObject,
  private = list(
    xmlElement = "ElevationDomain",
    xmlNamespacePrefix = "WCSGS"
  ),
  public = list(
    #'@field SingleValue single values
    SingleValue = list(),
    
    #'@description Decodes from XML
    #'@param xml object of class \link{XMLInternalNode-Class} from \pkg{XML}
    decode = function(xml){
      print("decoding WCSGSElevationDomain")
      self$SingleValue = as.list(as.character(sapply(xmlChildren(xml), xmlValue)))
    }
  )
)