# This script contains PDF/PMF and CDF functions for many common distributions.
#       These functions are available in base R; however, I made this script to test
#       and expand my understanding of statistical distributions.

library(manipulate)
library(stats)
library(graphics)


##### Binomial Distribution #####
# X ~ Binomial(n,p) for p in [0,1]
# Models the likelihood that the number of heads is equal to x after n trials.

### PMF ###

n.init <- 10
p.init <- 0.5

manipulate(plot(x <- 0:n,
                choose(n,x) * p^x * ((1 -p)^(n - x)),
                pch=20,
                col="blue"),
           p=slider(0,
                    1,
                    initial = p.init),
           n=slider(1,
                    1000,
                    initial=n.init))

### CDF ###

n.init <- 10
p.init <- 0.5

manipulate(plot(x <- 0:n,
                cumsum(choose(n,x) * p^x * ((1 -p)^(n - x))),
                pch=20,
                col="blue"),
           p=slider(0,
                    1,
                    initial = p.init),
           n=slider(1,
                    1000,
                    initial=n.init))



##### Geometric Distribution #####
# X ~ Geom(p) for p in [0,1]
# Models the number of trials needed before a success

### PDFs: ###
# Trials before success version:

k.min <- 1
k.max <- 100

manipulate(plot(k.min:k.max,
                p*(1-p)^(k.min:k.max-1),
                type="l"),
           p=slider(0,
                    1,
                    initial=0.5),
           k.max=slider(k.min+1,
                        1000,
                        initial=k.max))

# Failures before success version (sometimes called shifted geometric distribution):

k.min <- 0
k.max <- 100

manipulate(plot(k.min:k.max,
                p*(1-p)^(k.min:k.max),
                type="l"),
           p=slider(0,
                    1,
                    initial=0.5),
           k.max=slider(k.min+1,
                        1000,
                        initial=k.max))

# The only difference between the two distributions is their support set; in the former case, the support set is {1,2,3...},
#       whereas in the latter, the support set is {0,1,2...}

### CDFs: ###
# Trials before success version:

k.min <- 1
k.max <- 15

manipulate(plot(stepfun(k.min:k.max,
                        1-(1-p)^((k.min-1):k.max)),
                verticals = F),
           p=slider(0,
                    1,
                    initial=0.5))

# Failures before success version:

k.min <- 0
k.max <- 15

manipulate(plot(stepfun(k.min:k.max,
                        1-(1-p)^((k.min-1):k.max+1)),
                verticals = F),
           p=slider(0,
                    1,
                    initial=0.5))
