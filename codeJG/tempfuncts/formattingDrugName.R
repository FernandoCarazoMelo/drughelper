# This function returns the synonyms from a given drug name

 formattingDrugName <- function(DrugName) {
  
  DrugName<- toupper(DrugName)
 
  DrugName <- gsub("[^[:alnum:]]", " ", DrugName)
  DrugName <- gsub("[[:blank:]]", "", DrugName)
  
  synonyms <- singleDrugSynonyms$Drug_synonyms[grep(DrugName, singleDrugSynonyms$Drug_Synonyms_format)]
  return(synonyms)
}