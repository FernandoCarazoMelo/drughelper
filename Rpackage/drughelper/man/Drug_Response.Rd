\name{Drug_response}
\alias{Drug_response}
\docType{data}
\title{DrugResponse}
\description{A data.frame from BeatAML project with a set of inhibition drugs and other information}
\usage{data("drugResponse")}
\format{
  A data frame with 47650 observations on the following 4 variables.
  \describe{
    \item{\code{inhibitor}}{gen target and drug name}
    \item{\code{lab_id}}{an identification code}
    \item{\code{ic50}}{ic50 value}
    \item{\code{auc}}{auc value}
  }
}
\details{This dataset is used in the first case study where drugs from the BeatAML project are cross-studied with other different datasets. ic50 and auc values are experimental results incorporated to the dataset}

\examples{
data(Drug_response)
## maybe str(Drug_response) ; plot(Drug_response) ...
}
\keyword{datasets}
