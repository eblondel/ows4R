#' CSWRecordProperty
#' @docType class
#' @export
#' @keywords CSW RecordProperty
#' @return Object of \code{\link[R6]{R6Class}} for modelling an CSW RecordProperty
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @examples 
#'    rp <- CSWRecordProperty$new(name = "NAME", value = "VALUE")
#'    rp_xml <- rp$encode() #see how it looks in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
CSWRecordProperty <-  R6Class("CSWRecordProperty",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "RecordProperty",
    xmlNamespacePrefix = "CSW"
  ),
  public = list(
    #'@field wrap internal property for XML encoding
    wrap = TRUE,
    #'@field Name name property for request XML encoding
    Name = NULL,
    #'@field Value property for request XML encoding
    Value = NULL,
    
    #'@description Initializes an object of class \link{CSWRecordProperty}
    #'@param name name
    #'@param value value
    #'@param cswVersion CSW service version. Default is "2.0.2"
    initialize = function(name, value, cswVersion = "2.0.2"){
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", cswVersion), sep="_")
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      self$Name = name
      self$Value = value
    }
  )
)