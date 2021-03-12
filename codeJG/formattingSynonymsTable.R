updateTable <- function(datosChemblv2){
  load("./data/input/2020-12-17version/datosChemblv2.RData")
  
  
  for (i in 1:nrow(datosChemblv2)){
    aux <- gsub("[[:blank:]]", "", datosChemblv2$synonyms[i])
    datosChemblv2$synonyms_formatted[i] <- gsub("[^[:alnum:];]", "", aux)
  }
  
  View(datosChemblv2)
  datosChemblv2formatted <- datosChemblv2
  save(datosChemblv2formatted, file = "./data/input/2020-12-17version/datosChemblv2formatted.RData")
}
