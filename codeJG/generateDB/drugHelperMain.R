# En este script leemos el archivo generado en python y 
# juntamos los sinonimos de la base de datos de Chembl
# con los sinonimos de la base de datos de Pubchem
# relativos a los farmacos de Chembl

library(readr)
datosChembl <- read_delim("codeJG/generateDB/datosChembl.tsv", "\t", escape_double = FALSE, trim_ws = TRUE)

load("./data/input/2020-12-17version/singleDrugSynonymsChembl.RData")

for (i in 1:nrow(datosChembl)){
  datosChembl$synonyms[i] <- toupper(datosChembl$synonyms[i])
}

datosChembl$synonymsChembl <- singleDrugSynonymsChembl$Drug_synonyms


for (j in 1:nrow(datosChembl)){
  if (is.na(datosChembl$synonyms[j]))
    datosChembl$synonyms[j] <- datosChembl$synonymsChembl[j]
  else
    datosChembl$synonyms[j] <- paste(datosChembl$synonymsChembl[j], datosChembl$synonyms[j], sep=";;;")
}

datosChembl <- datosChembl[,-7]

#UNIQUE SYNONYMS
#vaux = vector auxiliar
for (k in 1:nrow(datosChembl)){
  
  vaux <- strsplit(datosChembl$synonyms[k], ";;;")[[1]]
  vaux <- unique(vaux)
  datosChembl$synonyms[k] <- paste(vaux, collapse = ";;;")
  
}

# A continuacion el objetivo es llamar a la funcion ya
# creada para que formatee la columna de sinonimos
# (quitar espacios y signos de puntuación)

source("./codeJG/generateDB/formattingSynonymsTable.R")
datosChembl <- updateTable(datosChembl)

#Introducimos otras columnas como ids u otra información:

datosChembl$DrugHelper <- paste0("DH0",1:nrow(datosChembl)) 

#Ordenamos las columnas

datosChembl = subset(datosChembl, select = c(8,2,1,4,5,6,7,3))
save(datosChembl, file = "./data/input/2020-12-17version/datosChembl.RData")
