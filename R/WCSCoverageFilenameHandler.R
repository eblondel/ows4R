#' @name WCSCoverageFilenameHandler
#' @aliases WCSCoverageFilenameHandler
#' @title WCSCoverageFilenameHandler
#' @description \code{WCSCoverageFilenameHandler} provides a coverage filename handler for coverage download
#'
#' @usage WCSCoverageFilenameHandler(identifier, time, elevation, bbox, format)
#'                 
#' @param identifier coverage identifier
#' @param time time
#' @param elevation elevation
#' @param bbox bbox
#' @param format format
#' @return the filename to use for coverage download
#' 
#' @author Emmanuel Blondel, \email{emmanuel.blondel1@@gmail.com}
#' @export
#' 
WCSCoverageFilenameHandler <- function(identifier, time, elevation, bbox, format){
  filename <- identifier
  if(!is.null(time)) filename <- paste0(filename, "_", gsub(":", "_", time))
  if(!is.null(elevation)) filename <- paste0(filename, "_", elevation)
  if(!is.null(bbox)) filename <- paste0(filename, "_", paste0(bbox, collapse=","))
  file_ext <- "tif"
  if(!is.null(format)){
    file_ext <- switch(format,
                       "image/tiff" = "tif",
                       "image/gtiff" = "tif",
                       "GeoTIFF" = "tif",
                       "GeoTIFF_Float" = "tif",
                       "TIFF" = "tif",
                       "image/jpeg" = "jpeg",
                       "JPEG" = "jpeg",
                       "image/png" = "png",
                       "PNG" = "png",
                       "image/gif" = "gif",
                       "GIF" = "gif",
                       "application/netcdf" = "nc",
                       "NetCDF3" = "nc"
    )
  }
  filename <- paste0(filename, ".", file_ext)
  return(filename)
}