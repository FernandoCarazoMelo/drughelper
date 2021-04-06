downloadAbsentFile <- function (urlStr, oD = tempdir())
{
  fileName = tail(strsplit(urlStr, "/")[[1]], 1)
  temp <- paste(oD, "/", fileName, sep = "")
  if (!file.exists(temp) || file.info(temp)$size == 0)
    download.file(urlStr, temp)
  if (file.info(temp)$size == 0) {
    unlink(temp)
    temp = NULL
    cat(paste("ERROR: failed to download ", fileName,
              ".\nPlease check your internet connection and/or try again. ",
              "\nThen, if you still display this error message please contact us.",
              sep = ""))
  }
  return(temp)
}
