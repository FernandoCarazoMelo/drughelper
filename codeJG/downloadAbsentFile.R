downloadAbsentFile <- function (){
  
  if(!file.exists("./codeJG/datosChembl.tsv")) {
    
    URL <- "https://raw.githubusercontent.com/jaaaviergarcia/drughelper/main/datosChembl.tsv"
    download.file(URL ,destfile = "./codeJG/datosChembl.tsv")
  }
}


