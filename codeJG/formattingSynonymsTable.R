updateTable <- function(datosChembl){
  load("./data/input/2020-12-17version/datosChembl")
  
  
  for (i in 1:nrow(datosChembl)){
    aux <- gsub("[[:blank:]]", "", datosChembl$synonyms[i])
    datosChembl$Drug_Synonyms_format[i] <- gsub("[^[:alnum:];]", "", aux)
  }
  
  singleDrugSynonyms <- as.data.table(singleDrugSynonyms)
  View(singleDrugSynonyms)
  save(singleDrugSynonyms, file = "./data/input/2020-12-17version/datosChemblTableUpdated.RData")
}
