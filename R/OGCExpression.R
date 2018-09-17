#' OGCExpression
#' @docType class
#' @export
#' @keywords OGC Expression
#' @return Object of \code{\link{R6Class}} for modelling an OGC Expression
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new()}}{
#'    This method is used to instantiate an OGCExpression object
#'  }
#' }
#' 
#' @note abstract class
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OGCExpression <-  R6Class("OGCExpression",
   inherit = OGCAbstractObject,
   private = list(
     exprVersion = "1.1.0",
     xmlNamespaceBase = "http://www.opengis.net/ogc",
     xmlNamespace = c(ogc = "http://www.opengis.net/ogc")
   ),
   public = list(
     initialize = function(attrs = NULL, defaults = NULL, exprVersion = "1.1.0"){
       self$setExprVersion(exprVersion)
       super$initialize(attrs,defaults)
     },
     
     #setExprVersion
     setExprVersion = function(exprVersion) {
       private$exprVersion = exprVersion
       if(exprVersion=="2.0"){
         private$xmlNamespace = "http://www.opengis.net/fes/2.0"
         names(private$xmlNamespace) <- "fes"
       }else{
         private$xmlNamespace = private$xmlNamepaceBase
         names(private$xmlNamespace) = "ogc"
       }
     },
     
     #getExprVersion
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName, Literal, matchCase)}}{
#'    This method is used to instantiate an BinaryComparisonOpType
#'  }
#' }
#' @note abstract super class of all the property operation classes
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
BinaryComparisonOpType <-  R6Class("BinaryComparisonOpType",
  inherit = OGCExpression,
  public = list(
    PropertyName = NULL,
    Literal = NULL,
    attrs = list(matchCase = NA),
    initialize = function(PropertyName, Literal, matchCase = NA){
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName, Literal, matchCase)}}{
#'    This method is used to instantiate an PropertyIsEqualTo
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsEqualTo$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsEqualTo <-R6Class("PropertyIsEqualTo",
  inherit = BinaryComparisonOpType,
  private = list(xmlElement = "PropertyIsEqualTo"),
  public = list(
    initialize = function(PropertyName, Literal, matchCase = NA){
      super$initialize(PropertyName, Literal, matchCase)
    }
  )
)

#' PropertyIsNotEqualTo
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsNotEqualTo
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsNotEqualTo
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName, Literal, matchCase)}}{
#'    This method is used to instantiate an PropertyIsNotEqualTo
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsNotEqualTo$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
PropertyIsNotEqualTo <-R6Class("PropertyIsNotEqualTo",
  inherit = BinaryComparisonOpType,
  private = list(xmlElement = "PropertyIsNotEqualTo"),
  public = list(
    initialize = function(PropertyName, Literal, matchCase = NA){
      super$initialize(PropertyName, Literal, matchCase)
    }
  )
)

#' PropertyIsLessThan
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsLessThan
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsLessThan
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName, Literal, matchCase)}}{
#'    This method is used to instantiate an PropertyIsLessThan
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsLessThan$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsLessThan <-R6Class("PropertyIsLessThan",
   inherit = BinaryComparisonOpType,
   private = list(xmlElement = "PropertyIsLessThan"),
   public = list(
     initialize = function(PropertyName, Literal, matchCase = NA){
       super$initialize(PropertyName, Literal, matchCase)
     }
   )
)

#' PropertyIsGreaterThan
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsGreaterThan
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsGreaterThan
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName, Literal, matchCase)}}{
#'    This method is used to instantiate an PropertyIsGreaterThan
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsGreaterThan$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsGreaterThan <-R6Class("PropertyIsGreaterThan",
   inherit = BinaryComparisonOpType,
   private = list(xmlElement = "PropertyIsGreaterThan"),
   public = list(
     initialize = function(PropertyName, Literal, matchCase = NA){
       super$initialize(PropertyName, Literal, matchCase)
     }
   )
)

#' PropertyIsLesserThanOrEqualTo
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsLesserThanOrEqualTo
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsLesserThanOrEqualTo
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName, Literal, matchCase)}}{
#'    This method is used to instantiate an PropertyIsLesserThanOrEqualTo
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsLessThanOrEqualTo$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsLessThanOrEqualTo <-R6Class("PropertyIsLessThanOrEqualTo",
 inherit = BinaryComparisonOpType,
 private = list(xmlElement = "PropertyIsLessThanOrEqualTo"),
 public = list(
   initialize = function(PropertyName, Literal, matchCase = NA){
     super$initialize(PropertyName, Literal, matchCase)
   }
 )
)

#' PropertyIsGreaterThanOrEqualTo
#' @docType class
#' @export
#' @keywords OGC Expression BinaryComparisonOpType PropertyIsGreaterThanOrEqualTo
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsGreaterThanOrEqualTo
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName, Literal, matchCase)}}{
#'    This method is used to instantiate an PropertyIsGreaterThanOrEqualTo
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsGreaterThanOrEqualTo$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsGreaterThanOrEqualTo <-R6Class("PropertyIsGreaterThanOrEqualTo",
  inherit = BinaryComparisonOpType,
  private = list(xmlElement = "PropertyIsGreaterThanOrEqualTo"),
  public = list(
    initialize = function(PropertyName, Literal, matchCase = NA){
      super$initialize(PropertyName, Literal, matchCase)
    }
  )
)

#' PropertyIsLike
#' @docType class
#' @export
#' @keywords OGC Expression PropertyIsLike
#' @return Object of \code{\link{R6Class}} for modelling an PropertyIsLike
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyOperator, PropertyName, Literal,
#'                  escapeChar, singleChar, wildCard, matchCase)}}{
#'    This method is used to instantiate an PropertyIsLike
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsLike$new(PropertyName = "property", Literal = "value")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsLike <-  R6Class("PropertyIsLike",
   inherit = OGCExpression,
   private = list(xmlElement = "PropertyIsLike"),
   public = list(
     PropertyName = NULL,
     Literal = NULL,
     attrs = list(
      escapeChar = "\\",
      singleChar = "_",
      wildCard = "%",
      matchCase = NA
     ),
     initialize = function(PropertyName, Literal,
                           escapeChar = "\\", singleChar = "_", wildCard = "%", matchCase = NA){
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName)}}{
#'    This method is used to instantiate an PropertyIsNull
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsNull$new(PropertyName = "property")
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
PropertyIsNull <-  R6Class("PropertyIsNull",
   inherit = OGCExpression,
   private = list(xmlElement = "PropertyIsNull"),
   public = list(
     PropertyName = NULL,
     initialize = function(PropertyName){
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(PropertyName, lower, upper)}}{
#'    This method is used to instantiate an PropertyIsBetween
#'  }
#' }
#' 
#' @examples
#'   expr <- PropertyIsBetween$new(PropertyName = "property", lower = 1, upper = 10)
#'   expr_xml <- expr$encode() #see how it looks like in XML
#'   
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
PropertyIsBetween <-  R6Class("PropertyIsBetween",
   inherit = OGCExpression,
   private = list(xmlElement = "PropertyIsBetween"),
   public = list(
     PropertyName = NULL,
     lower = NULL,
     upper = NULL,
     initialize = function(PropertyName, lower, upper){
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(bbox, srsName)}}{
#'    This method is used to instantiate an BBOX
#'  }
#' }
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
  private = list(xmlElement = "BBOX"),
  public = list(
    PropertyName = "ows:BoundingBox",
    Envelope = NULL,
    initialize = function(bbox, srsName = NULL){
      envelope <- GMLEnvelope$new(bbox = bbox, srsName = srsName)
      envelope$wrap <- FALSE
      gmlNS <- envelope$getNamespaceDefinition()
      private$xmlNamespace = c(private$xmlNamespace, ns = gmlNS$gml)
      names(private$xmlNamespace)[length(private$xmlNamespace)] <- names(gmlNS)
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(...)}}{
#'    This method is used to instantiate an BinaryLogicOpType
#'  }
#' }
#' @note abstract super class of all the binary logical operation classes
BinaryLogicOpType <-  R6Class("BinaryLogicOpType",
   inherit = OGCExpression,
   public = list(
     operations = list(),
     initialize = function(...){
       operations <- list(...)
       if(length(operations)<2){
         stop("Binary operations (And / Or) require a minimum of two operations")
       }
       self$operations = operations
     },
     
     #setExprVersion
     setExprVersion = function(exprVersion){
       private$exprVersion <- exprVersion
       for(i in 1:length(self$operations)){
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(...)}}{
#'    This method is used to instantiate an And operator
#'  }
#' }
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
  private = list(xmlElement = "And"),
  public = list(
    initialize = function(...){
      super$initialize(...)
    }
  )
)

#' Or
#' @docType class
#' @export
#' @keywords OGC Expression BinaryLogicOpType Or
#' @return Object of \code{\link{R6Class}} for modelling an Or operator
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(...)}}{
#'    This method is used to instantiate an Or operator
#'  }
#' }
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
  private = list(xmlElement = "Or"),
  public = list(
    initialize = function(...){
      super$initialize(...)
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(...)}}{
#'    This method is used to instantiate an UnaryLogicOpType
#'  }
#' }
#' @note abstract super class of all the unary logical operation classes
UnaryLogicOpType <-  R6Class("UnaryLogicOpType",
  inherit = OGCExpression,
  public = list(
    operations = list(),
    initialize = function(...){
      self$operations = list(...)
    },
    
    #setExprVersion
    setExprVersion = function(exprVersion){
      private$exprVersion <- exprVersion
      for(i in 1:length(self$operations)){
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
#' @section Methods:
#' \describe{
#'  \item{\code{new(...)}}{
#'    This method is used to instantiate an Not operator
#'  }
#' }
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
   private = list(xmlElement = "Not"),
   public = list(
     initialize = function(...){
       super$initialize(...)
     }
   )
)
