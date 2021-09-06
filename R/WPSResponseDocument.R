#' WPSResponseDocument
#'
#' @docType class
#' @export
#' @keywords OGC WPS ResponseDocument
#' @return Object of \code{\link{R6Class}} for modelling a WPS ResponseDocument
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, storeExecuteResponse, lineage, status, output)}}{
#'    This method is used to instantiate a WPSResponseDocument object
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSResponseDocument <- R6Class("WPSResponseDocument",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "ResponseDocument",
    xmlNamespacePrefix = "WPS"
  ),
  public = list(
    Output = NULL,
    initialize = function(xml = NULL, storeExecuteResponse = FALSE, lineage = NULL, status = NULL, output = NULL,
                          serviceVersion = "1.0.0") {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      self$wrap <- TRUE
      if(is.null(xml)){
        self$attrs$storeExecuteResponse <- tolower(as.character(storeExecuteResponse))
        if(!is.null(lineage)) self$attrs$lineage <- tolower(as.character(lineage))
        if(!is.null(status)) self$attrs$status <- tolower(as.character(status))
        self$Output <- output
      }else{
        self$decode(xml)
      }
    }
  )
)