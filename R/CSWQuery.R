#' CSWQuery
#' @docType class
#' @export
#' @keywords OGC Query
#' @return Object of \code{\link{R6Class}} for modelling an CSW Query
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(filter, serviceVersion)}}{
#'    This method is used to instantiate an CSWQUery object.
#'  }
#' }
CSWQuery <-  R6Class("CSWQuery",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Query",
    xmlNamespaceBase = "http://www.opengis.net/cat/csw",
    xmlNamespace = c(csw = "http://www.opengis.net/cat/csw"),
    typeNames = "csw:Record"
  ),
  public = list(
    ElementSetName = "full",
    constraint = NULL,
    initialize = function(elementSetName = "full", constraint = NULL,
                          typeNames = "csw:Record", serviceVersion = "2.0.2"){
      private$typeNames <- typeNames
      self$setServiceVersion(serviceVersion)
      super$initialize(attrs = list(typeNames = private$typeNames))
      if(!is(elementSetName, "character")){
        stop("The argument 'elementSetName' should be an object of class 'character'")
      }
      self$ElementSetName = elementSetName
      
      if(!is.null(constraint)) if(!is(constraint, "CSWConstraint")){
        stop("The argument 'constraint' should be an object of class 'OGCConstraint'")
      }
      self$constraint = constraint
    },
    
    #setServiceVersion
    setServiceVersion = function(serviceVersion){
      nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
      private$xmlNamespace = paste(private$xmlNamespaceBase, nsVersion, sep="/")
      names(private$xmlNamespace) <- ifelse(serviceVersion=="3.0.0", "csw30", "csw")
      if(private$typeNames == "csw:Record" && serviceVersion=="3.0.0"){
        private$typeNames <- paste0(names(private$xmlNamespace),":Record")
      }
    }
    
  )
)