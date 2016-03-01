# This file is filled with functions that are already present in base R or 
#       extension libraries; however, I am replicating them in order to become
#       more familiar with their meanings.

getSum <- function(numbers) {
        total <- 0
        
        addNumber <- function(number) {
                total <<- total + number
        }
        
        lapply(numbers,addNumber)
        
        total
}

dotProduct <- function(vector1,
                       vector2,
                       cycle = F) {
        # Returns the dot product of two vectors; the only difference between this
        #       function and (vector1 * vector2) in R is the warning; this function will
        #       throw an error if the vectors are of unequal lengths unless cycle = T.
        
        if (length(vector1) != length(vector2)) {
                if (cycle == F) {
                        stop("Vectors are of unequal lengths.")
                } else {
                        if (length(vector1) > length(vector2)) {
                                longer <- vector1
                                shorter <- vector2
                        } else {
                                longer <- vector2
                                shorter <- vector1
                        }
                }
        } else {
                longer <- vector1
                shorter <- vector2
        }
        
        returnVector <- character(length(longer))
        
        for (i in 1:length(longer)) {
                
                if (i %% length(shorter) == 0) {
                        shortIndex <- length(shorter)
                } else {
                        shortIndex <- i %% length(shorter)
                }
                
                a <- longer[i]
                b <- shorter[shortIndex]
                returnVector[i] <- a * b
        }
        
        returnVector
}



