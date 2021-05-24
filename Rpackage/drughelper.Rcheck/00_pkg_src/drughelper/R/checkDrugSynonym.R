#' @title Check for drug synonyms
#' @description Given an input of drug synonyms, check if those drugs are approved and find a proper more used synonym
#' @param drugVector A string vector of undefined length, with Drug names
#' @return A dataframe containing: the input drug name, if it is approved or not, drughelper ID and a proper-more used synonym.
#' @examples
#' checkDrugSynonym(c("ibuPROfen", "CYClOSPORIN A", "MORPHINE", "lidocaina"))
#' @export


checkDrugSynonym <- function(drugVector) {

  #downloadAbsentFile(dir = tempdir())
  load("./data/datosChembl.RData") #tenemos que hacer load del tempdir

  #DATAFRAME
  daf <- data.frame(x = character(),
                    Approved = character(),
                    DrugHelperID = character(),
                    Suggested.Synonym = character())

    for (i in 1:length(drugVector)) {

    daf[i, 1] <- drugVector[i]

    drug <- formattingDrugName(drugVector[i])

    drugVector[i] <- drug

    logicVector <- grepl(drugVector[i], datosChembl$synonyms_formatted)

    ifelse(TRUE %in% logicVector, daf[i, 2] <- TRUE, daf[i, 2] <- FALSE)

    auxVectorsynonyms <- datosChembl$Drug[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)]
    auxTable <-datosChembl[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1), ]

    tempDF = data.frame(Id = character(), Synonyms = character())

    for (j in 1:length(auxVectorsynonyms)){

      list = unique(strsplit(auxTable$synonyms_formatted[j], split=";;;"))
      tempDF = rbind(tempDF, data.frame(Id = auxTable$DrugHelper[j], Synonyms = unlist(list)))
    }

    tempDF <- unique(tempDF)

    if (daf[i, 2] == TRUE) {

      if (drug %in% auxTable$Drug){

        daf[i, 3] <- auxTable$DrugHelper[auxTable$Drug == drug][1]
        daf[i, 4] <- drug

      } else {

        daf[i, 3] <- datosChembl$DrugHelper[datosChembl$DrugHelper == tempDF$Id[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)[1]]]
        daf[i, 4] <- datosChembl$Drug[datosChembl$DrugHelper == tempDF$Id[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)[1]]]
      }

    }

  }
  return(daf)
}
