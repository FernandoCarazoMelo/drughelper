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
  browser()

  for (i in 1:length(drugVector)) {

    daf[i, 1] <- drugVector[i]

    drugVector[i] <- formattingDrugName(drugVector[i])

    logicVector <- grepl(drugVector[i], datosChembl$synonyms_formatted)

    ifelse(TRUE %in% logicVector, daf[i, 2] <- TRUE, daf[i, 2] <- FALSE)

    auxVectorsynonyms <- datosChembl$Drug[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)]
    auxTable <-datosChembl[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1), ]

    tempDF = data.frame(Index = integer(), Synonyms = character())
    for (j in 1:length(auxVectorsynonyms)){

      list = unique(strsplit(auxTable$synonyms_formatted[j], split=";;;"))
      tempDF = rbind(tempDF, data.frame(Index = rownames(auxTable)[j], Synonyms = unlist(list)))
    }

    tempDF <- unique(tempDF)

    if (daf[i, 2] == TRUE) {
      daf[i, 3] <- datosChembl$DrugHelper[rownames(datosChembl) == tempDF$Index[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)[1]]]
      daf[i, 4] <- datosChembl$Drug[rownames(datosChembl) == tempDF$Index[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)[1]]]
    }
  }
  return(daf)

}
