### Linear model ###

set.seed(1224)

min = -1
max = 1
step = 0.01

x <- seq(min,max,step)
y <- rnorm(length(x))

df <- data.frame(x = x,
                 y = x+y)

modFit <- lm(y ~ x,df)
fn <- function(x) {x*modFit$coefficients[2]+modFit$coefficients[1]}

plot(df)
curve(fn,min,max,add=T,lwd=3,col="red")


### Linear prediction ###

set.seed(1224)
library(caret)

inTrain <- createDataPartition(df$y,p=0.7,list=F)
training <- df[inTrain,]
testing <- df[-inTrain,]

modFit <- lm(y ~ x, training)

plot(training,col="blue")
points(testing,col="green")
curve(fn,min,max,add=T,lwd=3,col="red")

