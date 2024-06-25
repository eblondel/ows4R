#' CSWConstraint
#' @docType class
#' @export
#' @keywords OGC Filter
#' @return Object of \code{\link[R6]{R6Class}} for modelling an CSW Constraint
#' @format \code{\link[R6]{R6Class}} object.
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
    xmlNamespacePrefix = "CSW"
  ),
  public = list(
    #'@field wrap internal property for object XML encoding
    wrap = TRUE,
    #'@field CqlText text to use as CQL filter
    CqlText = NULL,
    #'@field filter 
    filter = NULL,
    
    #'@description Initializes a \link{CSWConstraint} object to be used to constrain CSW operations.
    #'@param cqlText cqlText, object of class \code{character}
    #'@param filter filter, object extending \link{OGCFilter}
    #'@param serviceVersion CSW service version. Default is "2.0.2"
    initialize = function(cqlText = NULL, filter = NULL, serviceVersion = "2.0.2"){
      self$setServiceVersion(serviceVersion)
      super$initialize(
        element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
        attrs = list(version = "1.1.0"))
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
    
    #'@description Set service version. This methods ensures that underlying filter property
    #' is properly set with the right OGC filter version.
    #'@param serviceVersion service version
    setServiceVersion = function(serviceVersion){
      nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", nsVersion), sep="_")
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