noise <- function(n, mean, sd) {
  rnorm(n, mean, sd)
}


generate_noise <- function() {
  list(noise(1,1,2), noise(2,2,2), noise(3,3,2), noise(4,4,2), noise(5,5,2))
}

same_as_generate_noise <- function() {
  mapply(noise, 1:5, 1:5, 2)
}

noise(5,1,2)

noise(1:5,1:5,2)

