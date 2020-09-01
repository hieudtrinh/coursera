# learn tapply()
# str(tapply)
# function (X, INDEX, FUN = NULL, ..., default = NA, simplify = TRUE)  

# X is a vector
# INDEX is a factor or a list of factors (or else they are coerced to factors)
# FUN is a function to be applied
# ... contains other arguments to be passed FUN
# simplify, should we simplify the result?

x <- c(rnorm(10), rnorm(10), rnorm(10,1))

f <- gl(3, 10)

# > x
# [1]  3.945878e-01 -1.480084e+00  1.148192e+00 -7.508954e-01  6.768849e-01 -8.566145e-01 -7.959657e-02
# [8]  1.204949e-01  9.439468e-02 -2.267566e-05  1.275059e+00  1.415268e+00 -2.630022e-01 -1.107745e+00
# [15]  8.102548e-01  3.823773e-01  3.964246e-02  6.908771e-02  1.723403e+00 -7.866992e-01  1.871840e+00
# [22]  3.763765e+00  1.648641e+00  1.585106e+00  3.911902e-02  1.060463e+00  1.905114e+00  9.209272e-01
# [29]  9.679973e-02  1.199107e+00

apply(x, f, mean)
# -0.07326587  0.35576461  1.40908823 

# x[1:10]
# [1]  3.945878e-01 -1.480084e+00  1.148192e+00 -7.508954e-01  6.768849e-01 -8.566145e-01 -7.959657e-02
# [8]  1.204949e-01  9.439468e-02 -2.267566e-05

mean(x[1:10])
# [1] -0.07326587
mean(x[11:20])
# [1] 0.3557646
mean(x[21:30])
# [1] 1.409088
