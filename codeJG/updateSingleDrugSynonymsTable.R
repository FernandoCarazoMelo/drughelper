updateTable <- function(singleDrugSynonyms){
  load("./data/input/2020-12-17version/singleDrugSynonymsChembl")
  
  
  for (i in 1:nrow(singleDrugSynonymsChembl)){
    aux <- gsub("[[:blank:]]", "", singleDrugSynonymsChembl$synonyms[i])
    singleDrugSynonymsChembl$Drug_Synonyms_format[i] <- gsub("[^[:alnum:];]", "", aux)
  }
  
  singleDrugSynonyms <- as.data.table(singleDrugSynonyms)
  View(singleDrugSynonyms)
  save(singleDrugSynonyms, file = "./data/input/2020-12-17version/singleDrugSynonymsTableUpdated.RData")
}
