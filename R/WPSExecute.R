#' WPSExecute
#'
#' @docType class
#' @export
#' @keywords OGC WPS Execute
#' @return Object of \code{\link{R6Class}} for modelling a WPS Execute request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(op, url, serviceVersion, identifier, logger, ...)}}{
#'    This method is used to instantiate a WPSExecute object
#'  }
#' }
#' 
#' @note Abstract class used by \pkg{ows4R} to trigger a WPS Execute request
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSExecute <- R6Class("WPSExecute",
  inherit = OWSHttpRequest,
  private = list(
    xmlElement = "Execute",
    xmlNamespace = c(wps = "http://www.opengis.net/wps")
  ),
  public = list(
    Identifier = "",
    DataInputs = list(),
    initialize = function(op, url, serviceVersion, identifier, 
                          dataInputs = list(), logger = NULL, ...) {
      private$xmlNamespace = paste(private$xmlNamespace, serviceVersion, sep="/")
      names(private$xmlNamespace) <- "wps"
      namedParams <- list(service = "WPS", version = version, identifier = identifier)
      super$initialize(op, "POST", url, request = private$name,
                       namedParams = namedParams, mimeType = "text/xml", logger = logger,
                       ...)
      self$Identifier <- OWSCodeType$new(value = identifier)
      dataInputNames <- names(dataInputs)
      self$DataInputs <- lapply(dataInputNames, function(dataInputName){
        dataInput <- dataInputs[[dataInputName]]
        WPSInput$new(identifier = dataInputName, data = dataInput)
      })
      #self$execute()
    }
  )
)