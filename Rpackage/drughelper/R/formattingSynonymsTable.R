updateTable <- function(datosChembl){

  for (i in 1:nrow(datosChembl)){
    datosChembl$synonyms_formatted[i] <- mgsub(datosChembl$synonyms[i], c("[[:blank:]]", ""), c("[^[:alnum:];]", ""))

  }
  return(datosChembl)

}
