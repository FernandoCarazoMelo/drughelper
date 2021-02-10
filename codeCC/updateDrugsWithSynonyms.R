#########################################################################################
# PREPROCESSING DRUG INFORMATION
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################


# THIS SHOULD BE ADAPTED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Tened en cuenta que yo en la tabla que creo tengo en los rownames los nombres de las drugs que nosotros usamos. 
# Si un usuario viene y pone otro id tendría que buscar en las distintas columnas de la tabla creada 
# (que en este caso debería de tener alguna estructura por columnas con drugbank id, chembl id, o similar). 
# Seguramente para este tipo de búsquedas haya algún plugin en r que permita hacer estas búsquedas por columnas de forma rápida. 
# Según esta página --> If you need efficient lookups in a large dataset in R, check out data.table’s ordered indexes – 
# this appears to be the best option out there! --> https://appsilon.com/fast-data-lookups-in-r-dplyr-vs-data-table/ .
# Aunque puede que usar algún plugin de bbdd de sql o MongoDB (no-sql) lo haga más rápido pero no se si mejorará mucho y 
# si merece la pena el tiempo para montarlo. Cualquier duda del código, me decís.




# Gene_Info table with single drug synonyms
# Compute a hash table to find associations between single Drug and its Drugs synonyms in Gene_Info data (DS2 drugs)
fAlreadyComputed <- 1
if (fAlreadyComputed == 0){
  # load("./GeneInfo.RData")
  # Xabi update drugs table
  load("GeneInfoUpdated.RData")
  

  singleDrugSynonyms <- data.frame(Drug="",Drug_synonyms="")
  drugsDS <- Gene_Info$Drug
  
  # Get all unique drugs from 'Gene_Info' table
  allDrugsDS <- NULL
  for (i in 1:length(drugsDS)){
    print(i)
    currDrugs <- drugsDS[i]
    currDrugs <- unlist(strsplit(currDrugs,"\\, "))
    currDrugs <- unique(currDrugs)
    currDrugs <- toupper(currDrugs)
    allDrugsDS <- c(allDrugsDS, currDrugs)
  }
  currDrugs <- unique(allDrugsDS)
  
  ind <- 1
  if(length(currDrugs) > 0){
    for (i in 1:length(currDrugs)){
      print(paste0("i = ", as.character(i)))
      currDrug <- currDrugs[i]
      synonyms <- getPubChemSynonyms(currDrug)
      synonyms <- toupper(synonyms)
      synonyms <- unique(synonyms)
      singleDrugSynonyms <- rbind(singleDrugSynonyms, c("",""))
      singleDrugSynonyms$Drug[ind] <- currDrug
      singleDrugSynonyms$Drug_synonyms[ind] <- paste(synonyms, collapse=';;;') 
      ind <- ind + 1
    }
  }
  
  rownames(singleDrugSynonyms) <- NULL
  emptyRows <- which(rowSums((singleDrugSynonyms=="")*1) == 2)
  singleDrugSynonyms <- singleDrugSynonyms[-emptyRows,]
  rownames(singleDrugSynonyms) <- singleDrugSynonyms[,1]
  
  # save(singleDrugSynonyms, file = "./Gene_Info_singleDrugSynonyms.RData") # 6278 2 (6278 unique drugs in Gene_Info table)
  save(singleDrugSynonyms, file = "./Gene_Info_Updated_singleDrugSynonyms.RData") 
}


# Gene_Info drug table with single drug synonyms
# load("./Gene_Info_singleDrugSynonyms.RData")
# Xabi updated drugs table
load("./Gene_Info_Updated_singleDrugSynonyms.RData")
