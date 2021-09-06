#' OGCAbstractObject
#' @docType class
#' @export
#' @keywords OGC Abstract Object
#' @return Object of \code{\link{R6Class}} for modelling an OGCAbstractObject
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'  \item{\code{new(xml, element, namespacePrefix, attrs, defaults, wrap, logger)}}{
#'    This method is used to instantiate an OGCAbstractObject
#'  }
#'  \item{\code{getClassName()}}{
#'    Get class name
#'  }
#'  \item{\code{getClass()}}{
#'    Get class
#'  }
#'  \item{\code{encode(addNS, geometa_validate, geometa_inspire)}}{
#'    Encode as XML
#'  }
#' }
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
    element = NULL,
    namespace = NULL,
    defaults = list(),
    attrs = list(),
    
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
    
    #getClassName
    getClassName = function(){
      return(class(self)[1])
    },
    
    #getClass
    getClass = function(){
      class <- eval(parse(text=self$getClassName()))
      return(class)
    },
    
    #isFieldInheritedFrom
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
    
    #getNamespaceDefinition
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
    
    #encode
    encode = function(addNS = TRUE, geometa_validate = TRUE, geometa_inspire = FALSE){
      
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
            fieldObjXml <- fieldObj$encode(validate = geometa_validate, inspire = geometa_inspire)
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
                    fieldObjXml <- item$encode(validate = geometa_validate, inspire = geometa_inspire)
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
              wrapperNode <- xmlOutputDOM(tag = field, nameSpace = namespaceId)
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