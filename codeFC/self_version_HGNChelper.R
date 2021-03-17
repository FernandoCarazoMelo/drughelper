HGNChelper_F <- function (x, unmapped.as.na = TRUE, map = NULL, species = "human")
{
  lastupdate <- readLines(system.file(file.path("extdata",
                                                "date_of_last_update.txt"), package = "HGNChelper"))
  if (class(x) != "character") {
    x <- as.character(x)
    warning("coercing x to character.")
  }
  casecorrection <- FALSE
  if (identical(species, "human")) {
    casecorrection <- TRUE
    if (is.null(map)) {
      message(paste("Maps last updated on:", lastupdate,
                    collapse = " "))
      map <- HGNChelper::hgnc.table
    }
  }
  else if (identical(species, "mouse") & is.null(map)) {
    message(paste("Maps last updated on:", lastupdate,
                  collapse = " "))
    map <- HGNChelper::mouse.table
  }
  else {
    if (is.null(map)) {
      stop("If species is not 'human' or 'mouse' then map argument must be specified")
    }
  }
  if (!is(map, "data.frame") | !identical(colnames(map),
                                          c("Symbol", "Approved.Symbol")))
    stop("If map is specified, it must be a dataframe with two columns named 'Symbol' and 'Approved.Symbol'")
  approved <- x %in% map$Approved.Symbol
  if (casecorrection) {
    x.casecorrected <- toupper(x)
    x.casecorrected <- sub("(.*C[0-9XY]+)ORF(.+)",
                           "\\1orf\\2", x.casecorrected)
  }
  else {
    x.casecorrected <- x
  }
  approvedaftercasecorrection <- x.casecorrected %in% map$Approved.Symbol
  if (!identical(all.equal(x, x.casecorrected), TRUE))
    warning("Human gene symbols should be all upper-case except for the 'orf' in open reading frames. The case of some letters was corrected.")
  alias <- x.casecorrected %in% map$Symbol
  df <- data.frame(x = x, Approved = approved, Suggested.Symbol = sapply(1:length(x),
                                                                         function(i) ifelse(approved[i], x[i], ifelse(alias[i],
                                                                                                                      paste(map$Approved.Symbol[x.casecorrected[i] == map$Symbol],
                                                                                                                            collapse = " /// "), ifelse(approvedaftercasecorrection[i],
                                                                                                                                                        x.casecorrected[i], NA)))), stringsAsFactors = FALSE)
  df$Approved[is.na(df$x)] <- FALSE
  if (!unmapped.as.na) {
    df[is.na(df$Suggested.Symbol), "Suggested.Symbol"] <- df[is.na(df$Suggested.Symbol),
                                                             "x"]
  }
  if (sum(df$Approved) != nrow(df))
    warning("x contains non-approved gene symbols")
  return(df)
}
