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

