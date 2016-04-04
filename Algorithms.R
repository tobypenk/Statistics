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






# Chapter 2 exercises

## 2-1
mystery <- function(n) {
        r <- 0
        
        for (i in 1:(n-1)) {
                for (j in (i+1):n) {
                        for (k in 1:j) {
                                r <- r + 1
                        }
                }
        }
        
        r
}

# The answer:
mysteryCalc <- function(n) {
        # This turns out to be a cubic function, which is not surprising considering
        #       that the problem statement consists of three nested loops.
        (1/3)*n*(n+1)*(n-1)
}

x <- 1:20
y <- c()
for (i in 1:20) {y <- c(y,mystery(i))}

plot(x,y)



## 2-2
pesky <- function(n) {
        r <- 0
        
        for (i in 1:n) {
                for (j in 1:i) {
                        for (k in j:(i+j)) {
                                r <- r + 1
                        }
                }
        }
        
        r
}

# The answer:
peskyCalc <- function(n) {
        (1/6)*n*(n+1)*((2*n)+1) + (1/2)*n*(n+1)
}

x <- 1:20
y <- c()
for (i in 1:20) {y <- c(y,pesky(i))}

plot(x,y)



## 2-3
prestiferous <- function(n) {
        r <- 0
        
        for (i in 1:n) {
                for (j in 1:i) {
                        for (k in j:(i+j)) {
                                for (l in 1:(i+j-k)) {
                                        r <- r + 1
                                }
                        }
                }
        }
        
        r
}

prestyCalc <- function(n) {
        (1/4)*(n^4 + 4*n^3 + 5*n^2 + 2*n)
}

x <- 1:20
y <- c()
for (i in 1:20) {y <- c(y,prestiferous(i))}

plot(x,y)



