bubbleSort <- function(x) {
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