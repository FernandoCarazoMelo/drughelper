#' @title Download data from Chembl
#' @description If it has not been downloaded yet, downloads data of drugs
#' @export

downloadAbsentFile <- function (){
  
  if(!file.exists("./codeJG/datosChembl.tsv")) {
    
    URL <- "https://raw.githubusercontent.com/jaaaviergarcia/drughelper/main/datosChembl.tsv"
    download.file(URL ,destfile = "./codeJG/datosChembl.tsv")
  }
}


