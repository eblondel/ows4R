% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/WPSProcess.R
\docType{class}
\name{WPSProcess}
\alias{WPSProcess}
\title{WPSProcess}
\format{
\code{\link{R6Class}} object.
}
\value{
Object of \code{\link{R6Class}} modelling a WPS process
}
\description{
WPSProcess
}
\note{
Class used internally by \pkg{ows4R}
}
\section{Methods}{

\describe{
 \item{\code{new(xmlObj, capabilities, version, logger)}}{
   This method is used to instantiate a \code{WPSProcess} object
 }
 \item{\code{getIdentifier()}}{
   Get process identifier
 }
 \item{\code{getTitle()}}{
   Get process title
 }
 \item{\code{getVersion()}}{
   Get process version
 }
}
}

\author{
Emmanuel Blondel <emmanuel.blondel1@gmail.com>
}
\keyword{OGC}
\keyword{Process}
\keyword{WPS}
