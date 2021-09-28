#' OWSBoundingBox
#'
#' @docType class
#' @export
#' @keywords OGC OWS boundingbox
#' @return Object of \code{\link{R6Class}} for modelling an OGC Bounding Box
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, element, namespacePrefix, owsVersion, serviceVersion, logger)}}{
#'    This method is used to instantiate an \code{OWSBoundingBox} object
#'  }
#'  \item{\code{getBBOX()}}{
#'    Get BBOX as object of class \code{bbox} from \pkg{sf} package
#'  }
#' }
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSBoundingBox <-  R6Class("OWSBoundingBox",
   inherit = OGCAbstractObject,
   private = list(
      xmlElement = "BoundingBox",
      xmlNamespacePrefix = "OWS" 
   ),
   public = list(
     attrs = list(),
     LowerCorner = matrix(NA,1,2),
     UpperCorner = matrix(NA,1,2),
     initialize = function(xml = NULL, 
                           element = NULL, namespacePrefix = NULL,
                           owsVersion, serviceVersion, 
                           logger = NULL, ...) {
      if(!is.null(element)) private$xmlElement <- element
      if(!is.null(namespacePrefix)){
         private$xmlNamespacePrefix <- namespacePrefix
         private$xmlNamespacePrefix <- paste0(private$xmlNamespacePrefix,"_",gsub("\\.","_",serviceVersion))
      }else{
         private$xmlNamespacePrefix <- paste0(private$xmlNamespacePrefix,"_",gsub("\\.","_",owsVersion))
      }
      
      super$initialize(element = private$xmlElement, namespacePrefix = private$xmlNamespacePrefix, logger = logger) 
      
      if(!is.null(xml)){
         self$decode(xml)
      }
      
     },
     
     #decode
     decode = function(xml){
        self$attrs$crs <- xmlGetAttr(xml, "crs")
        params <- xmlChildren(xml)
        
        if("pos" %in% names(params)){
           params$LowerCorner <- params[[1]]
           params$UpperCorner <- params[[2]]
        }
        
        lc_values <- unlist(strsplit(xmlValue(params$LowerCorner), " "))
        lc_coerceable <- !is.na(suppressWarnings(as.numeric(lc_values)))
        lc_values <- lapply(1:length(lc_values), function(i){
           out <- lc_values[i]
           if(lc_coerceable[i]) out <- as.numeric(out)
           return(out)
        })
        self$LowerCorner <- t(matrix(lc_values))
        
        uc_values <- unlist(strsplit(xmlValue(params$UpperCorner), " "))
        uc_coerceable <- !is.na(suppressWarnings(as.numeric(uc_values)))
        uc_values <- lapply(1:length(uc_values), function(i){
           out <- uc_values[i]
           if(uc_coerceable[i]) out <- as.numeric(out)
           return(out)
        })
        self$UpperCorner <- t(matrix(uc_values))
     },
     
     #getBBOX
     getBBOX = function(){
       sf::st_bbox(c(
         xmin = self$LowerCorner[[1]], 
         ymin = self$LowerCorner[[2]],
         xmax = self$UpperCorner[[1]], 
         ymax = self$UpperCorner[[2]] 
       ), crs = sf::st_crs(4326))
     }
   )
)