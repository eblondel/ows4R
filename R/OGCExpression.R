#' OGCExpression
#' @docType class
#' @export
#' @keywords OGC Expression
#' @return Object of \code{\link{R6Class}} for modelling an OGC Expression
#' @format \code{\link{R6Class}} object.
#' 
#' @note abstract class
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OGCExpression <-  R6Class("OGCExpression",
   inherit = OGCAbstractObject,
   private = list(
     exprVersion = "1.1.0"
   ),
   public = list(
     
     #'@description Initializes an object of class \link{OGCExpression}
     #'@param element element name
     #'@param namespacePrefix XML namespace prefix
     #'@param attrs attributes
     #'@param defaults default values
     #'@param exprVersion OGC version for the expression
     initialize = function(element, namespacePrefix, attrs = NULL, defaults = NULL, exprVersion = "1.1.0"){
       self$setExprVersion(exprVersion)
       super$initialize(element = element, namespacePrefix = namespacePrefix,
                        attrs = attrs, defaults = defaults)
     },
     
     #'@description Sets expression version. The methods will control proper XML namespace prefix setting
     #'@param exprVersion OGC expression version
     setExprVersion = function(exprVersion) {
       private$exprVersion = exprVersion
       if(exprVersion=="2.0"){
         private$xmlNamespacePrefix <- "FES"
       }else{
         private$xmlNamespacePrefix <- "OGC"
       }
     },
     
     #'@description Gets expression version
     #'@return object of class \code{character}
     getExprVersion = function(){
       return(private$exprVersion)
     }
   )
)

#' BinaryComparisonOpType
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType
#' @return Object of \code{\link{R6Class}} for modelling an BinaryComparisonOpType
#' @format \code{\link{R6Class}} object.
#' 
#' @note abstract super class of all the property operation classes
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
BinaryComparisonOpType <-  R6Class("BinaryComparisonOpType",
  inherit = OGCExpression,
  public = list(
    #'@field PropertyName property name field for XML encoding
    PropertyName = NULL,
    #'@field Literal literal field for XML encoding
    Literal = NULL,
    #'@field attrs attributes for XML encoding
    attrs = list(matchCase = NA),
    
    #'@description Initializes an object extending \link{BinaryComparisonOpType}
    #'@param element element name
    #'@param namespacePrefix XML namespace prefix
    #'@param PropertyName property name
    #'@param Literal literal
    #'@param matchCase match case
    initialize = function(element, namespacePrefix, PropertyName, Literal, matchCase = NA){
      super$initialize(element = element, namespacePrefix = namespacePrefix)
      self$PropertyName = PropertyName
      self$Literal = Literal
      self$attrs$matchCase = matchCase
    }
  )
)

#' PropertyIsEqualTo
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsEqualTo
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsEqualTo
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsEqualTo$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsEqualTo <-R6Class("PropertyIsEqualTo",
  inherit = BinaryComparisonOpType,
  private = list(
    xmlElement = "PropertyIsEqualTo",
    xmlNamespacePrefix = "OGC"
  ),
  public = list(
    
    #'@description Initializes an object extending \link{PropertyIsEqualTo}
    #'@param PropertyName property name
    #'@param Literal literal
    #'@param matchCase match case
    initialize = function(PropertyName, Literal, matchCase = NA){
      super$initialize(
        element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
        PropertyName, Literal, matchCase
      )
    }
  )
)

#' PropertyIsNotEqualTo
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsNotEqualTo
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsNotEqualTo
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsNotEqualTo$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
PropertyIsNotEqualTo <-R6Class("PropertyIsNotEqualTo",
  inherit = BinaryComparisonOpType,
  private = list(
    xmlElement = "PropertyIsNotEqualTo",
    xmlNamespacePrefix = "OGC"
  ),
  public = list(
    
    #'@description Initializes an object extending \link{PropertyIsNotEqualTo}
    #'@param PropertyName property name
    #'@param Literal literal
    #'@param matchCase match case
    initialize = function(PropertyName, Literal, matchCase = NA){
      super$initialize(
        element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
        PropertyName, Literal, matchCase
      )
    }
  )
)

#' PropertyIsLessThan
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsLessThan
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsLessThan
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsLessThan$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsLessThan <-R6Class("PropertyIsLessThan",
   inherit = BinaryComparisonOpType,
   private = list(
     xmlElement = "PropertyIsLessThan",
     xmlNamespacePrefix = "OGC"
   ),
   public = list(
     
     #'@description Initializes an object extending \link{PropertyIsLessThan}
     #'@param PropertyName property name
     #'@param Literal literal
     #'@param matchCase match case
     initialize = function(PropertyName, Literal, matchCase = NA){
       super$initialize(
         element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
         PropertyName, Literal, matchCase
       )
     }
   )
)

#' PropertyIsGreaterThan
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsGreaterThan
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsGreaterThan
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsGreaterThan$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsGreaterThan <-R6Class("PropertyIsGreaterThan",
   inherit = BinaryComparisonOpType,
   private = list(
     xmlElement = "PropertyIsGreaterThan",
     xmlNamespacePrefix = "OGC"
   ),
   public = list(
     
     #'@description Initializes an object extending \link{PropertyIsGreaterThan}
     #'@param PropertyName property name
     #'@param Literal literal
     #'@param matchCase match case
     initialize = function(PropertyName, Literal, matchCase = NA){
       super$initialize(
         element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
         PropertyName, Literal, matchCase
       )
     }
   )
)

#' PropertyIsLesserThanOrEqualTo
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsLesserThanOrEqualTo
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsLesserThanOrEqualTo
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsLessThanOrEqualTo$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsLessThanOrEqualTo <-R6Class("PropertyIsLessThanOrEqualTo",
 inherit = BinaryComparisonOpType,
 private = list(
   xmlElement = "PropertyIsLessThanOrEqualTo",
   xmlNamespacePrefix = "OGC"
 ),
 public = list(
   
   #'@description Initializes an object extending \link{PropertyIsLessThanOrEqualTo}
   #'@param PropertyName property name
   #'@param Literal literal
   #'@param matchCase match case
   initialize = function(PropertyName, Literal, matchCase = NA){
     super$initialize(
       element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
       PropertyName, Literal, matchCase
     )
   }
 )
)

#' PropertyIsGreaterThanOrEqualTo
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsGreaterThanOrEqualTo
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsGreaterThanOrEqualTo
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsGreaterThanOrEqualTo$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsGreaterThanOrEqualTo <-R6Class("PropertyIsGreaterThanOrEqualTo",
  inherit = BinaryComparisonOpType,
  private = list(
    xmlElement = "PropertyIsGreaterThanOrEqualTo",
    xmlNamespacePrefix = "OGC"
  ),
  public = list(
    
    #'@description Initializes an object extending \link{PropertyIsGreaterThanOrEqualTo}
    #'@param PropertyName property name
    #'@param Literal literal
    #'@param matchCase match case
    initialize = function(PropertyName, Literal, matchCase = NA){
      super$initialize(
        element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix,
        PropertyName, Literal, matchCase
      )
    }
  )
)

#' PropertyIsLike
#' @docType class
#' @export
#' @keywords OGC Expression PropertyIsLike
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsLike
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsLike$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsLike <-  R6Class("PropertyIsLike",
   inherit = OGCExpression,
   private = list(
     xmlElement = "PropertyIsLike",
     xmlNamespacePrefix = "OGC"
   ),
   public = list(
     #'@field PropertyName property name field for XML encoding
     PropertyName = NULL,
     #'@field Literal literal field for XML encoding
     Literal = NULL,
     #'@field attrs attributes for XML encoding
     attrs = list(
      escapeChar = "\\",
      singleChar = "_",
      wildCard = "%",
      matchCase = NA
     ),
     
     #'@description Initializes an object extending \link{PropertyIsLike}
     #'@param PropertyName property name
     #'@param Literal literal
     #'@param escapeChar escape character. Default is "\\"
     #'@param singleChar single character. Default is "_"
     #'@param wildCard wildcard
     #'@param matchCase match case
     initialize = function(PropertyName, Literal,
                           escapeChar = "\\", singleChar = "_", wildCard = "%", matchCase = NA){
       super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
       self$PropertyName = PropertyName
       self$Literal = Literal
       self$attrs = list(
         escapeChar = escapeChar,
         singleChar = singleChar,
         wildCard = wildCard,
         if(is.logical(matchCase)) matchCase = tolower(as.character(matchCase))
       )
     }
   )
)

#' PropertyIsNull
#' @docType class
#' @export
#' @keywords OGC Expression PropertyIsNull
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsNull
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsNull$new(PropertyName = "property")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsNull <-  R6Class("PropertyIsNull",
   inherit = OGCExpression,
   private = list(
     xmlElement = "PropertyIsNull",
     xmlNamespacePrefix = "OGC"
   ),
   public = list(
     #'@field PropertyName property name field for XML encoding
     PropertyName = NULL,
     
     #'@description Initializes an object extending \link{PropertyIsLike}
     #'@param PropertyName property name 
     initialize = function(PropertyName){
       super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
       self$PropertyName = PropertyName
     }
   )
)

#' PropertyIsBetween
#' @docType class
#' @export
#' @keywords OGC Expression PropertyIsBetween
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsBetween
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsBetween$new(PropertyName = "property", lower = 1, upper = 10)
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
PropertyIsBetween <-  R6Class("PropertyIsBetween",
   inherit = OGCExpression,
   private = list(
     xmlElement = "PropertyIsBetween",
     xmlNamespacePrefix = "OGC"
   ),
   public = list(
     #'@field PropertyName property name field for XML encoding
     PropertyName = NULL,
     #'@field lower lower value
     lower = NULL,
     #'@field upper upper value
     upper = NULL,
     
     #'@description Initializes an object extending \link{PropertyIsLike}
     #'@param PropertyName property name
     #'@param lower lower value
     #'@param upper upper value 
     initialize = function(PropertyName, lower, upper){
       super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
       self$PropertyName = PropertyName
       self$lower = lower
       self$upper = upper
     }
   )
)

#' BBOX
#' @docType class
#' @export
#' @keywords OGC Expression BBOX
#' @return Object of \code{\link{R6Class}} for modelling an BBOX
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   bbox <- OWSUtils$toBBOX(-180,-90,180,90)
#'   expr <- BBOX$new(bbox)
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
BBOX <-  R6Class("BBOX",
  inherit = OGCExpression,
  private = list(
    xmlElement = "BBOX",
    xmlNamespacePrefix = "OGC"
  ),
  public = list(
    #'@field PropertyName property name field for XML encoding
    PropertyName = "ows:BoundingBox",
    #'@field Envelope envelope as object of class \link{GMLEnvelope} from \pkg{geometa}
    Envelope = NULL,
    
    #'@description Initializes a \link{BBOX} expression
    #'@param bbox an object of class \code{matrix}
    #'@param srsName srs name
    initialize = function(bbox, srsName = NULL){
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
      envelope <- GMLEnvelope$new(bbox = bbox, srsName = srsName)
      envelope$wrap <- FALSE
      #gmlNS <- envelope$getNamespaceDefinition()
      #private$xmlNamespace = c(private$xmlNamespace, ns = gmlNS$gml)
      #names(private$xmlNamespace)[length(private$xmlNamespace)] <- names(gmlNS)
      self$Envelope = envelope
    }
  )
)

#BINARY

#' BinaryLogicOpType
#' @docType class
#' @export
#' @keywords OGC Expression BinaryLogicOpType
#' @return Object of \code{\link{R6Class}} for modelling an BinaryLogicOpType
#' @format \code{\link{R6Class}} object.
#' @note abstract super class of all the binary logical operation classes
BinaryLogicOpType <-  R6Class("BinaryLogicOpType",
   inherit = OGCExpression,
   public = list(
     #'@field operations a list OGC expressions
     operations = list(),
     
     #'@description Initializes a \link{BinaryLogicOpType} expression
     #'@param ... list of objects of class \link{OGCExpression}
     #'@param element element
     #'@param namespacePrefix namespacePrefix
     #'@param exprVersion OGC expression version. Default is "1.1.0"
     initialize = function(..., element, namespacePrefix, exprVersion = "1.1.0"){
       super$initialize(element = element, namespacePrefix = namespacePrefix, exprVersion = exprVersion)
       operations <- list(...)
       if(length(operations)<2){
         stop("Binary operations (And / Or) require a minimum of two operations")
       }
       self$operations = operations
       self$setExprVersion(exprVersion)
     },
     
     #'@description Sets expression version. The methods will control that expression versions are set
     #' for each of the operations specified in the expression.
     #'@param exprVersion OGC expression version
     setExprVersion = function(exprVersion){
       private$exprVersion <- exprVersion
       if(length(self$operations)>0) for(i in 1:length(self$operations)){
         self$operations[[i]]$setExprVersion(exprVersion)
       }
     }
   )
)

#' And
#' @docType class
#' @export
#' @keywords OGC Expression BinaryLogicOpType And
#' @return Object of \code{\link{R6Class}} for modelling an And operator
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr1 <- PropertyIsEqualTo$new(PropertyName = "property1", Literal = "value1")
#'   expr2 <- PropertyIsEqualTo$new(PropertyName = "property2", Literal = "value2")
#'   and <- And$new(expr1,expr2)
#'   and_xml <- and$encode() #see how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
And <-  R6Class("And",
  inherit = BinaryLogicOpType,
  private = list(
    xmlElement = "And",
    xmlNamespacePrefix = "OGC"
  ),
  public = list(
    
    #'@description Initializes an \link{And} expression
    #'@param ... list of objects of class \link{OGCExpression}
    initialize = function(...){
      super$initialize(..., element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
    }
  )
)

#' Or
#' @docType class
#' @export
#' @keywords OGC Expression BinaryLogicOpType Or
#' @return Object of \code{\link{R6Class}} for modelling an Or operator
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr1 <- PropertyIsEqualTo$new(PropertyName = "property1", Literal = "value1")
#'   expr2 <- PropertyIsEqualTo$new(PropertyName = "property2", Literal = "value2")
#'   or <- Or$new(expr1,expr2)
#'   or_xml <- or$encode() #see how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
Or <-  R6Class("Or",
  inherit = BinaryLogicOpType,
  private = list(
    xmlElement = "Or",
    xmlNamespacePrefix = "OGC"
  ),
  public = list(
    
    #'@description Initializes an \link{Or} expression
    #'@param ... list of objects of class \link{OGCExpression}
    initialize = function(...){
      super$initialize(..., element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
    }
  )
)

#UNARY

#' UnaryLogicOpType
#' @docType class
#' @export
#' @keywords OGC Expression UnaryLogicOpType
#' @return Object of \code{\link{R6Class}} for modelling an UnaryLogicOpType
#' @format \code{\link{R6Class}} object.
#' @note abstract super class of all the unary logical operation classes
UnaryLogicOpType <-  R6Class("UnaryLogicOpType",
  inherit = OGCExpression,
  public = list(
    #'@field operations a list OGC expressions
    operations = list(),
    
    #'@description Initializes a \link{UnaryLogicOpType} expression
    #'@param ... list of objects of class \link{OGCExpression}
    #'@param element element
    #'@param namespacePrefix namespacePrefix
    #'@param exprVersion OGC expression version. Default is "1.1.0"
    initialize = function(..., element, namespacePrefix, exprVersion = "1.1.0"){
      super$initialize(element = element, namespacePrefix = namespacePrefix, exprVersion = exprVersion)
      self$operations = list(...)
      self$setExprVersion(exprVersion)
    },
    
    #'@description Sets expression version. The methods will control that expression versions are set
    #' for each of the operations specified in the expression.
    #'@param exprVersion OGC expression version
    setExprVersion = function(exprVersion){
      private$exprVersion <- exprVersion
      if(length(self$operations)>0) for(i in 1:length(self$operations)){
        self$operations[[i]]$setExprVersion(exprVersion)
      }
    }
  )
)

#' Not
#' @docType class
#' @export
#' @keywords OGC Expression UnaryLogicOpType Not
#' @return Object of \code{\link{R6Class}} for modelling an Not
#' @format \code{\link{R6Class}} object.
#' 
#' @examples
#'   expr <- PropertyIsEqualTo$new(PropertyName = "property", Literal = "value")
#'   not <- Not$new(expr)
#'   not_xml <- not$encode() #see how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
Not <-  R6Class("Not",
   inherit = UnaryLogicOpType,
   private = list(
     xmlElement = "Not",
     xmlNamespacePrefix = "OGC"
   ),
   public = list(
     
     #'@description Initializes an \link{Not} expression
     #'@param ... list of objects of class \link{OGCExpression}
     initialize = function(...){
       super$initialize(..., element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix)
     }
   )
)
