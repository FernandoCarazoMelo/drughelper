# Funcion checkDrugSynonym
# Este script realiza la tarea principal del proyecto, dado un vector de
# sinonimos por el usuario, devuelve un dataframe con informacion corregida
# de ellos

source("./codeJG/formattingDrugName.R") 

checkDrugSynonym <- function(drugVector) {
  
  # CHECK INPUT CLASS (DEBE SER "CHARACTER")
  
  if (class(drugVector) != "character") {
    drugVector <- as.character(drugVector)
    warning("coercing drugVector to character.")
  }
  
  #DATAFRAME
  daf <- data.frame(x = character(),
                    DrugHelperID = character(),
                    Suggested.Synonym = character())
                        
  for (i in 1:length(drugVector)) {
    
    DrugName <- formattingDrugName(drugVector[i])
    
    drugVector[i] <- DrugName[1] #estas dos ultimas lineas tengo que mejorarlas, eliminando las duplicidades, de momento las dejo asi porque no lo he hecho
  
    
    daf[i, 1] <- drugVector[i]
    daf[i, 2] <- datosChembl$DrugHelper[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)[1]]
    daf[i, 3] <- datosChembl$Drug[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)[1]]
    
  }
  return(daf)
  
}
