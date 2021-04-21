#########################################################################################
# FUNCTION GET CHEMBLID
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################

getDrugBankID<-function(DrugName){
  DrugName<-toupper(DrugName)
  load("./data/input/2020-12-17version/singleDrugSynonymsTabulatesDH_IDcreated.RData")
  iix<-agrep(DrugName,singleDrugSynonyms$Drug_synonyms, max=3, ignore.case = T)
  DB_ID<- singleDrugSynonyms$DB[iix]
  if(length(DB_ID>0)){
    return(unique(DB_ID))
  }
  if(length(DB_ID)==0){
    stop("No DrugBank ID found")
  }
}












