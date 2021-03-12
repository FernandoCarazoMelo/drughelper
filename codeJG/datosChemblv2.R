# En este script juntamos los sinonimos de la base de datos 
# de Chembl con los sinonimos de la base de datos de Pubchem
# relativos a los farmacos de Chembl


load("./data/input/2020-12-17version/datosChembl.RData")
load("./data/input/2020-12-17version/singleDrugSynonymsChembl.RData")

for (i in 1:nrow(datosChembl)){
  datosChembl$synonyms[i] <- toupper(datosChembl$synonyms[i])
}

datosChembl$synonymsChemble <- singleDrugSynonymsChembl$Drug_synonyms


for (j in 1:nrow(datosChembl)){
  if (is.na(datosChembl$synonyms[j]))
    datosChembl$synonyms[j] <- datosChembl$synonymsChembl[j]
  else
    datosChembl$synonyms[j] <- paste(datosChembl$synonymsChembl[j], datosChembl$synonyms[j], sep=";;;")
}

datosChembl <- datosChembl[,-7]

#vaux = vector auxiliar
for (k in 1:nrow(datosChembl)){
  
  vaux <- strsplit(datosChembl$synonyms[k], ";;;")[[1]]
  vaux <- unique(vaux)
  datosChembl$synonyms[k] <- paste(vaux, collapse = ";;;")
  
}

datosChemblv2 <- datosChembl
save(datosChemblv2, file = "./data/input/2020-12-17version/datosChemblv2.RData")


# A continuacion el objetivo es llamar a la funcion ya
# creada para que formatee la columna de sinonimos
# (quitar espacios y signos de puntuación)

source("./codeJG/formattingSynonymsTable.R")
updateTable(datosChemblv2)
#guarda un archivo RData dentro de la función


#Introducimos otras columnas como ids u otra información:

datosChemblv2formatted$DrugHelper <- paste0("DH0",1:nrow(datosChemblv2formatted)) 

