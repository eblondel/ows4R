#' CSWRecordProperty
#' @docType class
#' @export
#' @keywords CSW RecordProperty
#' @return Object of \code{\link{R6Class}} for modelling an CSW RecordProperty
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(name, value, cswVersion)}}{
#'    This method is used to instantiate an CSWRecordProperty object.
#'  }
#' }
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
    wrap = TRUE,
    Name = NULL,
    Value = NULL,
    initialize = function(name, value, cswVersion = "2.0.2"){
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", cswVersion), sep="_")
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      self$Name = name
      self$Value = value
    }
  )
)