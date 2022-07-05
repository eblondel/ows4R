#' OWSUtils
#'
#' @export
#' @keywords OGC OWS Utils
#' @return set of OWS Utilities
#' @format \code{\link{R6Class}} object.
#'
#' @section Static methods:
#' \describe{
#'  \item{\code{getNamespaces()}}{
#'    Get the namespaces associated to a given XML object
#'  }
#'  \item{\code{findNamespace(namespaces, id, uri)}}{
#'    Finds a namespace by id or by URI
#'  }
#'  \item{\code{toBBOX(xmin, xmax, ymin, ymax)}}{
#'    Creates a bbox matrix from min/max x/y coordinates
#'  }
#'  \item{\code{findP4s(srsName, morphToESRI)}}{
#'    Finds the PROJ4 string definition for a given srsName
#'  }
#'  \item{\code{toCRS(srsName)}}{
#'   Converts a srsName into a CRS object
#'  }
#'  \item{\code{toEPSG(crs)}}{
#'   Get the EPSG code from a CRS object
#'  }
#'  \item{\code{getAspectRatio(bbox)}}{
#'   Get the aspect ratio for a given bbox
#'  }
#' }
#' 
#' @examples
#'   #toBBOX
#'   bbox <- OWSUtils$toBBOX(-180,-90,180,90)
#'   
#'   #toCRS
#'   crs <- OWSUtils$toCRS("EPSG:4326")
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
OWSUtils <- list(
  
    #getNamespaces
    #---------------------------------------------------------------
    getNamespaces = function(xmlObj) {
      nsFromXML <- xmlNamespaceDefinitions(xmlObj)
      nsDefs.df <- do.call("rbind",
                           lapply(nsFromXML,
                                  function(x){
                                    c(x$id, x$uri) 
                                  }))
      
      if(!is.null(nsDefs.df)){
        row.names(nsDefs.df) <- 1:nrow(nsDefs.df)
        nsDefs.df <-as.data.frame(nsDefs.df, stringAsFactors = FALSE)
        if(nrow(nsDefs.df) > 0){
          colnames(nsDefs.df) <- c("id","uri")
          nsDefs.df$id <- as.character(nsDefs.df$id)
          nsDefs.df$uri <- as.character(nsDefs.df$uri)
        }
        nsDefs.df <- unique(nsDefs.df)
        nsDefs.df <- nsDefs.df[!duplicated(nsDefs.df$uri),]
      }
      
      return(nsDefs.df)
    },
    
    #findNamespace
    #---------------------------------------------------------------
    findNamespace = function(namespaces, id = NULL, uri = NULL){
      if(!is.null(id)){
        namespace <- namespaces[namespaces$id==id,]
        if(nrow(namespace)==0){
          namespace <- namespaces[grepl(id, namespaces$uri),]
        }
      }
      if(!is.null(uri)){
        namespace <- namespaces[namespaces$uri==uri,]
        if(nrow(namespace)==0){
          namespace <- namespaces[grepl(uri, namespaces$uri),]
        }
      }
      ns <- NULL
      if(nrow(namespace)>0){
        ns <- c(ns = namespace[1L,"uri"])
      }
      return(ns)
    },
    
    #toBBOX
    #---------------------------------------------------------------
    toBBOX = function(xmin, xmax, ymin, ymax) {
      df <- data.frame(min = c(xmin, ymin), max= c(xmax, ymax))
      row.names(df)<- c("x","y")
      m <- as.matrix(df)
      return(m)
    },
    
    #findP4s
    #---------------------------------------------------------------
    findP4s = function(srsName) {
      
      if (missing(srsName)) {
        stop("please provide a spatial reference system name")
      }
      proj.lst <- as.character(sf::sf_proj_info("proj")$name)
      
      #we remove the latlong proj for compatibility with sp
      proj.lst <- proj.lst[proj.lst != "latlong" & proj.lst != "latlon"]
      
      #build combinations of know proj and datum
      datum <- sf::sf_proj_info("datum")$name
      proj.datum.grd <- NULL
      if(!is.null(datum)){
        proj.datum.grd <- expand.grid(proj=proj.lst, datum=as.character(datum), stringsAsFactors=FALSE)
      }else{
        proj.datum.grd <- expand.grid(proj=proj.lst, datum=NA, stringsAsFactors=FALSE)
      }
      
      #function to ask WKT representation
      getShowWkt <- function(x) {
        res <- NULL
        if(is.na(x[2])){
          res <- try(suppressWarnings(sf::st_crs(paste("+proj=", x[1], sep=""))), silent=TRUE)
        }else{
          res <- try(sf::st_crs(paste("+proj=", x[1], " +datum=", x[2], sep="")), silent=TRUE)
        }
        
        if (is(res, "try-error")) {
          return(NA)
        } else {
          return(res$wkt)
        }
      }
      
      #ask WKT for all projection
      GCS <- apply(proj.datum.grd, 1, FUN=getShowWkt)  
      GCS.df <- data.frame(proj=proj.datum.grd$proj, datum=proj.datum.grd$datum, WKT=GCS, stringsAsFactors=FALSE)
      
      #keep only valids
      GCS.df <- GCS.df[! is.na(GCS.df$WKT),]
      
      #the pattern to find
      pattern <- paste("GEOGCS[\"", srsName, "\"", sep="")
      
      #search for pattern
      GCS.df <- GCS.df[substr(tolower(GCS.df$WKT), 1, nchar(pattern)) == tolower(pattern),]
      
      #keep only first SRS in case of identical WKT representation
      GCS.df <- GCS.df[!duplicated(GCS.df$WKT),]
      if (nrow(GCS.df) > 0) {
        #return the proj4 definition
        return(paste("+proj=", GCS.df$proj, " +datum=", GCS.df$datum, sep=""))  
      } else {
        #not found, return NA
        return(NA)
      }	
    },
    
    #toCRS
    #---------------------------------------------------------------
    toCRS = function(srsName){
      
      srsPattern = "EPSG:" #match case 1
      if(attr(regexpr(srsPattern, srsName, ignore.case = T),
              "match.length") > 0){
        srsStr <- unlist(strsplit(srsName, ":"))
        epsg <- srsStr[length(srsStr)]
        srsDef <- paste("epsg:", epsg, sep="")
        
        #case of special wildcard 404000
        #see https://osgeo-org.atlassian.net/browse/GEOS-8993?focusedCommentId=79737&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-79737
        if(epsg=="404000") srsDef <- NA
      }else{
        #search if srsName is a WKT PROJ name (PROJCS or GEOGCS)
        #if yes set srs with the corresponding proj4string
        #first search without any consideration of the ESRI representation
        srsDef <- OWSUtils$findP4s(srsName)
        if (is.na(srsDef)) {
          #if not found search with consideration of the ESRI representation
          srsDef <- OWSUtils$findP4s(srsName)
        }
        if (! is.na(srsDef) && ! length(srsDef) == 1) {
          srsDef <- NA
        }
      }
      return(sf::st_crs(srsDef))
    },
    
    #toEPSG
    #---------------------------------------------------------------
    toEPSG = function(crs){
      args <- CRSargs(crs)
      init <- unlist(strsplit(args," "))[1]
      epsg <- toupper(unlist(strsplit(init,"+init="))[2])
      return(epsg)
    },
    
    #getAspectRatio
    #---------------------------------------------------------------
    getAspectRatio = function(bbox){
      ratio <- (bbox[1,2]-bbox[1,1]) / (bbox[2,2]-bbox[2,1])
      return(ratio)
    },
    
    #checkEnvelopeDatatypes
    #---------------------------------------------------------------
    checkEnvelopeDatatypes = function(env){
      env$lowerCorner <- t(as.matrix(lapply(env$lowerCorner,function(x){
        out <- x
        if(!is.na(suppressWarnings(as.numeric(x)))) out<-as.numeric(x)
        out
      })))
      env$upperCorner <- t(as.matrix(lapply(env$upperCorner,function(x){
        out <- x
        if(!is.na(suppressWarnings(as.numeric(x)))) out<-as.numeric(x)
        out
      })))
      return(env)
    }
)