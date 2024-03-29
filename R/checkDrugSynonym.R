#' @title Check for drug synonyms
#' @description Given an input of drug synonyms, check if those drugs are approved and find a proper more used synonym
#' @param drugVector A string vector of undefined length, with Drug names
#' @return A dataframe containing: the input drug name, if it is approved or not, drughelper ID and a proper-more used synonym.
#' @examples
#' \donttest{
#' checkDrugSynonym(c("Procaine", "Furazosin", "Embelin"))
#' }
#' @import progress
#' @export


checkDrugSynonym <- function(drugVector) {

  if(is.null(drugVector)){
    stop("input drugVector must be a string vector")
  }

  pb <- progress_bar$new(total = 100)

  downloadAbsentFile(dir = tempdir())
  load(paste0(tempdir(), "/datosChembl.RData"))

  #DATAFRAME
  daf <- data.frame(x = character(),
                    Approved = character(),
                    DrugHelperID = character(),
                    Suggested.Synonym = character(),
                    Cl.Phase = integer(),
                    Matching = character())


  for (i in 1:length(drugVector)) {

    pb$tick(100/length(drugVector))

    daf[i, 1] <- drugVector[i]

    drug <- formattingDrugName(drugVector[i])

    drugVector[i] <- drug

    logicVector <- grepl(drugVector[i], datosChembl$synonyms_formatted, perl = TRUE, useBytes = TRUE)

    ifelse(TRUE %in% logicVector, daf[i, 2] <- TRUE, daf[i, 2] <- FALSE)

    aux_1 <- grep(drugVector[i], datosChembl$synonyms_formatted, perl = TRUE, useBytes = TRUE)
    auxVectorsynonyms <- datosChembl$Drug[aux_1]
    auxTable <-datosChembl[aux_1, ]

    tempDF = data.frame(Id = character(), Synonyms = character())

    for (j in 1:length(auxVectorsynonyms)){

        list = unique(strsplit(auxTable$synonyms_formatted[j], split=";;;"))
        tempDF = rbind(tempDF, data.frame(Id = auxTable$DrugHelper[j], Synonyms = unlist(list)))
    }

    tempDF <- unique(tempDF)

    if (daf[i, 2] == TRUE) {

      if (drug %in% auxTable$Drug) {

        aux_2 <- grep(paste0("^", drugVector[i],"$"), auxTable$Drug, perl = TRUE, useBytes = TRUE)

        daf[i, 3] <- auxTable$DrugHelper[aux_2][1]
        daf[i, 4] <- drug
        daf[i, 5] <- datosChembl$max_phase[aux_2][1]
        daf[i, 6] <- "Exact match"

      } else if (!is.na(tempDF$Id[grep(paste0("^", drugVector[i],"$"), tempDF$Synonyms)[1]])) {

        aux_3 <- tempDF$Id[grep(paste0("^", drugVector[i],"$"), tempDF$Synonyms, perl = TRUE, useBytes = TRUE)][1]
        aux_4 <- grep(aux_3, datosChembl$DrugHelper, perl = TRUE, useBytes = TRUE)

        daf[i, 3] <- aux_3
        daf[i, 4] <- datosChembl$Drug[aux_4][1]
        daf[i, 5] <- datosChembl$max_phase[aux_4][1]
        daf[i, 6] <- "Exact match"

      } else {

        aux_5 <- agrep(paste0("^", drugVector[i],"$"), tempDF$Synonyms, max.distance = 3, useBytes = TRUE)
        aux_6 <- grep(tempDF$Id[aux_5][1], datosChembl$DrugHelper, perl = TRUE, useBytes = TRUE)

        daf[i, 3] <- tempDF$Id[agrep(drugVector[i], tempDF$Synonyms)][1]
        daf[i, 4] <- datosChembl$Drug[aux_6][1]
        daf[i, 5] <- datosChembl$max_phase[aux_6][1]
        daf[i, 6] <- "Approximate match"

        }
    } else {

      daf[i, 4] <- toupper(daf[i, 1])
      daf[i, 6] <- "No match / clinical phase 0"
    }
  }
  return(daf)
}
