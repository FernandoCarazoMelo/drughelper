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


###CREACION DE LA FUNCION

load("./data/input/2020-12-17version/datosChembl.RData")

source("./codeJG/checkDrugSynonym.R")

drugVector = c("ponatinib", "ibuprofeno", "CYClOSPORIN A", "MORPHINE")

checkDrugSynonym(drugVector)

#View(datosChembl[agrep("MORPHINE", datosChembl$synonyms_formatted, max.distance = 1), ])



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


