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

drugVector = c("ibuPROfen", "CYClOSPORIN A", "MORPHINE", "lidocaina", "novocain")

checkDrugSynonym(drugVector)




###CONSEGUIR OTROS IDs

source("./codeJG/getCHEMBLID.R")
source("./codeJG/getDrugBankID.R")

Chem<-getCHEMBLID(DrugName)
DB<-getDrugBankID(Chem[1])


