#########################################################################################
# PREPROCESSING DRUG INFORMATION
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################

load("./data/input/2020-12-17version/singleDrugSynonyms.RData")
load("./data/input/2020-12-17version/VICC_singleDrugSynonyms.RData")



singleDrugSynonyms$Drug_synonyms<-paste0(singleDrugSynonyms$Drug_synonyms, ";;;", singleDrugSynonyms$Drug)
singleDrugSynonyms$CHEMBL<-"NA"


for(j in 1:nrow(singleDrugSynonyms)){
  Synonyms<-unlist(strsplit(singleDrugSynonyms[j,2], split=";;;"))
  ChemblID<- Synonyms[grep("^CHEMBL", Synonyms)]
  if(length(ChemblID)==0){
    ChemblID<- Synonyms[grep("CHEMBL", Synonyms)]
    if(length(ChemblID)==0){
      next()
    }
    singleDrugSynonyms$CHEMBL[j]<-ChemblID
  }
  singleDrugSynonyms$CHEMBL[j]<-ChemblID
}

singleDrugSynonyms$DB<-"NA"

for(j in 1:nrow(singleDrugSynonyms)){
  Synonyms<-unlist(strsplit(singleDrugSynonyms[j,2], split=";;;"))
  DBID<- Synonyms[grep("^DB", Synonyms)]
  if(length(DBID)==0){
    next()
  }
  singleDrugSynonyms$DB[j]<-DBID
}

singleDrugSynonyms$DrugHelper<-paste0("DH0",1:nrow(singleDrugSynonyms)) 

