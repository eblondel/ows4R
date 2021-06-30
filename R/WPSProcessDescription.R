#' WPSProcessDescription
#'
#' @docType class
#' @export
#' @keywords OGC WPS Process ProcessDescription
#' @return Object of \code{\link{R6Class}} modelling a WPS process description
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xmlObj, capabilities, version, logger)}}{
#'    This method is used to instantiate a \code{WPSProcessDescription} object
#'  }
#'  \item{\code{getIdentifier()}}{
#'    Get process identifier
#'  }
#'  \item{\code{getTitle()}}{
#'    Get process title
#'  }
#'  \item{\code{getAbstract()}}{
#'    Get process abstract
#'  }
#'  \item{\code{getVersion()}}{
#'    Get process version
#'  }
#'  \item{\code{isStatusSupported()}}{
#'    Get whether status is supported
#'  }
#'  \item{\code{isStoreSupported()}}{
#'    Get whether store is supported
#'  }
#'  \item{\code{asDataFrame()}}{
#'    Get process description as data.frame
#'  }
#' }
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WPSProcessDescription <- R6Class("WPSProcessDescription",
  inherit = OGCAbstractObject,                       
  private = list(
    
    capabilities = NULL,
    url = NA,
    version = NA,
    
    identifier = NA,
    title = NA,
    abstract= NA,
    processVersion = NA,
    statusSupported = FALSE,
    storeSupported = FALSE,
    
    #fetchProcessDescription
    fetchProcessDescription = function(xmlObj, version){
      
      children <- xmlChildren(xmlObj)
      
      processIdentifier <- NULL
      if(!is.null(children$Identifier)){
        processIdentifier <- xmlValue(children$Identifier)
      }
      
      processTitle <- NULL
      if(!is.null(children$Title)){
        processTitle <- xmlValue(children$Title)
      }
      
      processAbstract <- NULL
      if(!is.null(children$Abstract)){
        processAbstract <- xmlValue(children$Abstract)
      }
      
      processVersion <- xmlGetAttr(xmlObj, "wps:processVersion")
      statusSupported <- xmlGetAttr(xmlObj, "statusSupported") == "true"
      storeSupported <- xmlGetAttr(xmlObj, "storeSupported") == "true"
      
      processDescription <- list(
        identifier = processIdentifier,
        title = processTitle,
        abstract = processAbstract,
        version = processVersion,
        statusSupported = statusSupported,
        storeSupported = storeSupported
      )
      
      return(processDescription)
    }
    
  ),
  public = list(
    initialize = function(xmlObj, capabilities, version, logger = NULL, ...){
      super$initialize(logger = logger)
      
      private$capabilities = capabilities
      private$url = capabilities$getUrl()
      private$version = version
      
      processDesc = private$fetchProcessDescription(xmlObj, version)
      private$identifier = processDesc$identifier
      private$title = processDesc$title
      private$abstract = processDesc$abstract
      private$processVersion = processDesc$version
      private$statusSupported = processDesc$statusSupported
      private$storeSupported = processDesc$storeSupported
    },
    
    #getIdentifier
    getIdentifier = function(){
      return(private$identifier)
    },
    
    #getTitle
    getTitle = function(){
      return(private$title)
    },
    
    #getAbstract
    getAbstract = function(){
      return(private$abstract)
    },
    
    #getVersion
    getVersion = function(){
      return(private$processVersion)
    },
    
    #isStatusSupported
    isStatusSupported = function(){
      return(private$statusSupported)
    },
    
    #isStoreSupported
    isStoreSupported = function(){
      return(private$storeSupported)
    },
    
    #asDataFrame
    asDataFrame = function(){
      return(data.frame(
        identifier = self$getIdentifier(),
        title = self$getTitle(),
        abstract = self$getAbstract(),
        version = self$getVersion(),
        statusSupported = self$isStatusSupported(),
        storeSupported = self$isStoreSupported(),
        stringsAsFactors = FALSE
      ))
    }
    
  )
)