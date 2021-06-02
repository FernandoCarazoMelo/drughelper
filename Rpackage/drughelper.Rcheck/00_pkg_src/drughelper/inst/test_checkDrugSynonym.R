test_checkDrugSynonym(){

  obs <- tryCatch(checkDrugSynonym(drugvector = NULL), error=conditionMessage)
  checkIdentical("input drugVector must be a string vector", obs)

}
