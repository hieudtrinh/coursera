# Write a function called best that take two arguments: the 2-character 
# abbreviated name of a state and an outcome name. The function reads 
# the outcome-of-care-measures.csv file and returns a character vector
# with the name of the hospital that has the best (i.e. lowest) 30-day 
# mortality for the specified outcome in that state. The hospital name 
# is the name provided in the Hospital.Name variable. The outcomes can
# be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals 
# that do not have data on a particular outcome should be excluded 
# from the set of hospitals when deciding the rankings.

# The function should use the following template.
best <- function(state, outcome) {
    ## This function will do the following
    ## 1) Read outcome data
    ## 2) Check that state and outcome are valid
    ## 3) Return hospital name in that state with lowest 30-day death rate

    ## 1) Read outcome data
    outcome_data <- read.csv("outcome-of-care-measures.csv", 
                             colClasses = "character")
    
    ## 2) Check that state and outcome are valid
    states <- unique(outcome_data$State)
    
    ## Validate the input parameter 'state'
    if (is.na(match(state, states))) {
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
    
    ## 3) Return hospital name in that state with lowest 30-day death rate
    df[1,1]
}


## Testing
## source("best.R")
## 1) best("SC", "heart attack")
##    [1] "MUSC MEDICAL CENTER"

## 2) best("NY", "pneumonia")
##    [1] "MAIMONIDES MEDICAL CENTER"

## 3) best("AK", "pneumonia")
##    [1] "YUKON KUSKOKWIM DELTA REG HOSPITAL"
