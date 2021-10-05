#' WPSStatus
#'
#' @docType class
#' @export
#' @keywords OGC WPS Status
#' @return Object of \code{\link{R6Class}} for modelling a WPS Status
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, serviceVersion)}}{
#'    This method is used to instantiate a \code{WPSStatus} object
#'  }
#'  \item{\code{decode(xml)}}{
#'    Decodes WPS status from XML
#'  }
#'  \item{\code{getValue()}}{
#'    Get status value, among accepted WPS status values defined in the WPS standard:
#'    \code{ProcessAccepted}, \code{ProcessStarted}, \code{ProcessPaused}, \code{ProcessSucceeded},
#'    \code{ProcessFailed}.
#'  }
#'  \item{\code{getPercentCompleted()}}{
#'    Get percent completed
#'  }
#'  \item{\code{getCreationTime()}}{
#'    Get creation time
#'  }
#' }
#' 
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSStatus <- R6Class("WPSStatus",
    inherit = OGCAbstractObject,
    private = list(
      xmlElement = "Status",
      xmlNamespacePrefix = "WPS"
    ),
    public = list(
      value = NULL,
      percentCompleted = 0L,
      initialize = function(xml = NULL, serviceVersion = "1.0.0") {
        private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
        super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
        if(!is.null(xml)){
          print(xml)
          self$decode(xml)
        }
      },
      
      #decode
      decode = function(xml){
        self$value <- xmlName(xmlChildren(xml)[[1]])
        percentCompleted = xmlGetAttr(xmlChildren(xml)[[1]], "percentCompleted")
        if(!is.null(percentCompleted)) self$percentCompleted = as(percentCompleted, "integer")
        if(self$value == "ProcessSucceeded") self$percentCompleted <- 100L
        self$attrs$creationTime <- as.POSIXct(xmlGetAttr(xml, "creationTime"), format= "%Y-%m-%dT%H:%M:%S")
      },
      
      #getValue
      getValue = function(){
        return(self$value)
      },
      
      #getPercentCompleted
      getPercentCompleted = function(){
        return(self$percentCompleted)
      },
      
      #getCreationTime
      getCreationTime = function(){
        return(self$attrs$creationTime)
      }
    )
)