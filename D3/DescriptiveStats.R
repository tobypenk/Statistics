# This file is filled with functions that are already present in base R or 
#       extension libraries; however, I am replicating them in order to become
#       more familiar with their meanings and optimization.

### sum() ###
getSum <- function(numbers) {
        total <- 0
        
        addNumber <- function(number) {
                total <<- total + number
        }
        
        lapply(numbers,addNumber)
        
        total
}

### prime test ###
isPrime <- function(number) {
        # Could be made more efficient by starting with a saved vector of primes up
        #       to the square root of the given number.
        
        if (number %% 2 == 0) {
                return(T)
        } else {
                for (i in 2:ceiling(sqrt(number))) {
                        if (number %% i == 0) {
                                return(F)
                        }
                }
        }
        
        T
}



