# source("rankall.R")
# Write a function called rankall that takes two arguments: an outcome 
# name (outcome) and a hospital ranking (num). The function reads the 
# outcome-of-care-measures.csv file and returns a 2-column data frame
# containing the hospital in each state that has the ranking specified 
# in num. For example the function call rankall("heart attack", "best") 
# would return a data frame containing the names of the hospitals that
# are the best in their respective states for 30-day heart attack death 
# rates. The function should return a value for every state (some may be NA). 
# The first column in the data frame is named hospital, which contains
# the hospital name, and the second column is named state, which contains 
# the 2-character abbreviation for the state name. Hospitals that do not 
# have data on a particular outcome should be excluded from the set of
# hospitals when deciding the rankings. Handling ties. The rankall function 
# should handle ties in the 30-day mortality rates in the same way
# that the rankhospital function handles ties.

# The function should use the following template.
# 'num' can be "best", "worst" or an integer
rankall <- function(outcome, num = "best") {
    ## 1) Read outcome data
    ## 2) Check that state and outcome are valid
    ## 3) For each state, find the hospital of the given rank
    ## 4) Return a data frame with the hospital names and the
    ##   (abbreviated) state name

    ## 1) Read outcome data
    outcome_data <- read.csv("outcome-of-care-measures.csv", 
                             colClasses = "character")
    
    ## 2) Check that state and outcome are valid
    states <- sort(unique(outcome_data$State))
    
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
    
    ## Create query column indexes, i.e. Hospital.Name, State, ..Rates...
    cols <- c(cols, index)
    
    ## Query 
    ## 1) select subset by given column indexes 'cols'
    ## 2) select records that have state match 'state' parameter
    df <- outcome_data[cols]
    
    ## Change the 'outcome' colunm name to "Rate"
    names(df)[3] <- "Rate"
    
    ## Creates or coerces objects of type 'numeric'
    df[, length(cols)] <- as.numeric(df[, length(cols)])
    
    ## Filter out the NA on the 'outcome' parameter
    ## df <- subset(df, !is.na(df[, 3])) or
    df <- subset(df, !is.na(df$Rate))
    
    ## Sort df by State, Rate, Hospital.Name
    order.by = order(df[,2], df[,3], df[,1])
    df <- df[order.by, ]

    ## Processing the each state and select the hospital by 'num'
    ## First create a data frame storing result of the query
    ans <- data.frame(matrix(nrow = length(states), ncol = 2))
    rownames(ans) <- states
    colnames(ans) <- c("hospital", "state")
    ans[, 2] <- states
    
    # Loop through each of the states, 52 + Puerto Rico + Guam
    for (state in states) {
        df_state <- subset(df, df$State == state)
        if (num == "best") {
            ans[state, 1] <- df_state[1, 1]
        } else if (num == "worst") {
            ans[state, 1] <- df_state[nrow(df_state), 1]
        } else {
            nth <- as.integer(num)
            ans[state, 1] <- df_state[nth, 1]
        }
    }
    ans
}

## Testing
## source("rankall.R")
## 1) r <- rankall("heart attack", 4)
##    as.character(subset(r, state == "HI")$hospital)
##    [1] "CASTLE MEDICAL CENTER"

## 2) r <- rankall("pneumonia", "worst")
##    as.character(subset(r, state == "NJ")$hospital)
##    [1] "BERGEN REGIONAL MEDICAL CENTER"

## 3) r <- rankall("heart failure", 10)
##    as.character(subset(r, state == "NV")$hospital)
##    [1] "RENOWN SOUTH MEADOWS MEDICAL CENTER"
