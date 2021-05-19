#' @title Check for drug synonyms
#' @description Given an input of drug synonyms, check if those drugs are approved and find a proper more used synonym
#' @param drugVector A string vector of undefined length, with Drug names
#' @return A dataframe containing: the input drug name, if it is approved or not, drughelper ID and a proper-more used synonym.
#' @examples
#' checkDrugSynonym(c("ibuPROfen", "CYClOSPORIN A", "MORPHINE", "lidocaina"))
#' @export


checkDrugSynonym <- function(drugVector) {

  source("./R/drugHelperMain.R")
  addandsort()

  #DATAFRAME
  daf <- data.frame(x = character(),
                    Approved = character(),
                    DrugHelperID = character(),
                    Suggested.Synonym = character())

  for (i in 1:length(drugVector)) {

          daf[i, 1] <- drugVector[i]

          DrugName <- formattingDrugName(drugVector[i])

          drugVector[i] <- DrugName #estas dos ultimas lineas tengo que mejorarlas,
          #si encuentra mas de una coincidencia, devuelve la primera, deberia
          #devolver la que mas se parezca, hacer prueba con "morphine"

          logicVector <- grepl(drugVector[i], datosChembl$synonyms_formatted)

          if (TRUE %in% logicVector){
            daf[i, 2] <- TRUE
          } else {
            daf[i, 2] <- FALSE
          }


    auxVectorsynonyms <- datosChembl$Drug[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1)]
    auxTable <-datosChembl[agrep(drugVector[i], datosChembl$synonyms_formatted, max.distance = 1), ]

    tempDF = data.frame(Index = integer(), Synonyms = character())
    for (j in 1:length(auxVectorsynonyms)){

      list = unique(strsplit(auxTable$synonyms_formatted[j], split=";;;"))
      tempDF = rbind(tempDF, data.frame(Index = rownames(auxTable)[j], Synonyms = unlist(list)))
    }

    tempDF <- unique(tempDF)


    a <- rownames(datosChembl) == tempDF$Index[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)[1]]

    if (daf[i, 2] == TRUE) {
      daf[i, 3] = datosChembl$DrugHelper[rownames(datosChembl) == tempDF$Index[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)[1]]]
      daf[i, 4] = datosChembl$Drug[rownames(datosChembl) == tempDF$Index[grep(paste0("^",drugVector[i],"$"), tempDF$Synonyms)[1]]]
    }
  }
  return(daf)

}
