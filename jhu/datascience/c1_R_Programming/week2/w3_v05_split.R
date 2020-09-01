# V05_split
# > str(split)
# function (x, f, drop = FALSE, ...)

# split(1:21, gl(3,7)) same as x<-1:21; f <- gl(3,7); split(x, f)
# $`1`
# [1] 1 2 3 4 5 6 7

# $`2`
# [1]  8  9 10 11 12 13 14

# $`3`
# [1] 15 16 17 18 19 20 21

# > lapply(split(1:21, gl(3,7)), mean)
# $`1`
# [1] 4

# $`2`
# [1] 11

# $`3`
# [1] 18


# > library(datasets)
# > head(airquality)
# Ozone Solar.R Wind Temp Month Day
# 1 41 190 7.4 67 5 1
# 2 36 118 8.0 72 5 2
# 3 12 149 12.6 74 5 3
# 4 18 313 11.5 62 5 4
# 5 NA NA 14.3 56 5 5
# 6 28 NA 14.9 66 5 6

s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))

lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T))

# > sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) 
# 5         6          7        8        9
# Ozone         NA        NA         NA       NA       NA
# Solar.R       NA 190.16667 216.483871       NA 167.4333
# Wind    11.62258  10.26667   8.941935 8.793548  10.1800
# > sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T)) 
# 5         6          7          8         9
# Ozone    23.61538  29.44444  59.115385  59.961538  31.44828
# Solar.R 181.29630 190.16667 216.483871 171.857143 167.43333
# Wind     11.62258  10.26667   8.941935   8.793548  10.18000
