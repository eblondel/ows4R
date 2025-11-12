#' OGCAbstractObject
#' @docType class
#' @export
#' @keywords OGC Abstract Object
#' @return Object of \code{\link[R6]{R6Class}} for modelling an OGCAbstractObject
#' @format \code{\link[R6]{R6Class}} object.
#'
#' @note abstract class used by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
OGCAbstractObject <-  R6Class("OGCAbstractObject",
  private = list(
    xmlElement = "AbstractObject",
    xmlNamespacePrefix = "OWS",
    xmlExtraNamespaces = c(),
    system_fields = c("verbose.info", "verbose.debug", "loggerType",
                      "wrap", "element", "namespace", "attrs","defaults"),
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
      } else if (length(xmlChildren(x)) == 1 && inherits(xmlChildren(x)[[1]], "XMLCDataNode")) {
        out <- paste(out,indent, paste("<", xmlName(x, TRUE), ifelse(tmp != 
                                                                       "", " ", ""), tmp, ifelse(ns != "", " ", ""), ns, 
                                       ">", sep = ""), sep = "")
        kid = xmlChildren(x)[[1]]
        txt = xmlValue(kid)
        txt <- paste("<![CDATA[", txt, "]]>", sep="")
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
    #'@field verbose.info \code{logical} property to indicate whether INFO logs have to be displayed
    verbose.info = FALSE,
    #'@field verbose.debug \code{logical} property to indicate whether DEBUG logs have to be displayed
    verbose.debug = FALSE,
    #'@field loggerType logger type, either \code{NULL}, "INFO", or "DEBUG"
    loggerType = NULL,
    
    #'@description A basic logger function
    #'@param type type of logs message.
    #'@param text log message text to be displayed
    logger = function(type, text){
      if(self$verbose.info){
        cat(sprintf("[ows4R][%s] %s - %s \n", type, self$getClassName(), text))
      }
    },
    
    #'@description a basic INFO logger function
    #'@param text log message text to be displayed
    INFO = function(text){self$logger("INFO", text)},
    
    #'@description a basic WARN logger function
    #'@param text log message text to be displayed
    WARN = function(text){self$logger("WARN", text)},
    
    #'@description a basic ERROR logger function
    #'@param text log message text to be displayed
    ERROR = function(text){self$logger("ERROR", text)},
    
    #'@field wrap internal property for XML encoding
    wrap = FALSE,
    #'@field element element used for XML encoding
    element = NULL,
    #'@field namespace namespace used for XML encoding
    namespace = NULL,
    #'@field defaults default values to be used for XML encoding
    defaults = list(),
    #'@field attrs attributes to be used for XML encoding
    attrs = list(),
    
    #'@description Initializes an object extending \link{OGCAbstractObject}
    #'@param xml object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'@param element element name
    #'@param namespacePrefix namespace prefix for XML encoding
    #'@param attrs list of attributes
    #'@param defaults list of default values
    #'@param wrap whether XML element has to be wrapped during XML encoding
    #'@param logger logger
    initialize = function(xml = NULL, element = NULL, namespacePrefix = NULL,
                          attrs = list(), defaults = list(),
                          wrap = FALSE, logger = NULL){
      if(!is.null(element)){ private$xmlElement <- element }
      if(!is.null(namespacePrefix)){ private$xmlNamespacePrefix <- namespacePrefix}
      self$element = private$xmlElement
      self$namespace = getOWSNamespace(private$xmlNamespacePrefix)
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
    
    #'@description Get class name
    #'@return an object of class \code{character}
    getClassName = function(){
      return(class(self)[1])
    },
    
    #'@description Get class
    #'@return an object of class \code{R6Class}
    getClass = function(){
      class <- try(eval(parse(text = self$getClassName())), silent = TRUE)
      if(is(class, "try-error")) class <- try(eval(parse(text = paste0("ows4R::",self$getClassName()))), silent = TRUE)
      return(class)
    },
    
    #'@description Utility to return the parent class in which field is defined 
    #'@param field field name
    #'@return object of class \code{R6Class}
    isFieldInheritedFrom = function(field){
      parentClass <- NULL
      inherited <- !(field %in% names(self$getClass()$public_fields))
      if(inherited){
        classes <- class(self)
        classes <- classes[c(-1,-length(classes))]
        for(i in 1:length(classes)){
          cl <- eval(parse(text=classes[i]))
          if(field %in% names(cl$public_fields)){
            parentClass <- cl
            break
          }
        }
      }
      return(parentClass)
    },
    
    #'@description Gets the namespace definition
    #'@param recursive Get all namespace recursively
    #'@return the namespace definitions as named \code{list}
    getNamespaceDefinition = function(recursive = FALSE){
      nsdefs <- NULL
      
      if(recursive){
        #list of fields
        fields <- rev(names(self))
        fields <- fields[!sapply(fields, function(x){
          (class(self[[x]])[1] %in% c("environment", "function")) ||
            (x %in% private$system_fields)
        })]
        
        selfNsdef <- self$getNamespaceDefinition()
        nsdefs <- list()
        if(length(fields)>0){
          invisible(lapply(fields, function(x){
            xObj <- self[[x]]
            if(is.null(xObj) || (is.list(xObj) & length(xObj) == 0)){
              if(x %in% names(self$defaults)){
                xObj <- self$defaults[[x]]
              }
            }
            hasContent <- !is.null(xObj)
            if(is(xObj, "OGCAbstractObject")){
              hasContent <- any(hasContent, length(xObj$attrs)>0)
            }
            if(hasContent){
              
              #add parent namespaces if any parent field
              if(x != "value"){
                klass <- self$isFieldInheritedFrom(x)
                if(!is.null(klass)){
                  if(!is.null(klass$private_fields$xmlNamespacePrefix)){
                    ns <- OWSNamespace[[klass$private_fields$xmlNamespacePrefix]]$getDefinition()
                    if(!(ns %in% nsdefs)){
                      nsdefs <<- c(nsdefs, ns)
                    }
                  }
                }
              }
              
              #add namespaces
              nsdef <- NULL
              if(is(xObj, "OGCAbstractObject")){
                nsdef <- xObj$getNamespaceDefinition(recursive = recursive)
              }else if(is(xObj, "list")){
                nsdef <- list()
                invisible(lapply(xObj, function(xObj.item){
                  nsdef.item <- NULL
                  if(is(xObj.item, "OGCAbstractObject")){
                    nsdef.item <- xObj.item$getNamespaceDefinition(recursive = recursive)
                  }
                  for(item in names(nsdef.item)){
                    nsd <- nsdef.item[[item]]
                    if(!(nsd %in% nsdef)){
                      nsdef.new <- c(nsdef, nsd)
                      names(nsdef.new) <- c(names(nsdef), item)
                      nsdef <<- nsdef.new
                    }
                  }
                }))
              }else{
                if(!startsWith(names(selfNsdef)[1],"gml")){
                  nsdef <- OWSNamespace$OWS_1_1$getDefinition()
                }
              }
              for(item in names(nsdef)){
                nsdef.item <- nsdef[[item]]
                if(!(nsdef.item %in% nsdefs)){
                  nsdefs.new <- c(nsdefs, nsdef.item)
                  names(nsdefs.new) <- c(names(nsdefs), item)
                  nsdefs <<- nsdefs.new
                }
              }
            }
          }))
        }
        if(!(selfNsdef[[1]] %in% nsdefs)) nsdefs <- c(selfNsdef, nsdefs)
        nsdefs <- nsdefs[!sapply(nsdefs, is.null)]
      }else{
        nsdefs <- self$namespace$getDefinition()
      }
      
      invisible(lapply(names(self$attrs), function(attr){
        str <- unlist(strsplit(attr,":", fixed=T))
        if(length(str)>1){
          nsprefix <- str[1]
          namespace <- OWSNamespace[[toupper(nsprefix)]]
          if(!is.null(namespace)){
            ns <- namespace$getDefinition()
            if(!(ns %in% nsdefs)) nsdefs <<- c(nsdefs, ns)
          }
        }
      }))
      #add extra namespaces?
      if(length(private$xmlExtraNamespaces)>0){
        nsdefs <- c(nsdefs, private$xmlExtraNamespaces)
      }
      #get rid of duplicates
      nsdefs <- nsdefs[!duplicated(names(nsdefs))]
      
      return(nsdefs)
    },
    
    #'@description Encodes as XML. The \code{addNS} .
    #'    Extra parameters related to \pkg{geometa} objects: \code{geometa_validate} (TRUE by default) and \code{geometa_inspire} 
    #'    (FALSE by default) can be used to perform ISO and INSPIRE validation respectively.
    #'@param addNS addNS controls the addition of XML namespaces
    #'@param geometa_validate Relates to \pkg{geometa} object ISO validation. Default is \code{TRUE}
    #'@param geometa_inspire Relates to \pkg{geometa} object INSPIRE validation. Default is \code{FALSE}
    #'@param geometa_inspireValidator Relates to \pkg{geometa} object INSPIRE validation. Default is \code{NULL}. Deprecated, see
    #'below note.
    #'@return an object of class \link[XML]{XMLInternalNode-class} from \pkg{XML}
    #'
    #'@note From 2025-05-02, the INSPIRE metadata validation does not require anymore an API Key. Therefore, it is not
    #'required to specify an \code{geometa_inspireValidator}. To send your metadata to INSPIRE, just set \code{geometa_inspire} 
    #'to \code{TRUE}.
    encode = function(addNS = TRUE, geometa_validate = TRUE, 
                      geometa_inspire = FALSE, geometa_inspireValidator = NULL){
      
      if(is.null(private$xmlElement) | is.null(private$xmlNamespacePrefix)){
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
        nsdefs <- self$getNamespaceDefinition(recursive = TRUE)
        if(!("xsi" %in% names(nsdefs))) nsdefs <- c(nsdefs, OWSNamespace$XSI$getDefinition())
        if(!("xlink" %in% names(nsdefs))) nsdefs <- c(nsdefs, OWSNamespace$XLINK$getDefinition())
        nsdefs <- nsdefs[order(names(nsdefs))]
        rootXML <- xmlOutputDOM(
          tag = self$element,
          nameSpace = self$namespace$id,
          nsURI = nsdefs
        )
      }else{
        rootXML <- xmlOutputDOM(
          tag = self$element,
          nameSpace = self$namespace$id
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
        ns <- self$namespace$getDefinition()
        if(field != "value"){
          klass <- self$isFieldInheritedFrom(field)
          if(!is.null(klass)) if(!is.null(klass$private_fields$xmlNamespacePrefix)){
            ns <- OWSNamespace[[klass$private_fields$xmlNamespacePrefix]]$getDefinition()
          }
        }
        namespaceId <- names(ns)
        if(!is.null(fieldObj)){
          if(is(fieldObj, "OGCAbstractObject")){
            fieldObjXml <- fieldObj$encode(addNS = FALSE)
            if(fieldObj$wrap){ 
              wrapperNode <- xmlOutputDOM(
                tag = field,
                nameSpace = namespaceId
              )
              wrapperNode$addNode(fieldObjXml)
              rootXML$addNode(wrapperNode$value())
            }else{
              rootXML$addNode(fieldObjXml)
            }
          }else if(is(fieldObj, "ISOAbstractObject")){
            fieldObjXml <- fieldObj$encode(validate = geometa_validate, 
                                           inspire = geometa_inspire, inspireValidator = geometa_inspireValidator)
            fieldObjXml <- as(fieldObjXml, "character")
            fieldObjXml <- gsub("<\\?xml.*?\\?>", "", fieldObjXml)
            #fieldObjXml <- gsub("<!--.*?-->", "", fieldObjXml)
            fieldObjXml <- xmlRoot(xmlParse(fieldObjXml, encoding = "UTF-8"))
            if(fieldObj$wrap){ 
              wrapperNode <- xmlOutputDOM(
                tag = field,
                nameSpace = namespaceId,
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
                nameSpace = namespaceId
              )
              for(item in fieldObj){
                if(!is.null(item)){
                  fieldObjXml <- NULL
                  if(is(item,"ISOAbstractObject")){
                    fieldObjXml <- item$encode(validate = geometa_validate, 
                                               inspire = geometa_inspire, inspireValidator = geometa_inspireValidator)
                    fieldObjXml <- as(fieldObjXml, "character")
                    fieldObjXml <- gsub("<\\?xml.*?\\?>", "", fieldObjXml)
                    #fieldObjXml <- gsub("<!--.*?-->", "", fieldObjXml)
                    fieldObjXml <- xmlRoot(xmlParse(fieldObjXml, encoding = "UTF-8"))
                  }else{
                    fieldObjXml <- item$encode(addNS = FALSE)
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
                    fieldObjXml <- item$encode(validate = geometa_validate, 
                                               inspire = geometa_inspire, inspireValidator = geometa_inspireValidator)
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
              isCData <- is(fieldObj, "XMLCDataNode")
              if(isCData) fieldObj <- xmlValue(fieldObj)
              if(is.logical(fieldObj)) fieldObj <- tolower(as.character(is.logical(fieldObj)))
              fieldObj <- private$fromComplexTypes(fieldObj)
              if(isCData){
                fieldObj <- xmlCDataNode(fieldObj)
              }else{
                fieldObj <- xmlTextNode(fieldObj)
              }
              rootXML$addNode(fieldObj)
            }else{
              wrapperNode <- xmlOutputDOM(tag = field, nameSpace = namespaceId)
              if(!is(fieldObj, "XMLCDataNode")) fieldObj <- xmlTextNode(fieldObj)
              wrapperNode$addNode(fieldObj)
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
    },
    
    #'@description Provides a custom print output (as tree) of the current class
    #'@param ... args
    #'@param depth class nesting depth
    print = function(..., depth = 1){
      #list of fields to encode as XML
      fields <- rev(names(self))
      
      #fields
      fields <- fields[!sapply(fields, function(x){
        (class(self[[x]])[1] %in% c("environment", "function")) ||
          (x %in% private$system_fields)
      })]
      
      cat(crayon::white(paste0("<", crayon::underline(self$getClassName()), ">")))
      
      for(field in fields){
        fieldObj <- self[[field]]
        
        print_attrs <- function(obj){
          paste(
            sapply(names(obj$attrs), function(attrName){
              paste0( crayon::magenta(attrName,"=",sep=""), crayon::green(obj$attrs[[attrName]]))
            }
            ), 
            collapse=",")
        }
        
        #user values management
        shift <- "...."
        if(!is.null(fieldObj)){
          if(is(fieldObj, "OGCAbstractObject")){
            attrs_str <- ""
            if(length(fieldObj$attrs)>0){
              attrs <- print_attrs(fieldObj)
              attrs_str <- paste0(" [",attrs,"] ")
            }
            cat(paste0("\n", paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), " ", attrs_str))
            fieldObj$print(depth = depth+1)
          }else if(is(fieldObj, "list")){
            for(item in fieldObj){
              if(is(item, "OGCAbstractObject")){
                attrs_str <- ""
                if(length(item$attrs)>0){
                  attrs <- print_attrs(item)
                  attrs_str <- paste0(" [",attrs,"] ")
                }
                cat(paste0("\n", paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), " ", attrs_str))
                item$print(depth = depth+1)
              }else if(is(item, "matrix")){
                m <- paste(apply(item, 1L, function(x){
                  x <- lapply(x, function(el){
                    if(is.na(suppressWarnings(as.numeric(el))) & !all(sapply(item,class)=="character")){
                      el <- paste0("\"",el,"\"")
                    }else{
                      if(!is.na(suppressWarnings(as.numeric(el)))){
                        el <- as.numeric(el)
                      }
                    }
                    return(el)
                  })
                  return(paste(x, collapse = " "))
                }), collapse = " ")
                cat(paste0("\n",paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), ": ", crayon::bgWhite(m)))
              }else{
                cat(paste0("\n", paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), ": ", crayon::bgWhite(item)))
              }
            }
          }else if (is(fieldObj,"matrix")){
            m <- paste(apply(fieldObj, 1L, function(x){
              x <- lapply(x, function(el){
                if(is.na(suppressWarnings(as.numeric(el)))& !all(sapply(fieldObj,class)=="character")){
                  el <- paste0("\"",el,"\"")
                }else{
                  if(!is.na(suppressWarnings(as.numeric(el)))){
                    el <- as.numeric(el)
                  }
                }
                return(el)
              })
              return(paste(x, collapse = " "))
            }), collapse = " ")
            cat(paste0("\n",paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), ": ", crayon::bgWhite(m)))
          }else{
            fieldObjP <- fieldObj
            if(is(fieldObjP,"Date")|is(fieldObjP, "POSIXt")){
              fieldObjP <- private$fromComplexTypes(fieldObjP)
            }
            cat(paste0("\n",paste(rep(shift, depth), collapse=""),"|-- ", crayon::italic(field), ": ", crayon::bgWhite(fieldObjP)))
          }
        }
      }
      invisible(self)
    }
  )
)