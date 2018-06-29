#' OWSUtils
#'
#' @export
#' @keywords OGC OWS Utils
#' @return set of OWS Utilities
#' @format \code{\link{R6Class}} object.
#'
#' @section Static methods:
#' \describe{
#' }
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
    toBBOX = function(xmin, xmax, ymin, ymax) {
      df <- data.frame(min = c(xmin, ymin), max= c(xmax, ymax))
      row.names(df)<- c("x","y")
      m <- as.matrix(df)
      return(m)
    },
    
    #findP4s
    findP4s = function(srsName, morphToESRI=FALSE) {
      
      if (missing(srsName)) {
        stop("please provide a spatial reference system name")
      }
      proj.lst <- as.character(projInfo("proj")$name)
      
      #we remove the latlong proj for compatibility with sp
      proj.lst <- proj.lst[proj.lst != "latlong" & proj.lst != "latlon"]
      
      #build combinations of know proj and datum
      proj.datum.grd <- expand.grid(proj=proj.lst, datum=as.character(projInfo("datum")$name), stringsAsFactors=FALSE)
      
      #remove the carthage datum which make my system crash
      proj.datum.grd <- proj.datum.grd[proj.datum.grd$datum != "carthage", ]
      
      #function to ask WKT representation
      getShowWkt <- function(x) {
        res <- try(showWKT(paste("+proj=", x[1], " +datum=", x[2], sep=""), morphToESRI=morphToESRI), silent=TRUE)
        if (class(res) == "try-error") {
          return(NA)
        } else {
          return(res)
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
        srsDef <- paste("+init=epsg:", epsg, sep="")
      }else{
        #search if srsName is a WKT PROJ name (PROJCS or GEOGCS)
        #if yes set srs with the corresponding proj4string
        #first search without any consideration of the ESRI representation
        srsDef <- self$findP4s(srsName, morphToESRI=FALSE)
        if (is.na(srsDef)) {
          #if not found search with consideration of the ESRI representation
          srsDef <- self$findP4s(srsName, morphToESRI=TRUE)
        }
        if (! is.na(srsDef) && ! length(srsDef) == 1) {
          srsDef <- NA
        }
      }
      return(st_crs(srsDef))
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
    }
)