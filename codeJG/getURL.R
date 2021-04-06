function ()
{
  "\nDescription:\n  Returns the STRING proteins data frame.\n  (it downloads and caches the information the first time that is called).\n\nAuthor(s):\n   Andrea Franceschini\n"
  if (nrow(proteins) == 0) {
    temp = downloadAbsentFile(paste("https://stringdb-static.org/download/protein.info.v",
                                    version, "/", species, ".protein.info.v",
                                    version, ".txt.gz", sep = ""), oD = input_directory)
    proteinsDf <- read.table(temp, sep = "\t", header = TRUE,
                             stringsAsFactors = FALSE, fill = TRUE, quote = "")
    proteinsDf2 = subset(proteinsDf, select = c("protein_external_id",
                                                "preferred_name", "protein_size", "annotation"))
    proteins <<- proteinsDf2
  }
  return(proteins)
}


#proteinsDf <- read.table("C:/Users/javie/OneDrive/Escritorio/drughelper/codeJG/generateDB/datosChembl.rar", sep = "\t", header = TRUE,
#                         stringsAsFactors = FALSE, fill = TRUE, quote = "")

#datosChembl <- read.delim("C:/Users/javie/OneDrive/Escritorio/drughelper/codeJG/generateDB/datosChembl.rar")

temp = downloadAbsentFile("https://docs.google.com/document/d/1fzX2MJVFJlhAL6V1RmArNn1RmvQIFKnIG0id0gjLI7I/edit?usp=sharing", oD = input_directory)
proteinsDf <- read.table(temp, sep = "\t", header = TRUE,
                         stringsAsFactors = FALSE, fill = TRUE, quote = "")