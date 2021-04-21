updateTable <- function(datosChembl){
  
  for (i in 1:nrow(datosChembl)){
    aux <- gsub("[[:blank:]]", "", datosChembl$synonyms[i])
    datosChembl$synonyms_formatted[i] <- gsub("[^[:alnum:];]", "", aux)
  }
  
  
  return(datosChembl)
  
}
