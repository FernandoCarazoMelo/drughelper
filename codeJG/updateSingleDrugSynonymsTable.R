updateTable <- function(singleDrugSynonyms){
  load("./data/input/2020-12-17version/singleDrugSynonymsTabulatesDH_IDcreated.Rdata")
  
  
  for (i in 1:nrow(singleDrugSynonyms)){
    aux <- gsub("[[:blank:]]", "", singleDrugSynonyms$Drug_synonyms[i])
    singleDrugSynonyms$Drug_Synonyms_format[i] <- gsub("[^[:alnum:];]", "", aux)
  }
  
  View(singleDrugSynonyms)
  save(singleDrugSynonyms, file = "./data/input/2020-12-17version/singleDrugSynonymsTableUpdated.RData")
}
