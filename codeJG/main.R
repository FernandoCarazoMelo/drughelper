#########################################################################################
# MAIN SCRIPT
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################
load("./data/input/2020-12-17version/singleDrugSynonymsTableUpdated.RData")
source("./codeJG/DrugHelper.R")
source("./codeJG/getCHEMBLID.R")
source("./codeJG/getDrugBankID.R")
source("./codeJG/updateSingleDrugSynonymsTable.R")

DrugName<-"cyclosporin"
#DrugName<-"DB07604"
DrugName<- toupper(DrugName)
#Quitar espacio y signos de puntuación
#sub solo quita el primer espacio del string, gsub quita todos a la vez
DrugName <- gsub("[^[:alnum:]]", " ", DrugName)
DrugName <- gsub("[[:blank:]]", "", DrugName)

synonyms <- singleDrugSynonyms$Drug_synonyms[grep(DrugName, singleDrugSynonyms$Drug_Synonyms_format)]

Chem<-getCHEMBLID(DrugName)

DB<-getDrugBankID(Chem[1])


data.frame<-singleDrugSynonyms$Drug[1:110]

type<-"ALL" #("DB", "CHEMBL", "DH", "ALL")

data.frame<-singleDrugSynonyms$Drug[1:110]

type<-"ALL" #("DB", "CHEMBL", "DH", "ALL")


Result<-DrugHelper(data.frame, type)

