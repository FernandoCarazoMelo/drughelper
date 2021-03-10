#########################################################################################
# MAIN SCRIPT
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################

load("./data/input/2020-12-17version/singleDrugSynonymsTableUpdated.RData")

source("./codeJG/DrugHelper.R")



###HACER EL MATCH

source("./codeJG/formattingDrugName.R")

DrugName<-"cyclosporin"

synonyms <- formattingDrugName(DrugName)




###CREACION DE LA FUNCIÓN

load("./data/input/2020-12-17version/singleDrugSynonymsTableUpdated.RData")

source("./codeJG/checkDrugSynonym.R")

drugVector = c("BACi TRACINa", "NA  dH", "CYCL  OSPORIN A")

dataframex <- checkDrugSynonym(drugVector)







###CONSEGUIR OTROS IDs

source("./codeJG/getCHEMBLID.R")
source("./codeJG/getDrugBankID.R")

Chem<-getCHEMBLID(DrugName)
DB<-getDrugBankID(Chem[1])


data.frame<-singleDrugSynonyms$Drug[1:110]

type<-"ALL" #("DB", "CHEMBL", "DH", "ALL")

data.frame<-singleDrugSynonyms$Drug[1:110]

type<-"ALL" #("DB", "CHEMBL", "DH", "ALL")

Result<-DrugHelper(data.frame, type)

