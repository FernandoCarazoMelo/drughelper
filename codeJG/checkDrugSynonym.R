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
                    Approved = character(),
                    DrugHelperID = character(),
                    Suggested.Synonym = character())
                        
  for (i in 1:length(drugVector)) {
    
    daf[i, 1] <- drugVector[i]
    
    DrugName <- formattingDrugName(drugVector[i])
    
    drugVector[i] <- DrugName[1] #estas dos ultimas lineas tengo que mejorarlas,
    #si encuentra mas de una coincidencia, devuleve la primera, debería
    #devolver la que mas se parezca, hacer prueba con "morphine"
    
    logicVector <- agrepl(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)
    
    if (TRUE %in% logicVector){
      daf[i, 2] <- TRUE
    } else{
      daf[i, 2] <- FALSE
    }
    daf[i, 3] <- datosChembl$DrugHelper[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)[1]]
    daf[i, 4] <- datosChembl$Drug[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)[1]]
    
  }
  return(daf)
  
}
