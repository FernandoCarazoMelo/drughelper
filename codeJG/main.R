#########################################################################################
# MAIN SCRIPT
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################
load("./data/input/2020-12-17version/singleDrugSynonymsTabulatesDH_IDcreated.RData")
source("./codeDrugHelperFunction/DrugHelper.R")
source("./codeDrugHelperFunction/getCHEMBLID.R")
source("./codeDrugHelperFunction/getDrugBankID.R")


DrugName<-"NEOMYCIN SULFATE"
DrugName<-"DB07604"

Chem<-getCHEMBLID(DrugName)

DB<-getDrugBankID(Chem[1])

data.frame<-singleDrugSynonyms$Drug[1:110]

type<-"ALL" #("DB", "CHEMBL", "DH", "ALL")

data.frame<-singleDrugSynonyms$Drug[1:110]

type<-"ALL" #("DB", "CHEMBL", "DH", "ALL")


Result<-DrugHelper(data.frame, type)

