#' WPSResponseDocument
#'
#' @docType class
#' @export
#' @keywords OGC WPS ResponseDocument
#' @return Object of \code{\link[R6]{R6Class}} for modelling an OGC WPS response document
#' @format \link[R6]{R6Class} object.
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
    #'@field Output output property
    Output = NULL,
    
    #'@description Initializes a \link{WPSResponseDocument}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param storeExecuteResponse store execute response, object of class \code{logical}
    #'@param lineage lineage, object of class \code{logical}
    #'@param status status, object of class \code{logical}
    #'@param output output
    #'@param serviceVersion WPS service version
    initialize = function(xml = NULL, storeExecuteResponse = FALSE, lineage = NULL, status = NULL, output = NULL,
                          serviceVersion = "1.0.0") {
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
      super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      self$wrap <- TRUE
      if(is.null(xml)){
        self$attrs$storeExecuteResponse <- tolower(as.character(storeExecuteResponse))
        if(!is.null(lineage)){
          if(!is(lineage, "logical")){
            errMsg <- "Process lineage should be of type 'logical'"
            self$ERROR(errMsg)
            stop(errMsg)
          }
          self$attrs$lineage <- tolower(as.character(lineage))
        }
        if(!is.null(status)){
          if(!is(status, "logical")){
            errMsg <- "Process status should be of type 'logical'"
            self$ERROR(errMsg)
            stop(errMsg)
          }
          self$attrs$status <- tolower(as.character(status))
          if(self$attrs$status) self$attrs$storeExecuteResponse <- "true"
        }
        self$Output <- output
      }else{
        self$decode(xml)
      }
    }
  )
)