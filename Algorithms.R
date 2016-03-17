multiply <- function(a,b,c) {
        if (b == 0) {
                return(0)
        } else {
                multiply(c*a,floor(b/c),c) + a * b %% c
        }
}

horner <- function(a,x) {
        # Works by 'building up' the exponents of the x values by adding the a values
        #       and then multiplying the subset by x
        p <- a[length(a)]
        
        for (i in (length(a)-1):1) {
                p <- p*x + a[i]
        }
        p
}

bubbleSort <- function(x) {
        # Works by moving the largest entry in the set all the way to the right and then
        #       considering the set of n - 1 items and doing the same thing
        for (i in length(x):2) {
                for (j in 1:(i-1)) {
                        if (x[j] > x[j+1]) {
                                jPlusOne <- x[j+1]
                                x[j+1] <- x[j]
                                x[j] <- jPlusOne
                        }
                }
        }
        x
}