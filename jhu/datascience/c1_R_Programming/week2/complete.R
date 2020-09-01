# Assignment 1 - Part 2

# Write a function that reads a directory full of files and reports the number 
# of completely observed cases in each data file. The function should return a 
# data frame where the first column is the name of the file and the second 
# column is the number of complete cases. A prototype of this function follows

complete <- function(directory, id = 1:332) {
  ## 'directory is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  114
  ## 2  1041
  ## ...
  
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  ## create a vector called "nobs" and initialize same length as the 'id' 
  nobs <- vector(length = length(id))
  fns <- make_file_names(id, directory = directory)

  rdf <- data.frame()
  for (i in 1:length(fns)) {
    nobs[i] <- complete_row_count(fns[i])
  }
  
  # create a return data frame of nrow = length(id), ncol = 2, where
  # colunm names = c("id", "nobs")
  data.frame(id, nobs)
}


# load data frame from given CSV file name
load_df_from_file <- function(filename, remove.na = TRUE) {
  df <- if (remove.na) {
    subset(read.csv(filename), !is.na(sulfate) & !is.na(nitrate))
  } else {
    read.csv(filename)
  }
  df
}

# count the number of completed row in the given CSV file name
complete_row_count <- function(filename) {
  df <- load_df_from_file(filename)
  nrow(df)
}

# Creating a list of relative file name from set of IDs
# where 'directory' is the folder in which the CSV files located
# and 'pattern' is the blueprint for creating a file name.
make_file_names <- function(id, directory = "specdata", pattern = "%03d.csv") {
  if (is.na(directory) || nchar(directory) == 0) {
    sprintf(pattern, id)
  } else {
    paste(directory, "/", sprintf(pattern, id), sep = "")
  }
}

# Testing and test results
# source("complete.R")
# cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
# print(cc$nobs)
# [1] 228 148 124 165 104 460 232

# cc <- complete("specdata", 54)
# print(cc$nobs)
# [1] 219

# set.seed(42)
# cc <- complete("specdata", 332:1)
# use <- sample(332, 10)
# print(cc[use, "nobs"])
# [1] 711 135  74 445 178  73  49   0 687 237

