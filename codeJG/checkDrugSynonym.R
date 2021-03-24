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
          
          drugVector[i] <- DrugName #estas dos ultimas lineas tengo que mejorarlas,
          #si encuentra mas de una coincidencia, devuelve la primera, debería
          #devolver la que mas se parezca, hacer prueba con "morphine"
          
          logicVector <- agrepl(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)
          
          if (TRUE %in% logicVector){
            daf[i, 2] <- TRUE
          } else {
            daf[i, 2] <- FALSE
          }
          
    
    auxVectorsynonyms <- datosChembl$Drug[agrep(drugVector[1], datosChembl$synonyms_formatted, max.distance = 1)]
    auxTable <-datosChembl[agrep(drugVector[1], datosChembl$synonyms_formatted, max.distance = 1), ]
    
    tempDF = data.frame(Index = integer(), Synonyms = character())
    for (j in 1:length(auxVectorsynonyms)){
      
      list = unique(strsplit(auxTable$synonyms_formatted[j], split=";;;"))
      tempDF = rbind(tempDF, data.frame(Index = rownames(auxTable)[j], Synonyms = unlist(list)))
    }
    
    daf[i, 3] <- datosChembl$DrugHelper[rownames(datosChembl) == tempDF$Index[grep(drugVector[i], tempDF$Synonyms)]]
    daf[i, 4] <- tempDF$Synonyms[grep(drugVector[i], tempDF[,2])]
    
  }
  return(daf)
  
}
