#########################################################################################
# FUNCTION GET DRUGHELPERID
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################

DrugHelper<-function(data.frame, type){
  data.frame<-as.data.frame(data.frame)
  DrugName<-toupper(data.frame$data.frame)
  
  
  load("./data/input/2020-12-17version/singleDrugSynonymsTabulatesDH_IDcreated.RData")
  iidx<-sapply(DrugName, FUN=function(X){return(grep(X, singleDrugSynonyms$Drug_synonyms))})
  
  if(type=="ALL"){
    data.frame$CHEMBL_ID<-NA
    data.frame$DB_ID<-NA
    data.frame$DH_ID<-NA
    data.frame$OTHERSYNONYMS<-NA
    
    for(j in names(iidx)){
      data.frame$CHEMBL_ID[which(DrugName==j)]<-paste(singleDrugSynonyms$CHEMBL[iidx[[as.character(j)]]], collapse=";")
      data.frame$DB_ID[which(DrugName==j)]<-paste(singleDrugSynonyms$DB[iidx[[as.character(j)]]], collapse=";")
      data.frame$DH_ID[which(DrugName==j)]<-paste(singleDrugSynonyms$DrugHelper[iidx[[as.character(j)]]], collapse=";")
      data.frame$OTHERSYNONYMS[which(DrugName==j)]<-singleDrugSynonyms$Drug_synonyms[iidx[[as.character(j)]]]
    }
    return(data.frame)
  }
  
  if(type=="CHEMBL"){
    data.frame$CHEMBL_ID<-NA
    
    for(j in names(iidx)){
      data.frame$CHEMBL_ID[which(DrugName==j)]<-paste(singleDrugSynonyms$CHEMBL[iidx[[as.character(j)]]], collapse=";")
    }
    return(data.frame)
  }
  
  
  if(type=="DB"){
    data.frame$DB_ID<-NA
    
    for(j in names(iidx)){
      data.frame$DB_ID[which(DrugName==j)]<-paste(singleDrugSynonyms$DB[iidx[[as.character(j)]]], collapse=";")
    }
  }
  
  if(type=="DH"){
    data.frame$DH_ID<-NA
    
    for(j in names(iidx)){
      data.frame$DH_ID[which(DrugName==j)]<-paste(singleDrugSynonyms$DrugHelper[iidx[[as.character(j)]]], collapse=";")
    }
  }
}
























