---
title: "DrugHelper: Identification and correction of drug names database"
output: 
  html_document:
    keep_md: true
---


Info about code and datasets of DrugHelper project  

> **DATA:**  
  Last data file version: "singleDrugSynonymsTableUpdated.RData"
  Data with drugs and synonyms from ChEMBl: "datosChembl.RData"
  
 >> **Columns:**  
      Drug: Name of each chosen drug  
      Drug_synonyms: All drug synonyms for each drug  
      CHEMBL: Identification code from ChEMBL database  
      DB: Identification code from DrugBank database  
      DrugHelper: Identification code created for the project
      Drug_synonyms_format: Drug synonyms without punctuation marks or spaces
    
> **CODE:**  

>> **Scripts:**  
  getCHEMBLID.R: A function which collects the ID from CHEMBL database  
  getDrugBankID.R: A function which collects the ID from DrugBank database  
  getPubChemSynonyms.R: A function which collects all synonyms for each drug    from PubChem database  
  PreprocessingDrugInformation.R: A script in which the first version of "SingleDrugSynonyms" table was created  
  updateDrugsWithSynonyms.R: A script in which raw list of synonyms was included in the table  
  updateSingleDrugSynonymsTable.R: A script in which text from drug synonyms was processed and joined to the table
