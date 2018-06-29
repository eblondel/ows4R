#' OGCAbstractObject
#' @docType class
#' @export
#' @keywords OGC Abstract Object
#' @return Object of \code{\link{R6Class}} for modelling an OGCAbstractObject
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new()}}{
#'    This method is used to instantiate an OGCAbstractObject
#'  }
#' }
#' @note abstract class
OGCAbstractObject <-  R6Class("OGCAbstractObject",
  private = list(
    xmlElement = NULL,
    xmlNamespace = NULL,
    system_fields = c("verbose.info", "verbose.debug", "loggerType",
                      "wrap", "attrs","defaults")
  ),
  public = list(
    #logger
    verbose.info = FALSE,
    verbose.debug = FALSE,
    loggerType = NULL,
    logger = function(type, text){
      if(self$verbose.info){
        cat(sprintf("[ows4R][%s] %s - %s \n", type, self$getClassName(), text))
      }
    },
    INFO = function(text){self$logger("INFO", text)},
    WARN = function(text){self$logger("WARN", text)},
    ERROR = function(text){self$logger("ERROR", text)},
    
    wrap = FALSE,
    defaults = list(),
    attrs = list(),
    
    initialize = function(attrs = list(), defaults = list(),
                          wrap = FALSE, logger = NULL){
      
      self$attrs = attrs
      self$defaults = defaults
      self$wrap = wrap
      
      #logger
      if(!missing(logger)){
        if(!is.null(logger)){
          self$loggerType <- toupper(logger)
          if(!(self$loggerType %in% c("INFO","DEBUG"))){
            stop(sprintf("Unknown logger type '%s", logger))
          }
          if(self$loggerType == "INFO"){
            self$verbose.info = TRUE
          }else if(self$loggerType == "DEBUG"){
            self$verbose.info = TRUE
            self$verbose.debug = TRUE
          }
        }
      }
    },
    
    #getClassName
    getClassName = function(){
      return(class(self)[1])
    },
    
    #getClass
    getClass = function(){
      class <- eval(parse(text=self$getClassName()))
      return(class)
    },
    
    #encode
    encode = function(addNS = TRUE){
      
      if(is.null(private$xmlElement) | is.null(private$xmlNamespace)){
        stop("Cannot encode an object of an abstract class!")
      }
      
      #list of fields to encode as XML
      fields <- rev(names(self))
      
      #root XML
      rootXML <- NULL
      rootXMLAttrs <- list()
      if("attrs" %in% fields){
        rootXMLAttrs <- self[["attrs"]]
        rootXMLAttrs <- rootXMLAttrs[!is.na(rootXMLAttrs)]
      }
      
      #fields
      fields <- fields[!sapply(fields, function(x){
        (class(self[[x]]) %in% c("environment", "function")) ||
          (x %in% private$system_fields)
      })]
      
      if(addNS){
        rootXML <- xmlOutputDOM(
          tag = private$xmlElement,
          nameSpace = names(private$xmlNamespace)[1],
          nsURI = as.list(private$xmlNamespace),
          attrs = self$attrs
        )
      }else{
        rootXML <- xmlOutputDOM(
          tag = private$xmlElement,
          nameSpace = names(private$xmlNamespace)[1],
          attrs = self$attrs
        )
      }
      
      for(field in fields){
        fieldObj <- self[[field]]
        
        #default values management
        if(is.null(fieldObj) || (is.list(fieldObj) & length(fieldObj)==0)){
          if(field %in% names(self$defaults)){
            fieldObj <- self$defaults[[field]]
          }
        }
        
        #user values management
        if(!is.null(fieldObj)){
          if(is(fieldObj, "OGCAbstractObject")){
            fieldObjXml <- fieldObj$encode()
            if(fieldObj$wrap){ 
              wrapperNode <- xmlOutputDOM(
                tag = field,
                nameSpace = names(private$xmlNamespace)[1],
                attrs = field$attrs
              )
              if(!fieldObj$isNull) wrapperNode$addNode(fieldObjXml)
              rootXML$addNode(wrapperNode$value())
            }else{
              rootXML$addNode(fieldObjXml)
            }
          }else if(is(fieldObj, "ISOAbstractObject")){
            fieldObjXml <- fieldObj$encode()
            fieldObjXml <- as(fieldObjXml, "character")
            fieldObjXml <- gsub("<\\?xml.*?\\?>", "", fieldObjXml)
            fieldObjXml <- gsub("<!--.*?-->", "", fieldObjXml)
            fieldObjXml <- xmlRoot(xmlParse(fieldObjXml, encoding = "UTF-8"))
            if(fieldObj$wrap){ 
              wrapperNode <- xmlOutputDOM(
                tag = field,
                nameSpace = names(private$xmlNamespace)[1],
                attrs = fieldObj$attrs
              )
              if(!fieldObj$isNull) wrapperNode$addNode(fieldObjXml)
              rootXML$addNode(wrapperNode$value())
            }else{
              rootXML$addNode(fieldObjXml)
            }
          }else if(is(fieldObj, "list")){
            wrapperNode <- xmlOutputDOM(
              tag = field,
              nameSpace = names(private$xmlNamespace)[1]
            )
            for(item in fieldObj){
              if(!is.null(item)){
                nodeValueXml <- item$encode()
                wrapperNode$addNode(as(nodeValueXml, "XMLInternalNode"))
              }
            }
            rootXML$addNode(wrapperNode$value())
          }else{
            wrapperNode <- xmlOutputDOM(tag = field, nameSpace = names(private$xmlNamespace)[1])
            wrapperNode$addNode(xmlTextNode(fieldObj))
            rootXML$addNode(wrapperNode$value())
          }
        }
      }
      out <- rootXML$value()
      out <- as(out, "XMLInternalNode")
      if(length(rootXMLAttrs)>0){
        suppressWarnings(xmlAttrs(out) <- rootXMLAttrs)
      }
      return(out)
    }
  )
)