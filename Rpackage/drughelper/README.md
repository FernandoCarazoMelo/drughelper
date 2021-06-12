---
title: "DrugHelper: Identification and correction of drug names database"
output: 
  html_document:
    keep_md: true
---

## Introduction to Drughelper

Drughelper is an R package to identify and correct some drug names of the user's interest in order to easily work with them. Drughelper is constantly updating its dataset (once a month) from Chembl's database.

## Installation
Drughelper can be installed from CRAN repository:

`install.packages("drughelper")`

### Scripts

* **`checkDrugSynonym`** Main function of the proyect which the user will work with.  
* **`downloadAbsentFile`** Downloads the drug dataset where the search is performed. This function is optional, otherwise `checkDrugSynonym` also downloads the dataset if it is not found in the current directory.  
* **`formattingDrugName`** A function which corrects a bad input for a drug name and returns the synonyms of the corrected name drug.
* **`AuxFunctions`** Internal functions performed in order to build the dataset.  

### Data  

Data with drugs and synonyms from ChEMBl: `datosChembl.RData`. It is downloaded through `downloadAbsentFile` function.
  
#### Information:

Information of the columns from `datosChembl.RData`:

* **Drug**: Name of each chosen drug.
* **DrugHelperid**: Identification code created for the project.
* **Chemblid**: Identification code from ChEMBL database.
* **formula**: molecular formula for each drug.
* **maxphase**: Clinical phase in which each drug is in.
* **synonyms**: All drug synonyms for each drug.
* **synonymsformatted**: Drug synonyms without punctuation marks or spaces.
* **canonical**: Canonical formula/structure of each drug.

