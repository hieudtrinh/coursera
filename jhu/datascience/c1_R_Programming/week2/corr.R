# Assignment 1 - Part 3

# Write a function that takes a directory of data files and a threshold for 
# complete cases and calculates the correlation between sulfate and nitrate for 
# monitor locations where the number of completely observed cases (on all 
# variables) is greater than the threshold. The function should return a vector 
# of correlations for the monitors that meet the threshold requirement. If no 
# monitors meet the threshold requirement, then the function should return a 
# numeric vector of length 0. A prototype of this function follows

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between nitrate and
  ## sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  
  fns <- list.files(directory, "*.csv")
  correlations <- vector(mode = "numeric")
  
  for (i in 1:length(fns)) {
    filename <- paste(directory, fns[i], sep = "/")
    df <- load_df_from_file(filename)
    if (nrow(df) > threshold) {
      correlations <- append(correlations, cor(df$sulfate, df$nitrate))
    }
  }
  correlations
  #data.frame(id, nobs)
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


# Testing and test results
# source("corr.R")
# cr <- corr("specdata")                
# cr <- sort(cr)   
# RNGversion("3.5.1")
# set.seed(868)                
# out <- round(cr[sample(length(cr), 5)], 4)
# print(out)
# [1]  0.2688  0.1127 -0.0085  0.4586  0.0447
#
# cr <- corr("specdata", 129)                
# cr <- sort(cr)                
# n <- length(cr)    
# RNGversion("3.5.1")
# set.seed(197)                
# out <- c(n, round(cr[sample(n, 5)], 4))
# print(out)
# [1] 243.0000   0.2540   0.0504  -0.1462  -0.1680   0.5969
#
# cr <- corr("specdata", 2000)                
# n <- length(cr)                
# cr <- corr("specdata", 1000)                
# cr <- sort(cr)
# print(c(n, round(cr, 4)))
# [1]  0.0000 -0.0190  0.0419  0.1901


