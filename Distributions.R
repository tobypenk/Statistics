# This script contains PDF/PMF and CDF functions for many common distributions.
#       These functions are available in base R; however, I made this script to test
#       and expand my understanding of statistical distributions.

library(manipulate)
library(stats)
library(graphics)


##### Uniform Distribution #####
# Models an event for which all x are equally likely.
# If f(x) = 1/(b-a) for x ∈ [a,b], and 0 otherwise, then X ~ Uniform(a,b)
# Alternatively, for a discrete distribution, f(x) = 1/k for x ∈ 1:k, and 0 otherwise.

### PMF ###

a.init <- 5
b.init <- 20

manipulate(plot(x <- a:b,
                rep(1/(b-a),b-a+1)),
           a = slider(min=0,
                      max=20,
                      initial=a.init),
           b = slider(min=20,
                      max=40,
                      initial = b.init))


### CDF ###


a.init <- 5
b.init <- 20

manipulate(plot(x <- a:b,
                (x-a)/(b-a)),
                #cumsum(rep(1/(b-a),b-a+1))),
           a = slider(min=0,
                      max=20,
                      initial=a.init),
           b = slider(min=20,
                      max=40,
                      initial = b.init))


##### Binomial Distribution #####
# X ~ Binomial(n,p) for p ∈ [0,1]
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




##### Bernoulli Distribution #####
# Special case of the binomial distribution for which n = 1.
# If P(X = 1) = p and P(X = 0) = 1 - p for some p ∈ [0, 1], then X ~ Bernoulli(p).
# Support set = {0,1}

### PMF ###
p.init <- 0.5
x <- c(0,1)

manipulate(plot(x,
                (p^x)*((1-p)^(1-x)),
                asp=1),
           p = slider(min=0,
                      max=1,
                      initial=p.init))


### CDF ###

p.init <- 0.5
x <- c(0,1)

manipulate(plot(x,
                cumsum((p^x)*((1-p)^(1-x))),
                asp=1),
           p = slider(min=0,
                      max=1,
                      initial=p.init))



##### Normal Distribution #####
# Also called the Gaussian distribution.  Notation is X ~ N(μ,σ^2) if
#       f(x) = (1/(σ*sqrt(2*pi)))*exp((1/2*σ^2)*(x-μ)^2); x ∈ R.
# μ = Mean
# σ^2 = Standard Deviation
# When μ == 0 & σ^2 == 1; this is a Standard Normal Distribution; PDF = Φ(z); CDF = φ(z)
# 


### PMF ###

x.min.init <- -20
x.max.init <- 20
μ.init <- 0
σ.init <- 4

manipulate(plot(x <- x.min:x.max,
                (1/(σ*sqrt(2*pi)))*exp((-1/(2*σ^2))*(x-μ)^2)),
           x.min = slider(min=-100,
                          max=0,
                          initial=x.min.init),
           x.max = slider(min = 0,
                          max = 100,
                          initial = x.max.init),
           μ = slider(min = -100,
                      max = 100,
                      initial = μ.init),
           σ = slider(min = 0,
                      max = 20,
                      initial = σ.init))


### CDF ###

x.min.init <- -20
x.max.init <- 20
μ.init <- 0
σ.init <- 4

manipulate(plot(x <- x.min:x.max,
                cumsum((1/(σ*sqrt(2*pi)))*exp((-1/(2*σ^2))*(x-μ)^2))),
           x.min = slider(min=-100,
                          max=0,
                          initial=x.min.init),
           x.max = slider(min = 0,
                          max = 100,
                          initial = x.max.init),
           μ = slider(min = -100,
                      max = 100,
                      initial = μ.init),
           σ = slider(min = -20,
                      max = 20,
                      initial = σ.init))



##### Exponential Distribution #####
# X ~ Exp(β) for β > 0 and x > 0 if f(x) = (1/β)*e^(-x/β)
# Used to model, for example, lifetimes of components or waiting times between events.
# Models time between events in a Poisson process (continuous, independent, and constant
#       average density).
# Same as the Gamma distribution for X ~ Gamma(1,β)
# 1/β is also sometimes notated λ, so that f(x) = λ*e^(-λx)
# Memoryless in that P(X > a+b | X > a) = P(X > b).  In other words, if you've already
#       waited an hour for a customer, your chances of waiting another hour are the
#       same as your chance was of having to wait the first hour to begin with; there's
#       no "buildup" that makes customers more likely with time (assuming customers are
#       exponentially distributed).


### PDF ###
x.max.init <- 20
β.init <- 1
e <- exp(1)

manipulate(plot(x <- 0:n,
                (1/β)*e^(-x/β)),
           n = slider(min=0,
                      max=100,
                      initial=x.max.init),
           β = slider(min=0,
                      max=10,
                      initial=β.init))


### CDF ###

x.max.init <- 20
β.init <- 1
e <- exp(1)

manipulate(plot(x <- 0:n,
                1 - e^(-x/β)),
           n = slider(min=0,
                      max=100,
                      initial=x.max.init),
           β = slider(min=0,
                      max=10,
                      initial=β.init))




##### Gamma Distribution #####
# Γ(α) = integrate(y^(α-1)*e^(-y), 0, Inf) for α > 0.
# X ~ Gamma(α,β) for x > 0, β > 0, and α > 0 if f(x) = 1/(β^α*Γ(α))*x^(α-1)*e^(-x/β)
# Support set is x ∈ (0,Inf)
# α = shape parameter; β = scale parameter.

x.max.init <- 20
α.init <- 1
β.init <- 1
e <- exp(1)

gammaFunction <- function(x,α) {
        x^(α-1)*exp(-x)
}

manipulate(plot(x <- seq(0,n,0.1),
                1/((β^α)*integrate(function(x,t = α) {x^(t-1)*exp(-x)}, 0, Inf)$value)*x^(α-1)*e^(-x/β),
                type="l"),
           n = slider(min=0,
                      max=200,
                      initial=x.max.init),
           α = slider(min=0,
                      max=20,
                      initial = α.init,
                      step = 0.5),
           β = slider(min=0,
                      max=20,
                      initial = β.init,
                      step = 0.5))

##### Geometric Distribution #####
# X ~ Geom(p) for p ∈ [0,1]
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
# X ~ Poisson(l) for l ∈ [0,1]
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

