#' CSWQuery
#' @docType class
#' @export
#' @keywords OGC Query
#' @return Object of \code{\link{R6Class}} for modelling an CSW Query
#' @format \code{\link{R6Class}} object.
#' 
#' @examples 
#'   #CSWQuery - elementSetName
#'   query_full <- CSWQuery$new()
#'   query_brief <- CSWQuery$new(elementSetName = "brief")
#'   query_summary <- CSWQuery$new(elementSetName = "summary")
#'   
#'   #CSWQuery - cqlText with title
#'   cons <- CSWConstraint$new(cqlText = "dc:title like '%ips%'")
#'   query <- CSWQuery$new(constraint = cons)
#'   
#'   #CSW 2.0.2 - Query - Filter / AnyText
#'   filter <- OGCFilter$new( PropertyIsLike$new("csw:AnyText", "%Physio%"))
#'   cons <- CSWConstraint$new(filter = filter)
#'   query <- CSWQuery$new(constraint = cons)
#'   
#'   #CSW 2.0.2 - Query - Filter / AnyText Equal
#'   filter <- OGCFilter$new( PropertyIsEqualTo$new("csw:AnyText", "species"))
#'   cons <- CSWConstraint$new(filter = filter)
#'   query <- CSWQuery$new(constraint = cons)
#'   
#'   #CSW 2.0.2 - Query - Filter / AnyText And Not
#'   filter <- OGCFilter$new(And$new(
#'     PropertyIsLike$new("csw:AnyText", "%lorem%"),
#'     PropertyIsLike$new("csw:AnyText", "%ipsum%"),
#'     Not$new(
#'       PropertyIsLike$new("csw:AnyText", "%dolor%")
#'     )
#'   ))
#'   cons <- CSWConstraint$new(filter = filter)
#'   query <- CSWQuery$new(constraint = cons)
#'  
#'   #CSW 2.0.2 - Query - Filter / AnyText And nested Or
#'   filter <- OGCFilter$new(And$new(
#'     PropertyIsEqualTo$new("dc:title", "Aliquam fermentum purus quis arcu"),
#'     PropertyIsEqualTo$new("dc:format", "application/pdf"),
#'     Or$new(
#'       PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Dataset"),
#'       PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Service"),
#'       PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Image"),
#'       PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Text")
#'     )
#'   ))
#'   cons <- CSWConstraint$new(filter = filter)
#'   query <- CSWQuery$new(elementSetName = "brief", constraint = cons)
#'   
#'   #CSW 2.0.2 - Query - Filter / BBOX
#'   bbox <- matrix(c(-180,180,-90,90), nrow = 2, ncol = 2, byrow = TRUE,
#'                  dimnames = list(c("x", "y"), c("min","max")))
#'   filter <- OGCFilter$new( BBOX$new(bbox = bbox) )
#'   cons <- CSWConstraint$new(filter = filter)
#'   query <- CSWQuery$new(elementSetName = "brief", constraint = cons)
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
CSWQuery <-  R6Class("CSWQuery",
  inherit = OGCAbstractObject,
  private = list(
    xmlElement = "Query",
    xmlNamespacePrefix = "CSW",
    typeNames = "csw:Record"
  ),
  public = list(
    #'@field ElementSetName element set name property for request XML encoding
    ElementSetName = "full",
    #'@field constraint property for request XML encoding
    constraint = NULL,
    
    #'@description This method is used to instantiate an CSWQUery object. The \code{elementSetName} can be 
    #'    either "full" (default), "brief" or "summary". A constraint \code{CSWConstraint} can be
    #'    defined for the query. The \code{typeNames} indicates to query (default "csw:Record").
    #'    The \code{serviceVersion} gives the CSW service version (default "2.0.2")
    #'@param elementSetName element set name. Default is "full"
    #'@param constraint object of class \link{CSWConstraint}
    #'@param typeNames type names
    #'@param serviceVersion CSW service version
    initialize = function(elementSetName = "full", constraint = NULL,
                          typeNames = "csw:Record", serviceVersion = "2.0.2"){
      private$typeNames <- typeNames
      self$setServiceVersion(serviceVersion)
      super$initialize(
        element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
        attrs = list(typeNames = private$typeNames))
      if(!is(elementSetName, "character")){
        stop("The argument 'elementSetName' should be an object of class 'character'")
      }
      self$ElementSetName = elementSetName
      
      if(!is.null(constraint)) if(!is(constraint, "CSWConstraint")){
        stop("The argument 'constraint' should be an object of class 'OGCConstraint'")
      }
      self$constraint = constraint
    },
    
    #'@description Set service version. The methods ensures propery naming of typeNames depending on the service version
    #'@param serviceVersion service version
    setServiceVersion = function(serviceVersion){
      nsVersion <- ifelse(serviceVersion=="3.0.0", "3.0", serviceVersion)
      private$xmlNamespacePrefix = paste(private$xmlNamespacePrefix, gsub("\\.", "_", nsVersion), sep="_")
      if(private$typeNames == "csw:Record" && serviceVersion=="3.0.0"){
        private$typeNames <- "csw30:Record"
      }
    }
    
  )
)