# This script contains PDF/PMF and CDF functions for many common distributions.
#       These functions are available in base R; however, I made this script to test
#       and expand my understanding of statistical distributions.

library(manipulate)
library(stats)
library(graphics)


##### Discrete Uniform Distribution #####
# Models an event which is equally likely for all x.
# If f(x) = 1/k for x in 1:k, and 0 otherwise, then X ~ Unif(k)

### PMF ###

k.init <- 20

manipulate(plot(x <- 1:k,
                rep(1/k,k)),
           k = slider(min=1,
                      max=100,
                      initial=k.init))


### CDF ###

k.init <- 20

manipulate(plot(stepfun(x <- 1:k,
                        cumsum(rep(1/k,k+1))),
           verticals = F),
           k = slider(min=1,
                      max=100,
                      initial=k.init))




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



##### Poisson Distribution #####
# X ~ Poisson(l) for l in [0,1]
# A model for counts of infrequent events

# Assumptions:
#       The number of times the event can occur is an integer
#       Probabilities are independent from one event to the next
#       Probability is not a function of time
#       Two events cannot occur at the exact same time
#       Probability of occurrence in an interval is proportional to the length of that interval

# l (Lambda) represents the average number of occurrences in an interval.
# The probability of exactly x occurrences in a given interval is given by:
#               (e^(-l))*(l^x)/factorial(x)
#       where x is an integer.


### PMF: ###
# Say the average number of successes per x flips is l; then what is the chance of getting
#       exactly x successes?

x.init <- 20
l.init <- 10
e <- exp(1)

manipulate(plot(x <- 0:n,
                (e^(-l))*(l^x)/factorial(x)),
           l=slider(min=0,
                    max=200,
                    initial=l.init),
           n=slider(0,
                    200,
                    initial=x.init))

### CDF: ###
# What is the chance of needing at least x flips to get l successes?

x.init <- 20
l.init <- 10
e <- exp(1)

manipulate(plot(stepfun(x <- 0:n,
                        cumsum((e^(-l))*(l^c(x,n+1))/factorial(c(x,n+1)))),
                verticals = F),
           l=slider(min=0,
                    max=200,
                    initial=l.init),
           n=slider(0,
                    200,
                    initial=x.init))

