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



fAlreadyComputed <- 1
if (fAlreadyComputed == 0){
  #listDrugs = singleDrugSynonymsChembl$Drug #listdrugs = lista de drogas a las que damos sinonimos
  load("./data/input/2020-12-17version/datosChembl.RData")
  listDrugs = datosChembl$Drug
  # Xabi update Drugs table
  
  singleDrugSynonymsChembl <- as.data.frame(matrix(NA, ncol = 2, nrow = length(listDrugs))) #crea dataframe en blanco
  colnames(singleDrugSynonymsChembl) <- c("Drug", "Drug_synonyms")
  drugsDH <- listDrugs 
  
  # Get all unique drugs from 'Gene_Info' table

source("./codeJG/getPubChemSynonyms.R")
  if(length(drugsDH) > 0){
    for (i in 1:length(drugsDH)){
      print(paste0("i = ", as.character(i)))
      currDrug <- drugsDH[i]
      synonyms <- getPubChemSynonyms(currDrug)
      synonyms <- toupper(synonyms)
      synonyms <- unique(synonyms)
      singleDrugSynonymsChembl$Drug[i] <- currDrug
      singleDrugSynonymsChembl$Drug_synonyms[i] <- paste(synonyms, collapse=';;;') 
    }
  }
  
  rownames(singleDrugSynonymsChembl) <- singleDrugSynonymsChembl[,1]
  
  save(singleDrugSynonymsChembl, file = "./data/input/2020-12-17version/singleDrugSynonymsChembl.RData") 
}