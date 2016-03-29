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

nearestNeighbor <- function(x,y,startIndex) {
        
        df <- data.frame(x=x,y=y,i=seq(1:length(x)),p=0)
        
        getDistance <- function(index.one,index.two) {
                
                sqrt((df$x[index.one]-df$x[index.two])^2+(df$y[index.one]-df$y[index.two])^2)
        }
        
        df$p[startIndex] <- 1
        totalDist <- 0
        
        for (i in 2:nrow(df)) {
                subDf <- df[df$p == 0,]

                last.i <- df$i[df$p == max(df$p)]
                
                minDist <- getDistance(last.i,subDf$i[1])
                minInd <- subDf$i[1]
                
                for (j in 1:nrow(subDf)) {

                        thisDist <- getDistance(last.i,subDf$i[j])
                        
                        if (thisDist < minDist) {
                                minDist <- thisDist
                                minInd <- subDf$i[j]
                        }
                }
                totalDist <- totalDist + minDist
                df$p[df$i == minInd] <- max(df$p) + 1
        }
        
        totalDist <- totalDist + getDistance(1,df$i[df$p == max(df$p)])
        
        print(totalDist)
        df
}

set.seed(1224)
n <- 50
x <- round(rnorm(n)*n)
y <- round(rnorm(n)*n)

df <- nearestNeighbor(x,y,2)

library(ggplot2)

ggplot(df, aes(x,y)) +
        geom_point() +
        geom_text(aes(label=p),nudge_y = n/10)
