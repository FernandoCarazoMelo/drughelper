#########################################################################################
# PREPROCESSING DRUG INFORMATION
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################

load("./singleDrugSynonyms2.RData")
load("./VICC_singleDrugSynonyms.RData")
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

# save(singleDrugSynonyms, file="./singleDrugSynonyms2.RData")

# Añadir masc y minusculas
#quitar y poner guiones y espacios

DrugName<-"NEOMYCIN SULFATE"
DrugName<-"DB07604"

getCHEMBLID<-function(DrugName){
  
  DrugName<-toupper(DrugName)
  load("./singleDrugSynonyms2.RData")
  iix<-agrep(DrugName,singleDrugSynonyms$Drug_synonyms, max=3, ignore.case = T)
  ChemblID<-singleDrugSynonyms$CHEMBL[iix]
  if(length(ChemblID>0)){
    return(unique(ChemblID))
  }
  if(length(ChemblID)==0){
    stop("No CHEMBL ID found")
  }
}

Chem<-getCHEMBLID(DrugName)


getDrugBankID<-function(DrugName){
  DrugName<-toupper(DrugName)
  load("./singleDrugSynonyms2.RData")
  iix<-agrep(DrugName,singleDrugSynonyms$Drug_synonyms, max=3, ignore.case = T)
  DB_ID<- singleDrugSynonyms$DB[iix]
  if(length(DB_ID>0)){
    return(unique(DB_ID))
  }
  if(length(DB_ID)==0){
    stop("No DrugBank ID found")
  }
}

DB<-getDrugBankID(Chem[1])




data.frame<-singleDrugSynonyms$Drug[1:10]
type<-"all" #("DB", "CHEMBL", "DH", "ALL")

DrugHelper<-function(data.frame, type){
  DrugName<-toupper(data.frame)
  load("./singleDrugSynonyms2.RData")
  iidx<-sapply(DrugName[1:3], FUN=function(X){return(agrep(X,singleDrugSynonyms$Drug_synonyms, max=2, ignore.case = T))})
  data.frame$CHEMBL_ID<-singleDrugSynonyms$CHEMBL[iidx]
}