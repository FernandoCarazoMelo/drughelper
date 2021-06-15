#' @title Normalization of drug names
#' @description  This function corrects and capitalizes the names of a given vector of drugs.
#' @param DrugName A string with the name of the drug to be normalized
#' @return A string containing only alphanumeric content of the input drug and capitalized
#' @examples formattingDrugName("morphine")
#' @export

 formattingDrugName <- function(DrugName) {

  DrugName<- toupper(DrugName)
  DrugName <- gsub("[^[:alnum:]]", " ", DrugName)
  DrugName <- gsub("[[:blank:]]", "", DrugName)

  return(DrugName)
}
