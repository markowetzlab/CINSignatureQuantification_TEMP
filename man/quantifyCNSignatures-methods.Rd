% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/quantifyCNSignatures.R
\docType{methods}
\name{quantifyCNSignatures}
\alias{quantifyCNSignatures}
\alias{quantifyCNSignatures,data.frame-method}
\title{quantifyCNSignatures}
\usage{
quantifyCNSignatures(
  object,
  experimentName = "Default",
  method = "drews",
  cores = 1
)

\S4method{quantifyCNSignatures}{data.frame}(
  object,
  experimentName = "Default",
  method = "drews",
  cores = 1
)
}
\arguments{
\item{object}{cignaturesCN object}

\item{experimentName}{A user-specified name of the experiment}

\item{method}{The method used for calculating the signature activities. Default is "drews"}

\item{cores}{Number of threads/cores to use for parallel processing}
}
\value{
A cignaturesSIG class object with four activity matrices stored in the "activities" slot
}
\description{
This function takes a copy number profile as input and returns signature activities.
}
