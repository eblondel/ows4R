.onLoad <- function (libname, pkgname) { # nocov start
  
  ISOMetadataNamespace$GML$uri <- "http://www.opengis.net/gml"
  
  assign(".ows4R", new.env(), envir= asNamespace(pkgname))
  
  #set OWS namespaces
  setOWSNamespaces()
  
} # nocov end
