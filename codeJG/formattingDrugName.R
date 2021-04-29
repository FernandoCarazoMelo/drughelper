#' @title Normalization of drug names
#' @description  This function corrects and capitalizes the names of a given vector of drugs.
#' @param A string with the name of the drug to be normalized
#' @export
#' @example formattingDrugName("morphine")

 formattingDrugName <- function(DrugName) {
  
  DrugName<- toupper(DrugName)
  DrugName <- gsub("[^[:alnum:]]", " ", DrugName)
  DrugName <- gsub("[[:blank:]]", "", DrugName)
  
  return(DrugName)
}