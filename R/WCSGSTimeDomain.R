#' WCSGSTimeDomain
#'
#' @docType class
#' @keywords WCS GeoServer time domain
#' @return Object of \code{\link[R6]{R6Class}} modelling a WCS geoserver time domain object
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Experimental
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSGSTimeDomain <- R6Class("WCSGSTimeDomain",
   inherit = ISOAbstractObject,
   private = list(
     xmlElement = "TimeDomain",
     xmlNamespacePrefix = "WCSGS"
   ),
   public = list(
     #'@field TimeInstant time instants
     TimeInstant = list(),
     
     #'@description Decodes from XML
     #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
     decode = function(xml){
       self$TimeInstant = as.list(as.character(sapply(xmlChildren(xml), function(x){
         xmlValue(xmlChildren(x)[[1]])
       })))
     }
   )
)