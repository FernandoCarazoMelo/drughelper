\name{singleDrugSynonymsChembl}
\alias{singleDrugSynonymsChembl}
\docType{data}
\title{singleDrugSynonymsChembl}
\description{
A dataset containing all 9021 drugs and a string with its synonyms}
\usage{data("singleDrugSynonymsChembl")}
\format{
  A data frame with 9021 observations on the following 2 variables.
  \describe{
    \item{\code{Drug}}{a character vector}
    \item{\code{Drug_synonyms}}{a character vector}
  }
}
\details{
All synonyms of a drug are separated by ";;;"
}
\examples{
data(singleDrugSynonymsChembl)
## maybe str(singleDrugSynonymsChembl) ; plot(singleDrugSynonymsChembl) ...
}
\keyword{datasets}
