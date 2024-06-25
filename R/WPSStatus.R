#' WPSStatus
#'
#' @docType class
#' @export
#' @keywords OGC WPS Status
#' @return Object of \code{\link[R6]{R6Class}} for modelling a WPS Status
#' @format \code{\link[R6]{R6Class}} object.
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
      #'@field value status value
      value = NULL,
      #'@field percentCompleted status percentage of completion
      percentCompleted = 0L,
      
      #'@description Initalizes a \link{WPSStatus} object
      #'@param xml an object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
      #'@param serviceVersion WPS service version. Default is "1.0.0"
      initialize = function(xml = NULL, serviceVersion = "1.0.0") {
        private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", serviceVersion), sep="_")
        super$initialize(xml = xml, element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
        if(!is.null(xml)){
          print(xml)
          self$decode(xml)
        }
      },
      
      #'@description Decodes WPS status from XML
      #'@param xml an object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
      decode = function(xml){
        self$value <- xmlName(xmlChildren(xml)[[1]])
        percentCompleted = xmlGetAttr(xmlChildren(xml)[[1]], "percentCompleted")
        if(!is.null(percentCompleted)) self$percentCompleted = as(percentCompleted, "integer")
        if(self$value == "ProcessSucceeded") self$percentCompleted <- 100L
        self$attrs$creationTime <- as.POSIXct(xmlGetAttr(xml, "creationTime"), format= "%Y-%m-%dT%H:%M:%S")
      },
      
      #'@description Get status value, among accepted WPS status values defined in the WPS standard:
      #'    \code{ProcessAccepted}, \code{ProcessStarted}, \code{ProcessPaused}, \code{ProcessSucceeded},
      #'    \code{ProcessFailed}.
      #'@return value, object of class \code{character}
      getValue = function(){
        return(self$value)
      },
      
      #'@description Get percentage of completion
      #'@return the percentage of completion, object of class \code{integer}
      getPercentCompleted = function(){
        return(self$percentCompleted)
      },
      
      #'@description Get creation time
      #'@return the creation time, object of class \code{POSIXct}
      getCreationTime = function(){
        return(self$attrs$creationTime)
      }
    )
)