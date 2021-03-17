#########################################################################################
# PREPROCESSING DRUG INFORMATION
# Code Author: Marian Gimeno -- mgimenoc@tecnun.es
# Conceptual Design: Fernando Carazo -- fcarazo@tecnun.es
# Data Developer: Carlos Castilla -- ccastilla.1@tecnun.es
#########################################################################################


# THIS SHOULD BE ADAPTED IF REQUIRED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

library(webchem)
library(xml2)
library(XML)
library(rvest)
#library(RCurl)
library(httr)
library(stringr)




getPubChemSynonyms <- function(currDrug = NULL){
  
  if (length(currDrug) == 0){
    return(NA)
  }
  if (is.na(currDrug) == TRUE){
    return(NA)
  }
  if (currDrug == ""){
    return("")
  }
  if (currDrug == "-"){
    return("-")
  }
  
  listCompoundsSynonyms <- unlist(pc_synonyms(currDrug, from = "name"))
  names(listCompoundsSynonyms) <- NULL
  listCompoundsSynonyms <- unique(listCompoundsSynonyms)
  if (length(listCompoundsSynonyms) > 0){
    if (is.na(listCompoundsSynonyms) == TRUE){
      synonyms <- currDrug
    }else{
      synonyms <- unique(c(listCompoundsSynonyms, currDrug))
    }
  }else{
    synonyms <- currDrug
  }
  
  
  currDrugHTML <- URLencode(currDrug) # Replace white spaces with html code
  curr_url <- paste0("https://pubchem.ncbi.nlm.nih.gov/rest/pug/substance/name/", currDrugHTML,"/synonyms/XML")
  # data <- curr_url # getURL(curr_url) # It does not work right now (04-09-2020)
  req <- httr::GET(curr_url)
  httr::message_for_status(req)
  data <- content(req, as = "text")
  
  data <- read_xml(data)
  data <- xml_find_all(data,"//*")
  
  if (length(data) > 1){
    for (r in 2:length(data)){
      if (length(grep("Information", data[r], ignore.case = TRUE)) == 0 & length(grep("<SID>",data[r], ignore.case = TRUE)) > 0){
        currSID <- str_remove(data[r],"<SID>")
        currSID <- str_remove(currSID,"</SID>")
        synonyms <- c(synonyms, currSID)
      }
      if (length(grep("Information", data[r], ignore.case = TRUE)) == 0 & length(grep("<Synonym>", data[r], ignore.case = TRUE)) > 0){
        currSynonym <- str_remove(data[r],"<Synonym>")
        currSynonym <- str_remove(currSynonym,"</Synonym>")
        synonyms <- c(synonyms, currSynonym)
      }
    }
  }
  synonyms <- unique(synonyms)
  
  return(synonyms)
}
                                   
                                   
                      
