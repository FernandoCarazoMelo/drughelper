test_checkDrugSynonym <- function() {

  obs <- tryCatch(checkDrugSynonym(drugVector = NULL), error=conditionMessage)
  checkIdentical("input drugVector must be a string vector", obs)

}
