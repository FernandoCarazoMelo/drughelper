## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval= FALSE-------------------------------------------------------------
#  install.packages("drughelper")
#  

## ---- eval=TRUE---------------------------------------------------------------
library(drughelper)

vectorofdrugs <- c("Procaine", "Furazosin", "Embelin", "NotADrug")

## ---- eval=FALSE--------------------------------------------------------------
#  downloadAbsentFile()
#  

## ---- eval = FALSE------------------------------------------------------------
#  checkDrugSynonym(vectorofdrugs)
#  

## ---- eval = TRUE, echo = FALSE, message = FALSE------------------------------
library(PharmacoGx)
library(drughelper)

data("GDSCsmall")
data("CCLEsmall")
data("CMAPsmall")

vector_CCLE <- rownames(CCLEsmall@drug)
vector_GDSC <- rownames(GDSCsmall@drug)
vector_CMAP <- rownames(CMAPsmall@drug)

# DRUG RESPONSES (BeatAML)
load("../data/drugResponse.rda")

vDrugResponse <- Drug_response$inhibitor
vBeatAML<- unique(vDrugResponse)

table_CCLE <- checkDrugSynonym(vector_CCLE)
table_GDSC <- checkDrugSynonym(vector_GDSC)
table_CMAP <- checkDrugSynonym(vector_CMAP)
table_BEAT <- checkDrugSynonym(vBeatAML)

## ---- eval = TRUE, message = FALSE--------------------------------------------
head(checkDrugSynonym(vector_CCLE))
head(checkDrugSynonym(vector_GDSC))
head(checkDrugSynonym(vector_CMAP))
head(checkDrugSynonym(vBeatAML))


## ---- eval = TRUE, echo = FALSE-----------------------------------------------
library(drughelper)
load("../data/geneInfo.rda")

Gene_Info <- subset(Gene_Info, (!is.na(Gene_Info[,7])), c(1, 7))

genDrugs = data.frame(Gene = character(), Drug = character())
vector_GINF <- c()
for (i in 1:nrow(Gene_Info)) {

  list <- unique(strsplit(Gene_Info$Drug[i], split=", "))
  genDrugs <- rbind(genDrugs, data.frame(Gene = Gene_Info$hgnc_symbol[i], Drug = unlist(list)))
  vector_GINF <- c(vector_GINF, unlist(list))
}
genDrugs <- unique(genDrugs)
vector_GINF <- unique(vector_GINF)

table1 <- checkDrugSynonym(vector_GINF)


## ---- eval = TRUE-------------------------------------------------------------
head(checkDrugSynonym(vector_GINF))

## ---- eval = TRUE-------------------------------------------------------------

#Without Drughelper

GDSC_GINF = 0
for (i in 1:length(vector_GDSC)) {
  if (vector_GDSC[i] %in% vector_GINF) {
    GDSC_GINF = GDSC_GINF + 1
  }
}

# With Drughelper

DH_GDSC_GINF = 0
for (i in 1:nrow(table_GDSC)) {
  if (table_GDSC$Suggested.Synonym[i] %in% table1$Suggested.Synonym) {
    DH_GDSC_GINF = DH_GDSC_GINF + 1
  }
}


## ---- eval = TRUE-------------------------------------------------------------
GDSC_GINF
DH_GDSC_GINF 



