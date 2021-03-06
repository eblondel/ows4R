% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CSWRecordProperty.R
\docType{class}
\name{CSWRecordProperty}
\alias{CSWRecordProperty}
\title{CSWRecordProperty}
\format{
\code{\link{R6Class}} object.
}
\value{
Object of \code{\link{R6Class}} for modelling an CSW RecordProperty
}
\description{
CSWRecordProperty
}
\section{Methods}{

\describe{
 \item{\code{new(name, value, cswVersion)}}{
   This method is used to instantiate an CSWRecordProperty object.
 }
}
}

\examples{
   rp <- CSWRecordProperty$new(name = "NAME", value = "VALUE")
   rp_xml <- rp$encode() #see how it looks in XML

}
\author{
Emmanuel Blondel <emmanuel.blondel1@gmail.com>
}
\keyword{CSW}
\keyword{RecordProperty}
