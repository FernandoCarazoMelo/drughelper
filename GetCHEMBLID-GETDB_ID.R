#########################################################################################
# PREPROCESSING DRUG INFORMATION
# Code Author: Marian Gimeno mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo fcarazo@tecnun.es
# Data Developer: Carlos Castilla ccastilla.1@tecnun.es
#########################################################################################

load("./Gene_Info_Updated_singleDrugSynonyms.RData")
load("./VICC_singleDrugSynonyms.RData")
singleDrugSynonyms$Drug_synonyms<-paste0(singleDrugSynonyms$Drug_synonyms, ";;;", singleDrugSynonyms$Drug)

# save(singleDrugSynonyms, file="./singleDrugSynonyms.RData")


DrugName<-"NEOMYCIN SULFATE"
DrugName<-"DB07604"

getCHEMBLID<-function(DrugName){
  load("./singleDrugSynonyms.RData")
  iix<-grep(DrugName,singleDrugSynonyms[,2])
  Synonyms<-unlist(strsplit(singleDrugSynonyms[iix,2], split=";;;"))
  ChemblID<- Synonyms[grep("CHEMBL", Synonyms)]
  if(length(ChemblID>0)){
    return(unique(ChemblID))
  }
  if(length(ChemblID)==0){
    stop("No CHEMBL ID found")
  }
}

Chem<-getCHEMBLID(DrugName)


getDrugBankID<-function(DrugName){
  load("./singleDrugSynonyms.RData")
  iix<-grep(DrugName,singleDrugSynonyms[,2])
  Synonyms<-unlist(strsplit(singleDrugSynonyms[iix,2], split=";;;"))
  DB_ID<- Synonyms[grep("^DB0", Synonyms)]
  if(length(DB_ID>0)){
    return(unique(DB_ID))
  }
  if(length(DB_ID)==0){
    stop("No DrugBank ID found")
  }
}

DB<-getDrugBankID(Chem)
