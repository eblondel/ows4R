#' WCSCoverageDescription
#'
#' @docType class
#' @export
#' @keywords OGC WCS Coverage
#' @return Object of \code{\link{R6Class}} modelling a WCS coverage summary
#' @format \code{\link{R6Class}} object.
#' 
#' @note Class used internally by ows4R.
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
WCSCoverageDescription <- R6Class("WCSCoverageDescription",
  inherit = geometa::GMLCOVAbstractCoverage,                       
  private = list(
    version = NA,
    owsVersion = NA,
    #fetchCoverageDescription (for WCS version 1 elements)
    fetchCoverageDescription = function(xmlObj, serviceVersion, owsVersion){
      children <- xmlChildren(xmlObj)
      
      covId <- switch(substr(serviceVersion,1,3),
                      "1.0" = xmlValue(children$name),
                      "1.1" = xmlValue(children$Identifier)
      )
      
      supportedCrs <- list()
      if(substr(serviceVersion,1,3)=="1.0"){
        crsList <- children[names(children) == "supportedCRSs"][[1]]
        supportedCrs <- as.vector(sapply(xmlChildren(crsList), xmlValue))
      }else{
        supportedCrs <- as.vector(sapply(children[names(children) == "SupportedCRS"], xmlValue))
      }
      
      supportedFormats <- list()
      if(substr(serviceVersion,1,3)=="1.0"){
        formatList <- children[names(children) == "supportedFormats"][[1]]
        supportedFormats <- as.vector(sapply(xmlChildren(formatList), xmlValue))
      }else{
        supportedFormats <- as.vector(sapply(children[names(children) == "SupportedFormat"], xmlValue))
      }
      
      domain <- NULL
      if(substr(serviceVersion,1,3)=="1.0"){
        domain <- WCSCoverageDomain$new(xmlObj = children$domainSet, serviceVersion, owsVersion)
      }else if(substr(serviceVersion,1,3)=="1.1"){
        domain <- WCSCoverageDomain$new(xmlObj = children$Domain, serviceVersion, owsVersion)
      }
      
      range <- children$Range #TODO
      
      covDescription <- list(
        CoverageId = covId,
        SupportedCRS = supportedCrs,
        SupportedFormat = supportedFormats,
        Domain = domain,
        Range = range
      )
      return(covDescription)
    }
  ),
  public = list(
    #'@field CoverageId coverage ID
    CoverageId = NULL,
    #'@field SupportedCRS supported CRS
    SupportedCRS = list(),
    #'@field SupportedFormat supported Format
    SupportedFormat = list(),
    #'@field Domain domain
    Domain = list(),
    #'@field Range range
    Range = list(),
    #'@field ServiceParameters service parmaeters
    ServiceParameters = list(),
    
    #'@description Initializes an object of class \link{WCSCoverageDescription}
    #'@param xmlObj an object of class \link{XMLInternalNode-class} to initialize from XML
    #'@param serviceVersion service version
    #'@param owsVersion OWS version
    #'@param logger logger
    initialize = function(xmlObj, serviceVersion, owsVersion, logger = NULL){
      super$initialize(xml = xmlObj)
      private$version = serviceVersion
      private$owsVersion = owsVersion
      if(startsWith(serviceVersion, "1")){
        covDescription <- private$fetchCoverageDescription(xmlObj, serviceVersion, owsVersion)
        self$CoverageId <- covDescription$CoverageId
        self$SupportedCRS <- covDescription$SupportedCRS
        self$SupportedFormat <- covDescription$SupportedFormat
        self$Domain <- covDescription$Domain
        self$Range <- covDescription$Range
      }
    },
    
    #'@description getId
    #'@return the coverage id, object of class \code{character}
    getId = function(){
      id <- NULL
      if(startsWith(private$version, "1")){
        id <- self$CoverageId
      }else if(startsWith(private$version, "2")){
        id <- self$attrs[["gml:id"]]
      }
      return(id)
    },
    
    #'@description getSupported CRS. Applies to WCS 1 coverage descriptions
    getSupportedCRS = function(){
      return(self$SupportedCRS)
    },
    
    #'@description get supported formats. Applies to WCS 1 coverage descriptions
    getSupportedFormats = function(){
      return(self$SupportedFormat)
    },
    
    #'@description get domain. Applies to WCS 1 coverage descriptions
    getDomain = function(){
      return(self$Domain)
    },
    
    #'@description get range. Applies to WCS 1.0 coverage descriptions
    getRange = function(){
      return(self$Range)
    }
    
  )
)