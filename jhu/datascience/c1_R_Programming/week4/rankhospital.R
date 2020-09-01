# rankhospital.R  
# Write a function called rankhospital that takes three arguments: 
# the 2-character abbreviated name of astate (state), an outcome (outcome), 
# and the ranking of a hospital in that state for that outcome (num).
# The function reads the outcome-of-care-measures.csv file and returns a 
# character vector with the name of the hospital that has the ranking 
# specified by the num argument. 

# For example, the call
# rankhospital("MD", "heart failure", 5)
# would return a character vector containing the name of the hospital with 
# the 5th lowest 30-day death rate for heart failure. The num argument can 
# take values “best”, “worst”, or an integer indicating the ranking
# (smaller numbers are better). If the number given by num is larger than 
# the number of hospitals in that state, then the function should return NA. 
# Hospitals that do not have data on a particular outcome should
# be excluded from the set of hospitals when deciding the rankings.

rankhospital <- function(state, outcome, num = "best") {
    ## 1) Read outcome data
    ## 2) Check that state and outcome are valid
    ## 3) Return hospital name in that state with the given rank
    ##    30-day death rate

    ## 1) Read outcome data
    outcome_data <- read.csv("outcome-of-care-measures.csv", 
                             colClasses = "character")
    
    ## 2) Check that state and outcome are valid
    states <- unique(outcome_data$State)
    
    ## Validate the input parameter 'state'
    if (is.na(match(state, states))) {
        # mesg <- sprintf('Error in best("%s", "%s") : invalid state', state, outcome)
        return ("invalid state")
    }
    
    # [2] "Hospital.Name"                                                                        
    # [7] "State"                                                                                
    # [11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"                            
    # [17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"                           
    # [23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" 
    
    ## common column: State, Hospital.Name
    cols <- c(2, 7)
    
    ## Create a mapping of valid 'outcome' parameter to column index
    outcome_map <- new.env(hash = TRUE)
    outcome_map[["heart attack"]] <- 11
    outcome_map[["heart failure"]] <- 17
    outcome_map[["pneumonia"]] <- 23
    
    ## Validate the 'outcome' parameter
    index <- outcome_map[[outcome]]
    if (is.null(index)) {
        return(" invalid outcome")
    }
    
    ## Create query column indexes
    cols <- c(cols, index)
    
    ## Query 
    ## 1) select subset by given column indexes 'cols'
    ## 2) select records that have state match 'state' parameter
    df <- subset(outcome_data[cols], State == state)
    
    ## Change the outcome colunm name to "Rate"
    names(df)[3] <- "Rate"
    
    
    ## Creates or coerces objects of type 'numeric'
    df[, length(cols)] <- as.numeric(df[, length(cols)])
    
    ## Filter out the NA on the 'outcome' parameter
    ## df <- subset(df, !is.na(df[, 3])) or
    df <- subset(df, !is.na(df$Rate))
    
    ## Sort df by 'outcome', State, which is c(3,2)
    order.by = order(df[,3], df[,1])
    df <- df[order.by,]
    df$Rank <- 1:nrow(df)
    
    ## 3) Return hospital name in that state with the given rank
    ##    30-day death rate
    if (num == "best") {
        df[1, 1]
    } else if (num == "worst") {
        df[nrow(df), 1]
    } else {
        nth <- as.integer(num)
        df[nth, 1]
    }
}

## Testing
## source("rankhospital.R")
## 1) rankhospital("NC", "heart attack", "worst")
##    [1] "WAYNE MEMORIAL HOSPITAL"

## 2) rankhospital("WA", "heart attack", 7)
##    [1] "YAKIMA VALLEY MEMORIAL HOSPITAL"

## 3) rankhospital("TX", "pneumonia", 10)
##    [1] "SETON SMITHVILLE REGIONAL HOSPITAL"

## 4) rankhospital("NY", "heart attack", 7)
##    [1] "BELLEVUE HOSPITAL CENTER"


