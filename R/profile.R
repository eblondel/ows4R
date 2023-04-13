.onLoad <- function (libname, pkgname) { # nocov start
  
  #make sure sf relies on... "sf" (aka ISO/OGC Simple Features)! and not s2
  options(sf_use_s2 = FALSE)
  
  ISOMetadataNamespace$GML$uri <- "http://www.opengis.net/gml"
  
  assign(".ows4R", new.env(), envir= asNamespace(pkgname))
  
  #set OWS namespaces
  setOWSNamespaces()
  
} # nocov end
