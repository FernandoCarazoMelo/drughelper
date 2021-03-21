---
title: "DrugHelper: Identification and correction of drug names database"
output: 
  html_document:
    keep_md: true
---


Info about code and datasets of DrugHelper project  

> **DATA:**  
  (1) Last data file version: "singleDrugSynonymsTableUpdated.RData"
  (2) Data with drugs and synonyms from ChEMBl: "datosChembl.RData"
  
 >> **Columns(1):**  
      Drug: Name of each chosen drug  
      Drug_synonyms: All drug synonyms for each drug  
      CHEMBL: Identification code from ChEMBL database  
      DB: Identification code from DrugBank database  
      DrugHelper: Identification code created for the project
      Drug_synonyms_format: Drug synonyms without punctuation marks or spaces
    
 >> **Columns(2)**  
      Drug: Name of each chosen drug  
      DrugHelperid: Identification code created for the project  
      Chemblid: Identification code from ChEMBL database  
      formula: molecular formula for each drug  
      maxphase: Clinical phase each drug is in  
      synonyms: All drug synonyms for each drug  
      synonymsformatted: Drug synonyms without punctuation marks or spaces  
      canonical: Canonical formula/structure of each drug  
      
> **CODE:**  

>> **FOLDERS:**  
  generateDB: Every necessary script for running Drughelper function  
  notUsed: Other useful scripts for the creation of the project, but without direct use.  
  tempfuncts: Temporal functions to check punctual issues  
  
>> **SCRIPTS**  
  __generateDB folder:__  
  chemblTable.py: A python script in which a dataframe with Chembl synonyms was created  
  datosChembl.tsv: chemblTable exported to R  
  drugHelperMain.R: Main script of the proyect where the dataframe is being builded  
 formattingSynonymsTable: Function which create a new column with standarized synonyms  
 getPubChemSynonyms.R: A function which collects all synonyms for each drug from PubChem database  
  updateDrugsWithSynonyms.R: A script in which raw list of synonyms was included in the table  
  __notUsed folder:__  
  DrugHelper.R: raw function for the creation of the dataframe  
  PreprocessingDrugInformation.R: A script in which the first version of "SingleDrugSynonyms" table was created  
  __tempfuncts folder:__  
  getCHEMBLID.R: A function which collects the ID from CHEMBL database  
  getDrugBankID.R: A function which collects the ID from DrugBank database  
  main.R: script in which punctual issues are perform and temporal-function calling is done  
  __out of folders:__  
  checkDrugSynonym: Main function of the proyect which the user will work with  
  formattingDrugName: A function which corrects a bad input for a drug name and returns the synonyms of the corrected name drug  
  