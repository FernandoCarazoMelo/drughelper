#' @title Check for drug synonyms
#' @description Given an input of drug synonyms, check if those drugs are approved and find a proper more used synonym
#' @param drugVector A string vector of undefined length, with Drug names
#' @return A dataframe containing: the input drug name, if it is approved or not, drughelper ID and a proper-more used synonym.
#' @examples
#' checkDrugSynonym(c("Procaine", "Bacitracin", "Pac-1", "Furazosin", "Embelin", "NotADrug"))
#' @export


checkDrugSynonym <- function(drugVector) {

  library(progress)
  pb <- progress_bar$new(total = 100)
  for (i in 1:100) {
    pb$tick()
    Sys.sleep(1 / 100)
  }

  downloadAbsentFile(dir = tempdir())
  load(paste0(tempdir(), "/datosChembl.RData"))
  # load("./data/datosChembl.RData") #tenemos que hacer load del tempdir


  #DATAFRAME
  daf <- data.frame(x = character(),
                    Approved = character(),
                    DrugHelperID = character(),
                    Suggested.Synonym = character(),
                    Cl.Phase = integer(),
                    Matching = character())

      for (i in 1:length(drugVector)) {

      daf[i, 1] <- drugVector[i]

      drug <- formattingDrugName(drugVector[i])

      drugVector[i] <- drug

      logicVector <- grepl(drugVector[i], datosChembl$synonyms_formatted, perl = TRUE, useBytes = TRUE)

      ifelse(TRUE %in% logicVector, daf[i, 2] <- TRUE, daf[i, 2] <- FALSE)

      auxVectorsynonyms <- datosChembl$Drug[grep(drugVector[i], datosChembl$synonyms_formatted, perl = TRUE, useBytes = TRUE)]
      auxTable <-datosChembl[grep(drugVector[i], datosChembl$synonyms_formatted, perl = TRUE, useBytes = TRUE), ]

      tempDF = data.frame(Id = character(), Synonyms = character())

      for (j in 1:length(auxVectorsynonyms)){

        list = unique(strsplit(auxTable$synonyms_formatted[j], split=";;;"))
        tempDF = rbind(tempDF, data.frame(Id = auxTable$DrugHelper[j], Synonyms = unlist(list)))
      }

      tempDF <- unique(tempDF)

      if (daf[i, 2] == TRUE) {

        if (drug %in% auxTable$Drug) {

          daf[i, 3] <- auxTable$DrugHelper[grep(paste0("^", drugVector[i],"$"), auxTable$Drug, perl = TRUE, useBytes = TRUE)][1]
          daf[i, 4] <- drug
          daf[i, 5] <- datosChembl$max_phase[grep(drug, datosChembl$Drug, perl = TRUE, useBytes = TRUE)][1]
          daf[i, 6] <- "Exact match"

        } else if (!is.na(tempDF$Id[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)[1]])) {

          aux_dh <- tempDF$Id[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)][1]

          daf[i, 3] <- aux_dh
          daf[i, 4] <- datosChembl$Drug[grep(tempDF$Id[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms, perl = TRUE, useBytes = TRUE)][1], datosChembl$DrugHelper, perl = TRUE, useBytes = TRUE)][1]
          daf[i, 5] <- datosChembl$max_phase[grep(tempDF$Id[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms, perl = TRUE, useBytes = TRUE)][1], datosChembl$DrugHelper, perl = TRUE, useBytes = TRUE)][1]
          daf[i, 6] <- "Exact match"

        } else {

          daf[i, 3] <- tempDF$Id[agrep(drugVector[i], tempDF$Synonyms)][1]
          daf[i, 4] <- datosChembl$Drug[grep(tempDF$Id[agrep(paste0("^",drugVector[i],"$"), tempDF$Synonyms, max.distance = 3, useBytes = TRUE)][1], datosChembl$DrugHelper, perl = TRUE, useBytes = TRUE)][1]
          daf[i, 5] <- datosChembl$max_phase[grep(tempDF$Id[agrep(paste0("^",drugVector[i],"$"), tempDF$Synonyms, max.distance = 3, useBytes = TRUE)][1], datosChembl$DrugHelper, perl = TRUE, useBytes = TRUE)][1]
          daf[i, 6] <- "Approximate match"

          }
      } else {

        daf[i, 4] <- toupper(daf[i, 1])
        daf[i, 6] <- "No match / clinical phase 0"
      }
  }
  return(daf)
}
