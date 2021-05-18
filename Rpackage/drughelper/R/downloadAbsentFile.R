#' @title Download data from Chembl
#' @description If it has not been downloaded yet, downloads data of drugs
#' @export

downloadAbsentFile <- function (dir = tempdir()){

  if(!file.exists(paste0(tempdir(),"/datosChembl.tsv"))) {

    URL <- "https://raw.githubusercontent.com/jaaaviergarcia/drughelper/main/datosChembl.tsv"
    download.file(URL ,destfile =  paste0(tempdir(),"/datosChembl.tsv"))
  }
}


