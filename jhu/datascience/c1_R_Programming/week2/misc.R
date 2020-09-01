load_df_from_file <- function(filename, na.rm = TRUE) {
  df <- if (na.rm) {
    subset(read.csv(filename), !is.na(sulfate) & !is.na(nitrate))
  } else {
    subset(read.csv(filename))
  }
  df
}
