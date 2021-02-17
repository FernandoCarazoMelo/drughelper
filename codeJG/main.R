#########################################################################################
# MAIN SCRIPT
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################
load("./data/input/2020-12-17version/singleDrugSynonymsTabulatesDH_IDcreated.RData")
source("./codeJG/DrugHelper.R")
source("./codeJG/getCHEMBLID.R")
source("./codeJG/getDrugBankID.R")


DrugName<-"BACITRACINA"
DrugName<-"DB07604"

#Quitar espacion y signos de puntuación
#sub solo quita el primer espacio del string, gsub quita todos a la vez
DrugName <- gsub("[[:blank:]]", "", DrugName)
DrugName <- gsub("[^[:alnum:]]", "", DrugName)

synonyms <- singleDrugSynonyms$Drug_synonyms(match(DrugName, singleDrugSynonyms$Drug_Synonims_format))

Chem<-getCHEMBLID(DrugName)

DB<-getDrugBankID(Chem[1])

data.frame<-singleDrugSynonyms$Drug[1:110]

type<-"ALL" #("DB", "CHEMBL", "DH", "ALL")

data.frame<-singleDrugSynonyms$Drug[1:110]

type<-"ALL" #("DB", "CHEMBL", "DH", "ALL")


Result<-DrugHelper(data.frame, type)

