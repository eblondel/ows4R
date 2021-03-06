#' CSWConstraint
#' @docType class
#' @export
#' @keywords OGC Filter
#' @return Object of \code{\link{R6Class}} for modelling an CSW Constraint
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(cqlText, filter, serviceVersion)}}{
#'    This method is used to instantiate an CSWConstraint object.
#'  }
#' }
#' 
#' @examples
#'   filter <- OGCFilter$new( PropertyIsEqualTo$new("apiso:Identifier", "12345") )
#'   cons <- CSWConstraint$new(filter = filter)
#'   cons_xml <- cons$encode() #how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
CSWConstraint <-  R6Class("CSWConstraint",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Constraint",
    xmlNamespaceBase = "http://www.opengis.net/cat/csw",
    xmlNamespace = c(csw = "http://www.opengis.net/cat/csw")
  ),
  public = list(
    wrap = TRUE,
    CqlText = NULL,
    filter = NULL,
    initialize = function(cqlText = NULL, filter = NULL, serviceVersion = "2.0.2"){
      self$setServiceVersion(serviceVersion)
      super$initialize(attrs = list(version = "1.1.0"))
      if(!is.null(cqlText)) if(!is(cqlText, "character")){
        stop("The argument 'cqlText' should be an object of class 'character'")
      }
      if(!is.null(filter)) if(!is(filter, "OGCFilter")){
        stop("The argument 'filter' should be an object of class 'OGCFilter'")
      }
      self$CqlText = cqlText
      if(!is.null(filter) && serviceVersion=="3.0.0") filter$setFilterVersion("2.0")
      self$filter = filter
    },
    
    #setServiceVersion
    setServiceVersion = function(serviceVersion){
      nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
      private$xmlNamespace = paste(private$xmlNamespaceBase, nsVersion, sep="/")
      names(private$xmlNamespace) <- ifelse(serviceVersion=="3.0.0", "csw30", "csw")
      if(!is.null(self$filter)){
        if(serviceVersion=="3.0.0"){
          self$filter$setFilterVersion("2.0")
        }else{
          self$filter$setFilterVersion("1.1.0")
        }
      }
    }
    
  )
)