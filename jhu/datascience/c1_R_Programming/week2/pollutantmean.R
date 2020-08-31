# Assignment 1 - Part 1

# Write a function named 'pollutantmean' that calculates the mean of a 
# pollutant (sulfate or nitrate) across a specified list of monitors. The 
# function 'pollutantmean' takes three arguments: 'directory', 'pollutant', 
# and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that 
# monitors' particulate matter data from the directory specified in the 
# 'directory' argument and returns the mean of the pollutant across all of 
# the monitors, ignoring any missing values coded as NA. A prototype of the 
# function is as follows

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrade".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  fns <- make_file_names(id, directory = directory)
  rdf <- data.frame()
  for (i in 1:length(fns)) {
    rdf <- rbind(rdf, read.csv(fns[i]))
  }
  rmean = mean(rdf[, pollutant], na.rm = TRUE)
  round(rmean, 3)
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
# source("pollutantmean.R")
# pollutantmean("specdata", "sulfate", 1:10)
# [1] 4.064
# pollutantmean("specdata", "nitrate", 70:72)
# [1] 1.706
# pollutantmean("specdata", "sulfate", 34)
# [1] 1.477
# pollutantmean("specdata", "nitrate")
# [1] 1.703


