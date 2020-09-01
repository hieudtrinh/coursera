add2 <- function(x, y) {
  x + y
}

above <- function(x, n = 10) {
  use <- x > n
  x[use]
}

columnmean <- function(x, removeNA = TRUE) {
  nc <- ncol(x)
  means <- ncol(x)
  for (i in 1:nc) {
    means[i] <- mean(x[, i], na.rm = removeNA)
  }
  means
}

evaluate <- function(myfunction, dat) {
  sum <- function(dat) {
    sum(dat)
  }
  
  median <- function(dat) {
    median(dat)
  }
  
  floor <- function(dat) {
    floor(dat)
  }
  
  myfunction(dat)
}
