\name{Gene_Info}
\alias{Gene_Info}
\docType{data}
\title{
Gene Info from DrugSniper}
\description{Geneinfo is a dataset with different information around a set of genes}
\usage{data("geneInfo")}
\format{
  A data frame with 35673 observations on the following 11 variables.
  \describe{
    \item{\code{hgnc_symbol}}{Gene symbol from HUGO Gene Nomenclature Committee}
    \item{\code{ensembl_gene_id}}{Identification code from ensembl project}
    \item{\code{gene_biotype}}{clasification of gene}
    \item{\code{transcript_length}}{number of pair bases of the gene}
    \item{\code{Loc}}{where the gene is located}
    \item{\code{Cancer}}{possible relation with cancers}
    \item{\code{Drug}}{possible drugs that target that gene}
    \item{\code{Indication}}{diseases associated with the gene}
    \item{\code{Function}}{therapeutic use of the drug (inhibitor, inducers...)}
    \item{\code{Metabolic}}{a numeric vector}
    \item{\code{molCIMA}}{a numeric vector}
  }
}
\details{Gene Info is part of the project "DrugSniper" from Tecnun, Universidad de Navarra}
\examples{
data(Gene_Info)
## maybe str(Gene_Info) ; plot(Gene_Info) ...
}
\keyword{datasets}
