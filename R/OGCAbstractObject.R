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
#' @note abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OGCAbstractObject <-  R6Class("OGCAbstractObject",
  private = list(
    xmlElement = NULL,
    xmlNamespace = NULL,
    system_fields = c("verbose.info", "verbose.debug", "loggerType",
                      "wrap", "attrs","defaults"),
    xmlNodeToCharacter = function (x, ..., indent = "", tagSeparator = "\n") 
    {
      out <- ""
      if (length(xmlAttrs(x))) {
        tmp <- paste(names(xmlAttrs(x)), paste("\"", XML:::insertEntities(xmlAttrs(x)), 
                                               "\"", sep = ""), sep = "=", collapse = " ")
      } else{
        tmp <- ""
      }
      if (length(x$namespaceDefinitions) > 0) {
        k = as(x$namespaceDefinitions, "character")
        ns = paste("xmlns", ifelse(nchar(names(k)), ":", ""), 
                   names(k), "=", ddQuote(k), sep = "", collapse = " ")
      } else{
        ns <- ""
      }
      subIndent <- paste(indent, " ", sep = "")
      if (is.logical(indent) && !indent) {
        indent <- ""
        subIndent <- FALSE
      }
      if (length(xmlChildren(x)) == 0) {
        out <- paste(out,indent, paste("<", xmlName(x, TRUE), ifelse(tmp != 
                                                                       "", " ", ""), tmp, ifelse(ns != "", " ", ""), ns, 
                                       "/>", tagSeparator, sep = ""), sep = "")
      } else if (length(xmlChildren(x)) == 1 && inherits(xmlChildren(x)[[1]], "XMLTextNode")) {
        out <- paste(out,indent, paste("<", xmlName(x, TRUE), ifelse(tmp != 
                                                                       "", " ", ""), tmp, ifelse(ns != "", " ", ""), ns, 
                                       ">", sep = ""), sep = "")
        kid = xmlChildren(x)[[1]]
        if (inherits(kid, "EntitiesEscaped")) 
          txt = xmlValue(kid)
        else txt = XML:::insertEntities(xmlValue(kid))
        out <- paste(out,txt, sep = "")
        out <- paste(out,paste("</", xmlName(x, TRUE), ">", tagSeparator, 
                               sep = ""), sep = "")
      } else {
        out <- paste(out,indent, paste("<", xmlName(x, TRUE), ifelse(tmp != 
                                                                       "", " ", ""), tmp, ifelse(ns != "", " ", ""), ns, 
                                       ">", tagSeparator, sep = ""), sep = "")
        for (i in xmlChildren(x)){
          out_child <- NULL
          if(is(i,"XMLNode")){
            if(is(i,"XMLCommentNode")){
              out_child <- paste0(capture.output(i),collapse="")
            }else{
              out_child <- private$xmlNodeToCharacter(i)
            }
          }else{
            out_child <- paste(as(i,"character"),tagSeparator,sep="")
          }
          if(!is.null(out_child)) out <- paste(out, out_child, sep="") 
        }
        out<-paste(out,indent, paste("</", xmlName(x, TRUE), ">", tagSeparator, 
                                     sep = ""), sep = "")
      }
      return(out)
    },
    #fromComplexTypes
    fromComplexTypes = function(value){
      #datetime types
      if(suppressWarnings(all(class(value)==c("POSIXct","POSIXt")))){
        tz <- attr(value, "tzone")
        if(length(tz)>0){
          if(tz %in% c("UTC","GMT")){
            value <- format(value,"%Y-%m-%dT%H:%M:%S")
            value <- paste0(value,"Z")
          }else{
            utc_offset <- format(value, "%z")
            utc_offset <- paste0(substr(utc_offset,1,3),":",substr(utc_offset,4,5))
            value <- paste0(format(value,"%Y-%m-%dT%H:%M:%S"), utc_offset)
          }
        }else{
          value <- format(value,"%Y-%m-%dT%H:%M:%S")
        }
      }else if(class(value)[1] == "Date"){
        value <- format(value,"%Y-%m-%d")
      }
      
      return(value)
    }
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
    encode = function(addNS = TRUE, geometa_validate = TRUE, geometa_inspire = FALSE){
      
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
        (class(self[[x]])[1] %in% c("environment", "function")) ||
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
                attrs = fieldObj$attrs
              )
              wrapperNode$addNode(fieldObjXml)
              rootXML$addNode(wrapperNode$value())
            }else{
              rootXML$addNode(fieldObjXml)
            }
          }else if(is(fieldObj, "ISOAbstractObject")){
            fieldObjXml <- fieldObj$encode(validate = geometa_validate, inspire = geometa_inspire)
            fieldObjXml <- as(fieldObjXml, "character")
            fieldObjXml <- gsub("<\\?xml.*?\\?>", "", fieldObjXml)
            #fieldObjXml <- gsub("<!--.*?-->", "", fieldObjXml)
            fieldObjXml <- xmlRoot(xmlParse(fieldObjXml, encoding = "UTF-8"))
            if(fieldObj$wrap){ 
              wrapperNode <- xmlOutputDOM(
                tag = field,
                nameSpace = names(private$xmlNamespace)[1],
                attrs = fieldObj$attrs
              )
              wrapperNode$addNode(fieldObjXml)
              rootXML$addNode(wrapperNode$value())
            }else{
              rootXML$addNode(fieldObjXml)
            }
          }else if(is(fieldObj, "list")){
            if(self$wrap){
              wrapperNode <- xmlOutputDOM(
                tag = field,
                nameSpace = names(private$xmlNamespace)[1]
              )
              for(item in fieldObj){
                if(!is.null(item)){
                  fieldObjXml <- NULL
                  if(is(item,"ISOAbstractObject")){
                    fieldObjXml <- item$encode(validate = geometa_validate, inspire = geometa_inspire)
                    fieldObjXml <- as(fieldObjXml, "character")
                    fieldObjXml <- gsub("<\\?xml.*?\\?>", "", fieldObjXml)
                    #fieldObjXml <- gsub("<!--.*?-->", "", fieldObjXml)
                    fieldObjXml <- xmlRoot(xmlParse(fieldObjXml, encoding = "UTF-8"))
                  }else{
                    fieldObjXml <- item$encode()
                  }
                  wrapperNode$addNode(as(fieldObjXml, "XMLInternalNode"))
                }
              }
              rootXML$addNode(wrapperNode$value())
            }else{
              for(item in fieldObj){
                if(!is.null(item)){
                  fieldObjXml <- NULL
                  if(is(item,"ISOAbstractObject")){
                    fieldObjXml <- item$encode(validate = geometa_validate, inspire = geometa_inspire)
                    fieldObjXml <- as(fieldObjXml, "character")
                    fieldObjXml <- gsub("<\\?xml.*?\\?>", "", fieldObjXml)
                    #fieldObjXml <- gsub("<!--.*?-->", "", fieldObjXml)
                    fieldObjXml <- xmlRoot(xmlParse(fieldObjXml, encoding = "UTF-8"))
                  }else{
                    fieldObjXml <- item$encode()
                  }
                  rootXML$addNode(as(fieldObjXml, "XMLInternalNode"))
                }
              }
            }
          }else{
            if(field == "value"){
              if(is.logical(fieldObj)) fieldObj <- tolower(as.character(is.logical(fieldObj)))
              fieldObj <- private$fromComplexTypes(fieldObj)
              rootXML$addNode(xmlTextNode(fieldObj))
            }else{
              wrapperNode <- xmlOutputDOM(tag = field, nameSpace = names(private$xmlNamespace)[1])
              wrapperNode$addNode(xmlTextNode(fieldObj))
              rootXML$addNode(wrapperNode$value())
            }
          }
        }
      }
      out <- rootXML$value()
      out <- private$xmlNodeToCharacter(out)
      if(Encoding(out)!="UTF-8") out <- iconv(out, to = "UTF-8")
      out <- xmlParse(out, encoding = Encoding(out), error = function (msg, ...) {})
      out <- as(out, "XMLInternalNode") #to XMLInternalNode
      if(length(rootXMLAttrs)>0){
        suppressWarnings(xmlAttrs(out) <- rootXMLAttrs)
      }
      return(out)
    }
  )
)