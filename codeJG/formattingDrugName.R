# This function corrects and capitalizes the names of a given vector of drugs.

 formattingDrugName <- function(DrugName) {
  
  DrugName<- toupper(DrugName)
  DrugName <- gsub("[^[:alnum:]]", " ", DrugName)
  DrugName <- gsub("[[:blank:]]", "", DrugName)
  
  return(DrugName)
}