#########################################################################################
# FUNCTION GET CHEMBLID
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################


getCHEMBLID<-function(DrugName){
  
  DrugName<-toupper(DrugName)
  load("./data/input/2020-12-17version/singleDrugSynonymsTabulatesDH_IDcreated.RData")
  iix<-agrep(DrugName,singleDrugSynonyms$Drug_synonyms, max=3, ignore.case = T)
  ChemblID<-singleDrugSynonyms$CHEMBL[iix]
  if(length(ChemblID>0)){
    return(unique(ChemblID))
  }
  if(length(ChemblID)==0){
    stop("No CHEMBL ID found")
  }
}



















