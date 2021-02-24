#Función checkDrugSynonym

#source("./codeJG/formattingDrugName.R")

checkDrugSynonym <- function(drugVector) {
  
  # check input class
  if (class(drugVector) != "character") {
    drugVector <- as.character(drugVector)
    warning("coercing drugVector to character.")
  }
  
  #DATAFRAME
  daf <- data.frame(x = character(),
                    DrugHelperID = character(),
                    Suggested.Synonym = character())
                        
  for (i in 1:length(drugVector)) {
    
    DrugName <- toupper(drugVector[i])
    DrugName <- gsub("[^[:alnum:]]", " ", DrugName)
    DrugName <- gsub("[[:blank:]]", "", DrugName)
    drugVector[i] <- DrugName[1] #estas dos ultimas lineas tengo que mejorarlas, eliminando las duplicidades, de momento las dejo asi porque no lo he hecho
  
    
    daf[i, 1] <- drugVector[i]
    daf[i, 2] <- singleDrugSynonyms$DrugHelper[grep(drugVector[i], singleDrugSynonyms$Drug_Synonyms_format)[1]]#el 1 tambien hay que mejorarlo
    daf[i, 3] <- singleDrugSynonyms$Drug[grep(drugVector[i], singleDrugSynonyms$Drug_Synonyms_format)[1]]#el 1 tambien hay que mejorarlo

  }
  return(daf)
  
}
