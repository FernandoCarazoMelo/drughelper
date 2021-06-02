## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#> "
)

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages("drughelper")
#  

## -----------------------------------------------------------------------------
library(drughelper)

vectorofdrugs <- c("Procaine", "Furazosin", "Embelin", "NotADrug")

## -----------------------------------------------------------------------------
checkDrugSynonym(vectorofdrugs)


## ----eval = FALSE-------------------------------------------------------------
#  downloadAbsentFile()
#  

